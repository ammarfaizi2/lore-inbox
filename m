Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267526AbSLSChQ>; Wed, 18 Dec 2002 21:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbSLSChQ>; Wed, 18 Dec 2002 21:37:16 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:10117 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267526AbSLSChM> convert rfc822-to-8bit; Wed, 18 Dec 2002 21:37:12 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Date: Wed, 18 Dec 2002 18:45:07 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E193@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcKm/pwqG5mvHxLxEdeNCQBQi+Bs2AACNPWg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <jamesclv@us.ibm.com>, "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Christoph Hellwig" <hch@infradead.org>
Cc: "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 19 Dec 2002 02:45:07.0638 (UTC) FILETIME=[A4361560:01C2A708]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> > On Wednesday 18 December 2002 05:05 pm, Pallipadi, Venkatesh wrote:
> > I am not really sure about the local APIC versions in summit. What I
> > remember seeing on lkml was summit has older IOAPIC 
> version. Can someone
> > clarify this?
> 
> Sure, I can verify it.  The I/O APICs in shipped summit 
> chipsets contains a 
> version ID of 0x11 instead of 0x14 to 0x1F.  The high 
> performance folks 
> claimed that Intel specified 0x14 for the local APICs, but 
> left their orange 
> jacket docs saying 0x1X for I/O APICs until after the chips taped out.
> 
> Whatever.  In any case, there are boxes in the field that 
> contain those 
> version numbers.  We can recognize them using the OEM and 
> product strings in 
> the MPS and ACPI tables, so it's only an annoyance.
> 

OK. In my patch I am looking at local APIC version > 0x14, to check xAPIC support.
This should work on all systems irrespective of IOAPIC version.
And even if there are problems here for summit, we can workaround it, by simply 
forcing xAPIC support at already existing OEM string check.


Thanks,
-Venkatesh 
