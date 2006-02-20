Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWBTIJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWBTIJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 03:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWBTIJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 03:09:58 -0500
Received: from fmr18.intel.com ([134.134.136.17]:47835 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932694AbWBTIJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 03:09:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] Re: Linux 2.6.16-rc3 
Date: Mon, 20 Feb 2006 16:07:23 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AFD4371@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] Re: Linux 2.6.16-rc3 
thread-index: AcY1D9ReaayeZ5pnRcSQfEWP0XoyxgA4zoKg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, <akpm@osdl.org>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       <James.Bottomley@steeleye.com>, <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <lk@bencastricum.nl>, <helgehaf@aitel.hist.no>, <fluido@fluido.as>,
       <gbruchhaeuser@gmx.de>, <Nicolas.Mailhot@LaPoste.net>, <perex@suse.cz>,
       <tiwai@suse.de>, <patrizio.bassi@gmail.com>, <bni.swe@gmail.com>,
       <arvidjaar@mail.ru>, <p_christ@hol.gr>, <ghrt@dial.kappa.ro>,
       <jinhong.hu@gmail.com>, <andrew.vasquez@qlogic.com>,
       <linux-scsi@vger.kernel.org>, <bcrl@kvack.org>
X-OriginalArrivalTime: 20 Feb 2006 08:07:25.0032 (UTC) FILETIME=[AEF67E80:01C635F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> I don't think anybody claimed this isn't a regression for the 600X.
>
>>> I narrowed it further.  The short story is that this commit (diff
>>> below sig) makes the second S3 sleep go into the endless loop, if
>>> the loaded modules are exactly thermal, processor, intel_agp, and
>>> agpgart:
>
>> If you believe this patch is the root cause of the regression you
>> have been seeing.
>
>Not sure if you were waiting for me to say something, but I do believe
>the change of default from ec_intr=0 to ec_intr=1 causes the problem
>for me.
>

I'm fine if you call this regression. :-) 
The real problem is there could be some bugs hidden by ec_intr=0.
I'm pretty sure your 600X box has thermal related issue that is breaking
2nd S3 suspend. But I don't know how.

ec_intr=1 just get these bug  just exposed on your box, 
and we need to work together to fix them. 

Thanks,
Luming
