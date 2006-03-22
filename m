Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWCVH3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWCVH3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWCVH3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:29:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:52521 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751055AbWCVH3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:29:19 -0500
X-IronPort-AV: i="4.03,117,1141632000"; 
   d="scan'208"; a="14561145:sNHT22073366"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 22 Mar 2006 15:28:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B418018@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZNgIhE+rsWpxqaQXKJBMR4Y8gZkAAAJyWw
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
X-OriginalArrivalTime: 22 Mar 2006 07:28:45.0970 (UTC) FILETIME=[41163720:01C64D82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Since I don't think Fatal() isn't being called, I guess the problem is
>in I2RB.  But all those magic numbers in I2RB make me recultant to take
>out lines, unless you tell me which changes won't harm the hardware.
>

How about this. The side effect of this change is that _BIF, _BST could
NOT
work. But I think it's just ok.


                    Method (I2RB, 3, NotSerialized)
                    {
                        Store (Arg0, HCSL)
                        Store (ShiftLeft (Arg1, 0x01), HMAD)
                        Store (Arg2, HMCM)
                        Store (0x0B, HMPR)
          /*              Return (CHKS ())*/
                    }
