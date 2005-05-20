Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVETVOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVETVOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVETVOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:14:20 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:42254 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S261592AbVETVOR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:14:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] Proposed: Let's not waste precious IRQs...
Date: Fri, 20 May 2005 16:14:05 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04BA3@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] Proposed: Let's not waste precious IRQs...
Thread-Index: AcVdejzG7ctZOYq7R2+/YgvHKLwsFAABWIcA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Ashok Raj" <ashok.raj@intel.com>
Cc: <akpm@osdl.org>, <ak@suse.de>, <zwane@arm.linux.org.uk>,
       "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 May 2005 21:14:03.0005 (UTC) FILETIME=[D922A2D0:01C55D80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 20 May 2005 7:45 am, Ashok Raj wrote:
> > have you taken a look a the Vector Sharing Patch posted by 
> Kaneshige for IA64?
> 
> Vector sharing has a performance cost, so we should avoid it 
> when we can.
> 
> I think you should bounds-check the gsi_to_irq[] references.  
> When you finally get a machine with GSI values larger than 
> MAX_GSI_NUM, things will start failing mysteriously as you 
> corrupt things after the gsi_to_irq[] array.
>
Yes, indeed, I will do that. Next round I will submit ACPI cases for
i386 and x86_64 then, with correction above, and will start working on
the MPS cases.

Thanks,
--Natalie 
