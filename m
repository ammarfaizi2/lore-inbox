Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268318AbTAMTqr>; Mon, 13 Jan 2003 14:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268319AbTAMTqr>; Mon, 13 Jan 2003 14:46:47 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:15532 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268318AbTAMTqp>; Mon, 13 Jan 2003 14:46:45 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8E8@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 13:55:00 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The thing is, this array never gets filled with correct values for XAPICs in
case when we go through ACPI, not MP.
I only care about it because that is how I used to distinguish Cascades from
Fosters on ES7000 (which I need to do very early, before I get to APIC mode
setup).

On the other hand, I just noticed that I could go with smp_num_siblings for
this purpose... so if this issue is too shady as of now, i will survive, I
guess...:)

--Natalie


-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com]
Sent: Monday, January 13, 2003 12:26 PM
To: Nakajima, Jun; Protasevich, Natalie; Pallipadi, Venkatesh
Cc: William Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux
Kernel
Subject: RE: APIC version


> The entries in acpi_version[] are indexed by the APIC id, not
smp_processor_id(). So you can overwrite acpi_version[] for a different
processor.

>> +	apic_version[smp_processor_id()] =

Ugh.

It's indexed by the apic ID, not the cpu id. They're not 1-1.

