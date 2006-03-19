Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWCSEMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWCSEMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 23:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWCSEMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 23:12:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:53556 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751379AbWCSEMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 23:12:33 -0500
X-IronPort-AV: i="4.03,107,1141632000"; 
   d="scan'208"; a="14259447:sNHT29595573"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Sun, 19 Mar 2006 12:12:09 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC26C@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZKyJseFIApotTBQ26vJ/8spHMO3QAPbwMQ
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
X-OriginalArrivalTime: 19 Mar 2006 04:12:11.0484 (UTC) FILETIME=[4BC939C0:01C64B0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do you load processor driver?
>
>It's loads at boot.  When thermal loads, it pulls in processor:
>
>$ lsmod | grep thermal
>thermal                17224  0 
>processor              30080  1 thermal
>

Maybe I need to make a summary here for this issue:
1. The s3 hang is in While-loop in SMPI that looks like
waiting BIOS response.
2. If THM2, THM6, THM7 disabled, disabling THM0._TMP
fix the s3 hang.

I think you need to continue to find out which THMs, which methods
cause s3 hang when THM0._TMP disabled.
I assume the problem is:
THM0._TMP && THMx._XXX && THMy._YYY..

Thanks,
Luming
