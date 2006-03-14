Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752036AbWCNBxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbWCNBxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWCNBxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:53:44 -0500
Received: from fmr17.intel.com ([134.134.136.16]:21918 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752032AbWCNBxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:53:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Tue, 14 Mar 2006 09:48:36 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B2DB6BF@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZGsgIBdUK0SghnTlKQwQGuyPJymQAVgtBA
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
X-OriginalArrivalTime: 14 Mar 2006 01:48:41.0937 (UTC) FILETIME=[6C07DC10:01C64709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hmm, could you file dmesgs with thermal module loaded and unloaded?
>
>Filed at bugzilla.

Excellent! .

>Let me know if there's a different permutation of debug options that I
>should try.  I wasn't sure whether you meant that I should leave all
>the debug values at 0x10.  Or whether I should still include
>acpi_debug=0xffffffff on top of the other options.

So far, it's ok,  I saw these,  Could you do bisection to find out
which methods or which thermal zone cause trouble?
To do that, you have to hack thermal.c by commenting out 
some calls of evaluating methods below.
I hope it is easy for you!	 :-)

Thanks,
Luming

Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
Execute Method: [\_TZ_.THM0._SCP] (Node c157bec8)
Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
ACPI: Thermal Zone [THM0] (47 C)
Execute Method: [\_TZ_.THM2._TMP] (Node c157bb88)
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_TZ_.THM2._SCP] (Node c157bac8)
Execute Method: [\_TZ_.THM2._TMP] (Node c157bb88)
Execute Method: [\_TZ_.PFN0._ON_] (Node c157a2c8)
Execute Method: [\_TZ_.PFN0._STA] (Node c157a308)
ACPI: Thermal Zone [THM2] (40 C)
Execute Method: [\_TZ_.THM6._TMP] (Node c157b948)
Execute Method: [\_TZ_.THM6._AC0] (Node c157b908)
Execute Method: [\_TZ_.THM6._SCP] (Node c157b888)
Execute Method: [\_TZ_.THM6._TMP] (Node c157b948)
ACPI: Thermal Zone [THM6] (30 C)
Execute Method: [\_TZ_.THM7._TMP] (Node c157b708)
Execute Method: [\_TZ_.THM7._AC0] (Node c157b6c8)
Execute Method: [\_TZ_.THM7._SCP] (Node c157b648)
Execute Method: [\_TZ_.THM7._TMP] (Node c157b708)
ACPI: Thermal Zone [THM7] (33 C)

