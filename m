Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268403AbTAMXVc>; Mon, 13 Jan 2003 18:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTAMXVc>; Mon, 13 Jan 2003 18:21:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:30614 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268403AbTAMXVc>; Mon, 13 Jan 2003 18:21:32 -0500
Date: Mon, 13 Jan 2003 15:22:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Message-ID: <417390000.1042500178@flay>
In-Reply-To: <Pine.LNX.4.44.0301131752030.2102-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301131752030.2102-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The entries in acpi_version[] are indexed by the APIC id, not 
>> smp_processor_id(). So you can overwrite acpi_version[] for a different 
>> processor.
> 
> Is it possible to use smp_processor_id instead to avoid wasting memory 
> for the sparse APIC id case?

No, the array is set up in mpparse.c before we know the real processor 
numbers.

M.

