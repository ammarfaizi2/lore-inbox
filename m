Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCFGhU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 01:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUCFGhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 01:37:20 -0500
Received: from fmr01.intel.com ([192.55.52.18]:56236 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261604AbUCFGhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 01:37:16 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1078555020.12999.3200.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Mar 2004 01:37:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.4

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.4/acpi-20040220-2.6.4.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    5 
 MAINTAINERS                         |    2 
 arch/i386/Kconfig                   |   22 +
 arch/i386/kernel/acpi/boot.c        |  329 +++++++++++++++---------
 arch/i386/kernel/bootflag.c         |  170 ------------
 arch/i386/kernel/mpparse.c          |    2 
 arch/i386/kernel/setup.c            |    5 
 arch/i386/pci/Makefile              |    1 
 arch/i386/pci/common.c              |    9 
 arch/i386/pci/mmconfig.c            |  109 +++++++
 arch/i386/pci/pci.h                 |    3 
 arch/x86_64/kernel/acpi/boot.c      |    5 
 arch/x86_64/kernel/mpparse.c        |    2 
 drivers/acpi/Kconfig                |   12 
 drivers/acpi/executer/exfldio.c     |    7 
 drivers/acpi/hardware/hwgpe.c       |    8 
 drivers/acpi/hardware/hwregs.c      |    6 
 drivers/acpi/hardware/hwsleep.c     |   66 ++++
 drivers/acpi/namespace/nseval.c     |    4 
 drivers/acpi/namespace/nsutils.c    |    6 
 drivers/acpi/namespace/nsxfname.c   |    7 
 drivers/acpi/pci_link.c             |    2 
 drivers/acpi/resources/rsxface.c    |   18 +
 drivers/acpi/tables.c               |    9 
 drivers/acpi/utilities/uteval.c     |   60 ++++
 drivers/acpi/utilities/utglobal.c   |    7 
 include/acpi/acconfig.h             |    2 
 include/acpi/acglobal.h             |   25 -
 include/acpi/actypes.h              |    3 
 include/acpi/acutils.h              |    4 
 include/asm-i386/acpi.h             |    1 
 include/asm-i386/fixmap.h           |    3 
 include/asm-ia64/acpi.h             |    2 
 include/asm-x86_64/acpi.h           |    1 
 include/linux/acpi.h                |   35 ++
 35 files changed, 604 insertions(+), 348 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/01 1.1557.74.5)
   [ACPI] delete ACPI table parsing code from bootflags module

<len.brown@intel.com> (04/03/01 1.1500.39.9)
   [ACPI] Support for PCI MMCONFIG for PCI Express (Matt Wilcox)

<len.brown@intel.com> (04/03/01 1.1500.39.8)
   [ACPI] acpi_boot_init() cleanup suggested by Matt Wilcox
   HPET doesn't depend on IOAPIC

<len.brown@intel.com> (04/02/27 1.1493.1.21)
   [ACPI] ACPICA 20040220 from Bob Moore
   
   Implemented execution of _SxD methods for Device objects in the
   GetObjectInfo interface.
   
   Fixed calls to _SST method to pass the correct arguments.
   
   Added a call to _SST on wake to restore to "working" state.
   
   Check for End-Of-Buffer failure case in the WalkResources interface.
   
   Integrated fix for 64-bit alignment issue in acglobal.h by moving two
   structures to the beginning of the file.
   
   After wake, clear GPE status register(s) before enabling GPEs.
   
   After wake, clear/enable power button.
   (Perhaps we should clear/enable all fixed events upon wake.)
   
   Fixed a couple of possible memory leaks in the Namespace manager.

<len.brown@intel.com> (04/02/27 1.1493.1.20)
   [ACPI] include CONFIG_ACPI_RELAXED_AML code always
     add acpi=strict option to disable platform workarounds

<len.brown@intel.com> (04/02/26 1.1612.8.2)
   [ACPI] delete unnecessary dmesg lines, fix spelling

<len.brown@intel.com> (04/02/25 1.1612.6.2)
   ACPI URL update




