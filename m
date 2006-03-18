Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWCRREg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWCRREg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWCRREg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:04:36 -0500
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:29854 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750703AbWCRREf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:04:35 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Sun, 19 Mar 2006 00:37:20 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC26A@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Sat, 18 Mar 2006 12:03:53 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKeqH-00011n-S6@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d7127db336fc7b5f9491ca83cf71fe24cc5350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> PM: Preparing system for mem sleep
>> Stopping tasks: 
>> =======================================================|

> Did you see any methods before and after this line in hang case on
> screen?  If yes, do you recall what they are?

I capture across a serial console, so here are the exact msgs (I just
ran the second sleep and got the usual hang).  This is with vanilla
2.6.16-rc5 (and vanilla DSDT):

Stopping tasks: =========================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
Execute Method: [\_S3_] (Node c157a988)
Execute Method: [\_PTS] (Node c157ab48)

The screen itself is full of garbage because the first sleep/wake messes
up the console.  Along with a giant white square that fills most of the
screen, I see a fuzzy, dotted version of the above messages, plus one
more line "ACPI" and then a flashing underscore cursor after that.  I
don't know if it was trying to printk "ACPI" but then the rest of the
message got lost, or it hung before printing it, or whether the ACPI is
from a previous dmesg (i.e. the first sleep/wake) that didn't get
cleared properly.

-Sanjoy
