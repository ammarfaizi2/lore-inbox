Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266769AbUHCRtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266769AbUHCRtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbUHCRtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:49:13 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:41618 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266769AbUHCRsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:48:16 -0400
Message-ID: <410FCF9A.0@rtr.ca>
Date: Tue, 03 Aug 2004 13:47:06 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <1091226922.5083.13.camel@localhost.localdomain> <410AEDC8.6030901@pobox.com>
In-Reply-To: <410AEDC8.6030901@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm the dude responsible for the infamous "50 milliseconds" here.

I agree that (1) it is overkill, (2) it could be optimised,
and (3) it is very very non-standard.

But it also works extraordinarilly well.  I still am very active
with ATA and SATA driver development, and the basic Linux IDE probe
works for me on vendor hardware where their own standards-specific
routines sometimes fail (even in their windows drivers).

If possible, it would be best to let it be, and over time it will
be less and less important as SATA and kin take over the universe.

Every time I tried to tweak it to be faster, it seemed to break
some system or another.

One possibility here would be to augment it with reset signature probing,
and/or a cyl-high read/write test.  These could speed things up for
more mainstream cases.  But I'm not going to touch what's there myself!

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
