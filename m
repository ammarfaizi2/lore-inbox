Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTILBke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbTILBke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:40:34 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:5101 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261640AbTILBkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:40:31 -0400
Message-ID: <1063330819.3f61240399462@dubai.stillhq.com>
Date: Fri, 12 Sep 2003 11:40:19 +1000
From: Michael Still <mikal@stillhq.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 PATCH] Squelch make mandocs warnings
References: <1063327887.3f61188f9947e@dubai.stillhq.com> <1063329183.4370.0.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063329183.4370.0.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

Alan, thanks for your prompt comments.

> Looks fine.

Ta.

> Technically xml docbook tags must be lower case but older
> SGML docbook is undefined.

For sure -- there are examples in the current kernel documentation which used
mixed case, which I personally feel is not as nice as lower case. I wanted to
tend on the side of working with whatever documentation we have though, and deal
with making the entire world pretty at some later date.

Note also that the patch only makes the internal handling of the tags case
insensitive -- it doesn't change the case of the tags in the kernel-doc, and it
respects the case the author chose when it emits the tags to the intermediate
SGML files used by mandocs.

> The /tmp handling still does want fixing
> though - it does several things that don't look remotely /tmp safe.

This patch was more a case of putting the temporary files where the user
expected them to be. To me, the risk associated with a poorly intentioned person
substituting incorrect manual pages for the internal kernel APIs is sufficiently
low that I am uncertain if it is worthwhile going with a patch to make this
safer. I'm quite content to be wrong on this point however -- do people feel
that making the mandocs scripts temporary file safe is an important goal?

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
