Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268424AbTAMX0c>; Mon, 13 Jan 2003 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268425AbTAMX0b>; Mon, 13 Jan 2003 18:26:31 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:49196 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S268424AbTAMX01> convert rfc822-to-8bit; Mon, 13 Jan 2003 18:26:27 -0500
content-class: urn:content-classes:message
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 15:35:10 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D106B@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC version
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK7WaGUA82PHidMEdetAABQi+Bv6wAANIIg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Zwane Mwaikambo" <zwane@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2003 23:35:10.0957 (UTC) FILETIME=[6A0011D0:01C2BB5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think the array apic_version[] is very helpful in the first place.
I suspect it can be __init. 

Jun

> -----Original Message-----
> From: Protasevich, Natalie [mailto:Natalie.Protasevich@UNISYS.com]
> Sent: Monday, January 13, 2003 3:15 PM
> To: 'Zwane Mwaikambo'; Nakajima, Jun
> Cc: Protasevich, Natalie; Martin J. Bligh; Pallipadi, Venkatesh; William
> Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux Kernel
> Subject: RE: APIC version
> 
> As for apic_version[] indexing in general, I am also for smp_processor_id,
> although it could take a few changes in apic.c, mpparse.c, and especially
> smpboot.c. Speaking of es7000, its APIC ID's are always huge, defined by
> fixed topology. For those like us, the array would shrink from MAX_APICS
> (256) to NR_CPUS (32, maybe 64). I wonder if it would do any good for
> (true)
> NUMA.
> 
> --Natalie
> 
> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@holomorphy.com]
> Sent: Monday, January 13, 2003 3:53 PM
> To: Nakajima, Jun
> Cc: Protasevich, Natalie; Martin J. Bligh; Pallipadi, Venkatesh; William
> Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux Kernel
> Subject: RE: APIC version
> 
> 
> On Mon, 13 Jan 2003, Nakajima, Jun wrote:
> 
> > The entries in acpi_version[] are indexed by the APIC id, not
> > smp_processor_id(). So you can overwrite acpi_version[] for a different
> > processor.
> 
> Is it possible to use smp_processor_id instead to avoid wasting memory
> for the sparse APIC id case?
> 
> 	Zwane
> --
> function.linuxpower.ca
