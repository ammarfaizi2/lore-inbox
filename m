Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWCOIE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWCOIE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWCOIE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:04:29 -0500
Received: from fmr20.intel.com ([134.134.136.19]:166 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751362AbWCOIE2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:04:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 15 Mar 2006 16:02:57 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32AC5E@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZH/z2c7aLkTjr+RSmHJC5Hw1umbwAB5JRA
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
X-OriginalArrivalTime: 15 Mar 2006 08:02:59.0570 (UTC) FILETIME=[E03C7520:01C64806]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So, before I begin that search, which THM0 methods can I safely get
>rid of?  All of AC0M, AC1M, PSL, TC1, TC2, TSP, TBL0, MODP, _CRT, AL0,
>PSL?  That'll leave MODE, _TMP, _AC0, _SCP, PSV to bisect among.

for example, I would  fake these methods in this way:

	 Method (_TMP, 0, NotSerialized)
            {
                    Return (0x0BB8)
            }

            Method (_PSV, 0, NotSerialized)
            {
                Return (0)
            }
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
Execute Method: [\_TZ_.THM0._SCP] (Node c157bec8)
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
