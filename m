Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTENWKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTENWKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:10:16 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:51865 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262942AbTENWKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:10:15 -0400
Message-Id: <200305142221.h4EMLRGi009323@locutus.cmf.nrl.navy.mil>
To: Greg KH <greg@kroah.com>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Wed, 14 May 2003 13:59:49 PDT."
             <20030514205949.GA3945@kroah.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 14 May 2003 18:21:27 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030514205949.GA3945@kroah.com>,Greg KH writes:
>Any reason to not just use a struct device here?  This is a device,
>right?  Or at the very least, a kobject would be acceptable.

actually, i think it should possibly be a netdevice.  eventually
i will consider this path.

>Please don't roll your own reference counting code, when we've already
>gotten a in-kernel version that has been debugged quite well.

netdevice has this which is why i would probably use that.  i would
also get kobject support for free there (or so i imagine)

>Is this going to help us be able to get rid of the MOD_* calls in ATM
>drivers soon?

no.  a later patch will get rid of those though.  next in the queue 
will be to make atm itself modular and make vcc's do reference counting
(via their struct sock parent).  i could fix the MOD_ nonsense next if
its really bothering you.

