Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268396AbTAMXGi>; Mon, 13 Jan 2003 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTAMXGd>; Mon, 13 Jan 2003 18:06:33 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:63873 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268407AbTAMXG3>; Mon, 13 Jan 2003 18:06:29 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8EA@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 17:14:56 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As for apic_version[] indexing in general, I am also for smp_processor_id,
although it could take a few changes in apic.c, mpparse.c, and especially
smpboot.c. Speaking of es7000, its APIC ID's are always huge, defined by
fixed topology. For those like us, the array would shrink from MAX_APICS
(256) to NR_CPUS (32, maybe 64). I wonder if it would do any good for (true)
NUMA.

--Natalie

-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@holomorphy.com]
Sent: Monday, January 13, 2003 3:53 PM
To: Nakajima, Jun
Cc: Protasevich, Natalie; Martin J. Bligh; Pallipadi, Venkatesh; William
Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux Kernel
Subject: RE: APIC version


On Mon, 13 Jan 2003, Nakajima, Jun wrote:

> The entries in acpi_version[] are indexed by the APIC id, not 
> smp_processor_id(). So you can overwrite acpi_version[] for a different 
> processor.

Is it possible to use smp_processor_id instead to avoid wasting memory 
for the sparse APIC id case?

	Zwane
-- 
function.linuxpower.ca
