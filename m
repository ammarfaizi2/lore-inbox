Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVEHR2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVEHR2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVEHR2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 13:28:46 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:4356 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S262903AbVEHR2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 13:28:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Date: Sun, 8 May 2005 12:28:26 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B51@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Thread-Index: AcVT1MfIJXn4FaURSrazSygboeoqzQAHfvOA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <zwane@arm.linux.org.uk>, <len.brown@intel.com>,
       <venkatesh.pallipadi@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2005 17:28:26.0735 (UTC) FILETIME=[57EEBFF0:01C553F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Sure, I will remove the io_apic_get_unique_id() then. 
> Perhaps, it will 
> > be easy to put it back in if someone implements a chipset 
> that needs it.
> 
> I did it myself now.
>

Ok, great, I was about to put it together, but you beat me to it :) You
probably don't need the "#define IO_APIC_MAX_ID		0xFE: line
anymore?
 
> > 
> > Andi, I submitted the patch for i386 a little while ago 
> > 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0505.0/0195.html
>  (I sent 
> > it to you also, but just noticed that it was not your usual email 
> > address - where did I get if from? have no idea...) Genapic in i386 
> > has a NO_IOAPIC_CHECK flag that is defined in every 
> subarch, so it was 
> > easy to fix the problem by making use of it in ACPI boot 
> path just as 
> > it was used in MP path.
> 
> That will not help on the other systems who don't have an own 
> subarchitecture but still run into problems with the check. 
> 
> I think the right strategy for i386 would be to remove this 
> check thing from the subarchitecture and implement the 
> heuristic described in the last mail.
> 
OK, I will do it next then. 
Thanks,
--Natalie
