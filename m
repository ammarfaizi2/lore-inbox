Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWCRRIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWCRRIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWCRRIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:08:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:52517 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750706AbWCRRIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:08:47 -0500
X-IronPort-AV: i="4.03,106,1141632000"; 
   d="scan'208"; a="14228708:sNHT75545246"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Sun, 19 Mar 2006 01:08:41 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC26B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZKriS2mz+vDn+dTBuBtWNgs2Xm5AAAFc7Q
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 18 Mar 2006 17:08:42.0388 (UTC) FILETIME=[9BB73D40:01C64AAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> PM: Preparing system for mem sleep
>>> Stopping tasks: 
>>> =======================================================|
>
>> Did you see any methods before and after this line in hang case on
>> screen?  If yes, do you recall what they are?
>
>I capture across a serial console, so here are the exact msgs (I just
>ran the second sleep and got the usual hang).  This is with vanilla
>2.6.16-rc5 (and vanilla DSDT):
>
>Stopping tasks: 
>=========================================================|
>Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
>Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
>Execute Method: [\_S3_] (Node c157a988)
>Execute Method: [\_PTS] (Node c157ab48)
>
>The screen itself is full of garbage because the first 
>sleep/wake messes
>up the console.  Along with a giant white square that fills most of the
>screen, I see a fuzzy, dotted version of the above messages, plus one
>more line "ACPI" and then a flashing underscore cursor after that.  I
>don't know if it was trying to printk "ACPI" but then the rest of the
>message got lost, or it hung before printing it, or whether the ACPI is
>from a previous dmesg (i.e. the first sleep/wake) that didn't get
>cleared properly.

Do you load processor driver?
