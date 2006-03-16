Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752188AbWCPGmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbWCPGmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbWCPGmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:42:31 -0500
Received: from fmr20.intel.com ([134.134.136.19]:25298 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752186AbWCPGma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:42:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Thu, 16 Mar 2006 14:41:27 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B37A678@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZIvacuxzv5JQmVQ+qYksyFun3oPQABn3og
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
X-OriginalArrivalTime: 16 Mar 2006 06:41:29.0798 (UTC) FILETIME=[A81E3660:01C648C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   hang iff (TMP & (PSV | AC0)).

Very interesting! 

I found the common code in _PSV and _AC0

 Store (DerefOf (Index (DerefOf (MODP (0x01)), Local1)), Local0)

Could you just comment out that?

We are very near at root-cause.

Thanks,
luming



