Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWCOBrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWCOBrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWCOBrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:47:37 -0500
Received: from fmr20.intel.com ([134.134.136.19]:23274 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932179AbWCOBrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:47:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 15 Mar 2006 09:46:30 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32A693@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZHQbG/v5y/PD5tTLSQX/C/EgssogAj77EQ
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
X-OriginalArrivalTime: 15 Mar 2006 01:46:31.0864 (UTC) FILETIME=[48EA0B80:01C647D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>[I've trimmed non-relevant lists (v4l-dvb-maintainer@linuxtv.org,
>video4linux-list@redhat.com, linux-ide@vger.kernel.org,
>linux-input@atrey.karlin.mff.cuni.cz,
>linux-usb-devel@lists.sourceforge.net) from the CC.  Let me know if
>anyone else wants to be trimmed.]
>
>> Could you do bisection to find out which methods or which thermal
>> zone cause trouble?  To do that, you have to hack thermal.c by
>> commenting out some calls of evaluating methods below.  I hope it is
>> easy for you!  :-)
>
>I eventually muddled my way there.  The short story is that I can
>reproduce the hang -- on the FIRST S3 cycle -- when the _TMP method is
>called a few times, just for THM0.  

Excellent!
Could you just comment out _TMP in kernel or in DSDT,
and do several  S3 suspend /resume  Cycles without remove thermal
module, 
I want to make sure we are at right place to drill down. 

Thanks for your  testing reports. It's impressive. :-)

--Luming
