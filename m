Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUEFW3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUEFW3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUEFW3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 18:29:12 -0400
Received: from fmr10.intel.com ([192.55.52.30]:24741 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263124AbUEFW3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 18:29:01 -0400
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1083882514.2293.227.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 May 2004 18:28:36 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

        bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.27

        This brings 2.4.27 ACPI code up to date with the fixes in 2.6.6.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.27/acpi-20040326-2.4.27.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    5 
 arch/i386/kernel/acpi.c             |   49 +++++
 arch/i386/kernel/i8259.c            |    4 
 arch/i386/kernel/io_apic.c          |   18 --
 arch/i386/kernel/mpparse.c          |   46 ++---
 arch/i386/kernel/pci-pc.c           |    1 
 arch/x86_64/kernel/acpi.c           |   66 +++++--
 arch/x86_64/kernel/e820.c           |    6 
 arch/x86_64/kernel/i8259.c          |    4 
 arch/x86_64/kernel/io_apic.c        |   18 --
 arch/x86_64/kernel/mpparse.c        |   46 ++---
 arch/x86_64/kernel/pci-pc.c         |    2 
 arch/x86_64/kernel/setup.c          |    7 
 drivers/acpi/Config.in              |    2 
 drivers/acpi/Makefile               |    2 
 drivers/acpi/ac.c                   |    3 
 drivers/acpi/asus_acpi.c            |  121 ++++++++------
 drivers/acpi/battery.c              |   15 +
 drivers/acpi/bus.c                  |   20 +-
 drivers/acpi/button.c               |   36 ++++
 drivers/acpi/fan.c                  |    3 
 drivers/acpi/pci_irq.c              |    2 
 drivers/acpi/pci_link.c             |  201 ++++++++++++------------
 drivers/acpi/pci_root.c             |   16 +
 drivers/acpi/processor.c            |    7 
 drivers/acpi/tables.c               |    1 
 drivers/acpi/thermal.c              |    7 
 drivers/acpi/toshiba_acpi.c         |    5 
 include/asm-i386/acpi.h             |   36 ++--
 include/asm-x86_64/acpi.h           |   41 ++--
 include/linux/acpi.h                |    9 +
 31 files changed, 495 insertions(+), 304 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/05/06 1.1359.6.17)
   [ACPI] parse ACPI MCFG table and set pci_mmcfg_base_addr
   from 2.6 via Sundar/Dely Sy

<len.brown@intel.com> (04/05/06 1.1359.6.16)
   [ACPI] enhance "pci=noacpi" to skip PCI probe (David Shaohua Li)
   add "acpi=noirq" to just disable IRQ config
   http://bugzilla.kernel.org/show_bug.cgi?id=1662

<len.brown@intel.com> (04/05/04 1.1359.6.15)
   [ACPI] rmmod ACPI modules vs /proc
   from Anil S Keshavamurthy and David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=2457

<len.brown@intel.com> (04/05/04 1.1359.6.14)
   [ACPI] PCI Interrupt Link fixes
   
   Handle BIOS that reference disabled PCI Interrupt Link Devices
   http://bugme.osdl.org/show_bug.cgi?id=1581
   
   Clean up VIA _CRS = 0 BIOS workaround
   
   Handle BIOS returning _CRS outside _PRS
   http://bugme.osdl.org/show_bug.cgi?id=2567
   
   delete now unused _SRS retry code

<len.brown@intel.com> (04/05/04 1.1359.6.13)
   [ACPI] export symbols to button module

<len.brown@intel.com> (04/04/28 1.1359.6.12)
   [ACPI] button build fix

<len.brown@intel.com> (04/04/28 1.1359.6.11)
   [ACPI] toshiba_acpi driver if acpi_disabled (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2465

<len.brown@intel.com> (04/04/28 1.1359.6.10)
   [ACPI] pcibios_scan_root fix for IA64 (from IA64 tree via Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=2130

<len.brown@intel.com> (04/04/28 1.1359.6.9)
   [ACPI] pci-link may not always be SHARED (SuSE via Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=2404

<len.brown@intel.com> (04/04/28 1.1359.6.8)
   [ACPI] support button driver unload (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=2281

<len.brown@intel.com> (04/04/28 1.1359.6.7)
   [ACPI] battery "charged" instead of "unknown" (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1863

<sziwan@hell.org.pl> (04/04/28 1.1359.6.6)
   [PATCH] acpi4asus 0.28 (Karol 'sziwan' Kozimor)
   - Added support for Samsung P30
   - Fixed an oops triggered by non-standard hardware (Samsung P30)
   - Added support for L4400L and M6800N
   
   The patch also removes some superfluous data. It doesn't include the
   copy_from_user() conversion, it will be released as a separate patch.

<len.brown@intel.com> (04/04/24 1.1359.6.5)
   [ACPI] No IRQ known... - using IRQ 255 (Bjarni Rúnar Einarsson)
   http://bugzilla.kernel.org/show_bug.cgi?id=2148

<len.brown@intel.com> (04/04/22 1.1359.6.4)
   [ACPI] allow use of IRQ2 in ACPI/IOAPIC mode
   http://bugzilla.kernel.org/show_bug.cgi?id=2564

<len.brown@intel.com> (04/04/20 1.1359.6.3)
   [ACPI] enhance intr-src-override parsing to handle ES7000
   http://bugme.osdl.org/show_bug.cgi?id=2520
   

<len.brown@intel.com> (04/04/20 1.1359.6.2)
   [ACPI] Delete IRQ2 "cascade" in ACPI IOAPIC mode
   no such concept exists in ACPI, frees IRQ2 for use.

<len.brown@intel.com> (04/04/16 1.1359.6.1)
   [ACPI] delete unused CONFIG_ACPI_RELAXED_AML
   this code is included always -- or disable at boot w/ "acpi=strict

