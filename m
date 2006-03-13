Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWCMExo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWCMExo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCMExo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:53:44 -0500
Received: from fmr20.intel.com ([134.134.136.19]:13020 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932302AbWCMExm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:53:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Mon, 13 Mar 2006 12:51:57 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B2DAF0C@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZGWCzhiuvaVElATJegW7ioXoLSHgAAJxPA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       <v4l-dvb-maintainer@linuxtv.org>, <video4linux-list@redhat.com>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       <linux-input@atrey.karlin.mff.cuni.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 13 Mar 2006 04:52:02.0476 (UTC) FILETIME=[DE7326C0:01C64659]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I need the acpi trace log before _PTS to see what kind of thermal
>> related methods got called.
>
>Alas, I've included all the dmesg's.  

I need the full log  for S3 suspend failure not just snippets.
Please attach it on bugzilla.kernel.org

The log for S3 suspend success cannot help me to track down.


>
>Below is the script that I use to enter S3 sleep.  It unloads rid of
>troublesome modules and stop services that don't sleep well.  Then
>(for debugging) it sends the kernel version and boot parameters across
>the serial console (the @@@@ SLEEP line), raises the debug level to
>0x1F, does a sync (in case the sleep hangs, since this is my
>production machine), and then enters mem sleep.
>
>So nothing in it should trigger any thermal methods; except that I
>usually have the THM2 trip point raised to 45C with a polling time of
>100 seconds.  So once in a while a thermal poll will happen sleep is
>being set up.  I am not sure whether it would be reported in the
>dmesgs if it happened; but the S3 failure happens much more often than
>such a thermal polling would happen, so I doubt the S3 failure
>requires a thermal poll.

Could you try to mute thermal poll?
