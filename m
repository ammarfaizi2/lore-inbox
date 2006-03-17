Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752548AbWCQHLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbWCQHLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbWCQHLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:11:37 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:55772 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752548AbWCQHLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:11:36 -0500
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
In-Reply-To: Your message of "Fri, 17 Mar 2006 14:57:38 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC264@pdsmsx403> 
Date: Fri, 17 Mar 2006 07:11:32 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FK97U-00040S-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I wonder if this problem is the same as
<http://bugzilla.kernel.org/show_bug.cgi?id=5037>, about S3 hangs with
kernel pre-empts enabled.

> How about re-testing dummy _PSV and dummy _AC0 in DSDT?

I'll do that.  It's the one data point that I'm not sure about.  With
dummy _PSV, it hangs, though it takes a bit of stressing it before it
hangs.  But with dummy _PSV and dummy _AC0, I could not make it hang.
I tried it twice, each time stressing it as much as I could (about 10
or so cycles, with thermal polling thrown in as well as module loading
and unloading).  Even though it didn't hang, it did get *very*
sluggish at times, and once woke up with load=8.2 even though no
processes were running.  Lots of ACPI threads?

I'll test it just with sleep.sh, no thermal polling.  Maybe also with
loading and unloading thermal.ko.

> How about just faking _TMP in DSDT. I'm sure you have done this
> before.

This one I've tried, and it worked fine (no hang).  I tested it for a
while and then retested it.  It also works fine if I take out just the
EC0.UPDT line in _TMP (with AC0 already taken out).

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
