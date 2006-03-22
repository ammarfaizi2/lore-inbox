Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWCVBfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWCVBfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWCVBfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:35:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:58651 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751929AbWCVBfC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:35:02 -0500
X-IronPort-AV: i="4.03,116,1141632000"; 
   d="scan'208"; a="14930484:sNHT237976823"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 22 Mar 2006 09:34:53 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B417BB4@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZNNEtursw8IGHlRYyNMvpyDLBvlAAGbnrAAACTWPA=
From: "Yu, Luming" <luming.yu@intel.com>
To: "Yu, Luming" <luming.yu@intel.com>,
       "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
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
X-OriginalArrivalTime: 22 Mar 2006 01:34:46.0316 (UTC) FILETIME=[CD4436C0:01C64D50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hmm, you seems to prefer depth-first search algorithm?
>I like it too. :-)
>
>
>>
>>One bug is quite repeatable and we know a lot about it. With all zones
>>except THM0 commented out, the system hung.  With the EC0.UPDT line in
>>THM0._TMP also commented out, the system didn't hang.  So there's a
>>problem related to the EC, even with only THM0.  And finding that
>>problem may giveideas for what else may be wrong.
>
>We can do bisection in EC0.UPDT to find out which statement cause hang?
>Hmm, we are going to fix BIOS. :-)

You can insert debug statements in EC0.UPDT to help debug:

Store (IGNR, Debug)
Store (" before relase I2CM", Debug)
Store (HBS7, TMP7)	
....

>
>My assumption is that since Windows works well, then these BIOS code
>should have been tested ok. The only possible excuse for BIOS is that
>Linux is using unnecessary/untested code path for Suspend/resume.
>So, Eventually, we need to disable unnecessary BIOS call for 
>suspend/resume
