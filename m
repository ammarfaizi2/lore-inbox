Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268547AbTANDMd>; Mon, 13 Jan 2003 22:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268548AbTANDMd>; Mon, 13 Jan 2003 22:12:33 -0500
Received: from fmr02.intel.com ([192.55.52.25]:32215 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268547AbTANDMb> convert rfc822-to-8bit; Mon, 13 Jan 2003 22:12:31 -0500
content-class: urn:content-classes:message
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 18:26:12 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D108B@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC version
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK7XvWxy3AKeydQEdewWABQi2jYqAAFOBfA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Zwane Mwaikambo" <zwane@holomorphy.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jan 2003 02:26:13.0410 (UTC) FILETIME=[4EE62020:01C2BB74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can gather that info at runtime from the processors, when we really need it. And I don't think we have performance issues this that.

Jun

> -----Original Message-----
> From: Protasevich, Natalie [mailto:Natalie.Protasevich@UNISYS.com]
> Sent: Monday, January 13, 2003 3:49 PM
> To: 'Martin J. Bligh'; Zwane Mwaikambo; Nakajima, Jun
> Cc: Protasevich, Natalie; Pallipadi, Venkatesh; William Lee Irwin III;
> Christoph Hellwig; James Cleverdon; Linux Kernel
> Subject: RE: APIC version
> 
> If you index it by 4-bit GET_APIC_ID() (not GET_APIC_LOGICAL_ID()), i.e.
> hard_smp_processor_id(), you can get away with it.
> 
> Of course, it is possible that it can just be "don't care":
> 
> >I don't think the array apic_version[] is very helpful in the first
> place.
> >I suspect it can be __init.
> 
> >Jun
> 
> On the other hand, it might be needed if imagine hot plug CPU case.
> 
> 
> --Natalie
> 
> 
> 
> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> Sent: Monday, January 13, 2003 4:23 PM
> To: Zwane Mwaikambo; Nakajima, Jun
> Cc: Protasevich, Natalie; Pallipadi, Venkatesh; William Lee Irwin III;
> Christoph Hellwig; James Cleverdon; Linux Kernel
> Subject: RE: APIC version
> 
> 
> >> The entries in acpi_version[] are indexed by the APIC id, not
> >> smp_processor_id(). So you can overwrite acpi_version[] for a different
> >> processor.
> >
> > Is it possible to use smp_processor_id instead to avoid wasting memory
> > for the sparse APIC id case?
> 
> No, the array is set up in mpparse.c before we know the real processor
> numbers.
> 
> M.
