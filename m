Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTANXdH>; Tue, 14 Jan 2003 18:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTANXdH>; Tue, 14 Jan 2003 18:33:07 -0500
Received: from fmr02.intel.com ([192.55.52.25]:42702 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264903AbTANXdG>; Tue, 14 Jan 2003 18:33:06 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A11D@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: mpparse.c is a mess (was: APIC version)
Date: Tue, 14 Jan 2003 15:41:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> >> The entries in acpi_version[] are indexed by the APIC id, not 
> >> smp_processor_id(). So you can overwrite acpi_version[] 
> for a different 
> >> processor.
> > 
> > Is it possible to use smp_processor_id instead to avoid 
> wasting memory 
> > for the sparse APIC id case?
> 
> No, the array is set up in mpparse.c before we know the real 
> processor 
> numbers.

I just thought I'd mention, if anyone has any spare time or needs a
project, that it would be really nice if there was a more modular
interface for this stuff. Right now we have MPS code and ACPI code
messing with the same data structures (!!) and it is bug-prone and
confusing. Every time I try to fix anything that touches my area (ACPI
IRQ routing) I am paralyzed by fear that any change I make will break
something, because it is a big, swampy bog of code.

Regards -- Andy
