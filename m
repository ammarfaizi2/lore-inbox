Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSHZHBS>; Mon, 26 Aug 2002 03:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSHZHBS>; Mon, 26 Aug 2002 03:01:18 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:59895 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317947AbSHZHBR>; Mon, 26 Aug 2002 03:01:17 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDD5@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'jamesclv@us.ibm.com'" <jamesclv@us.ibm.com>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Date: Mon, 26 Aug 2002 00:05:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James Cleverdon [mailto:jamesclv@us.ibm.com] 
> > What happens when you use the FULL ACPI support? I suspect 
> that you really
> > do want the interpreter, in order to evaluate _PRTs properly.

> Bingo!  With full ACPI turned on, the system does indeed 
> boot.  The extra I/O 
> APIC entries are being programmed from the PRT.
> 
> (Call chain is:  pci_acpi_init --> acpi_pci_irq_init --> 
> mp_parse_prt --> 
> io_apic_set_pci_routing)
> 
> So, given that quite a number of our customers would like to run with 
> hyperthreading turned on, but do not want full ACPI, what is 
> the right thing 
> to do in the HT-only case?  Add extra code to process the 
> PRT?  Fall back on 
> MPS's IRQ records?  Something else entirely?

The solution is ACPI. Full ACPI. What is the problem? I have devoted too
much time already to make  hybrid ACPI/MPS combos work, but that will never
be the right solution.

Please have your customers email me privately and tell me why ~100KB of mem
on a 1GB+ system is something us engineers should spend our valuable time
hacking around, when the correct solution already is implemented and
*works*.

Regards -- Andy
