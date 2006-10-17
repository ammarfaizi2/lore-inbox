Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422952AbWJQCJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422952AbWJQCJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 22:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422963AbWJQCJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 22:09:28 -0400
Received: from [210.4.62.247] ([210.4.62.247]:12437 "HELO arribatel.com")
	by vger.kernel.org with SMTP id S1422952AbWJQCJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 22:09:27 -0400
X-Spam-Check-By: arribatel.com
Message-ID: <20061017100917.3od7d35ug4wgg0s4@mail.arribatel.com>
Date: Tue, 17 Oct 2006 10:09:17 +0800
From: j0rg3@arribatel.com
To: "Kagay-Anon Linux Users' Group (KLUG) Mailing List" 
	<klug@lists.linux.org.ph>
Cc: linux-kernel@vger.kernel.org
Subject: MP-BIOS bug: 8254 timer not connected to IO-APIC
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
X-Originating-IP: 210.4.62.245
X-Sent-Via: Mitel Networks SME Server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any patch or workarounds about this bug on 2.6.x kernel? I 
already googled this, there are patches on 2.4.x kernel but i dont like 
downgrading the kernel. Or if someone already did a kernel 
tweaking/hacking about these issues it would help.

NOTE: I don't think that there are bugs/problems on the BIOS because 
this box has been already tested and runs smoothly without any problems 
and issues on FreeBSD 6.1

## DMESG SHOWS THE MP-BIOS BUG ##
[root@localhost ~]# dmesg |grep -i APIC
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
Setting APIC routing to flat
..MP-BIOS bug: 8254 timer not connected to IO-APIC   <---*HERE'S THE SAID BUG*
Using local APIC timer interrupts.
Detected 12.436 MHz APIC timer.
ACPI: Using IOAPIC for interrupt routing
APIC error on CPU0: 04(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)

## THIS MACHINE HAS 1 SINGLE CORE AMD64 PROCESSOR #
[root@localhost ~]# dmesg |grep -i CPU
Initializing CPU#0
CPU 0: aperture @ 278000000 size 32 MB
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x1
APIC error on CPU0: 04(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)

##KERNEL VERSION AFTER I RECOMPILE IT BY HAND (without smp support and 
also tried w/o ACPI) but IT DID'NT HELP
[root@localhost ~]# uname -a
Linux localhost.org 2.6.18.1 #1 Sun Oct 15 23:19:17 EDT 2006 x86_64 
x86_64 x86_64 GNU/Linux


Best Regards,
  Jorge T. Monzor III
  Telecom Analyst
  Arriba Telecontact Inc.
  Rosario Arcade, Limketkai Center
  Cagayan de Oro City,Philippines 9000
  USDID# 1-305-508-5328 ext. 4
  Toll-Free# 1-866-394-0909
  URL: http://www.arribatel.com


