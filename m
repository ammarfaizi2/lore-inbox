Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUJIGJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUJIGJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUJIGI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:08:28 -0400
Received: from fmr06.intel.com ([134.134.136.7]:12497 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266572AbUJIFyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:54:55 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097301276.16793.5.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Oct 2004 01:54:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/26-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20040816-26-latest-release.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |   14 ++
 arch/i386/kernel/acpi/boot.c        |   13 +-
 arch/i386/kernel/dmi_scan.c         |   39 -------
 arch/i386/kernel/io_apic.c          |   10 -
 arch/i386/pci/mmconfig.c            |    7 +
 arch/x86_64/kernel/io_apic.c        |   10 -
 arch/x86_64/kernel/setup.c          |    6 -
 drivers/acpi/Kconfig                |   26 ++++
 drivers/acpi/asus_acpi.c            |  125 +++++++++++-------------
 drivers/acpi/blacklist.c            |   44 ++++++++
 drivers/acpi/bus.c                  |   12 +-
 drivers/acpi/debug.c                |  105 +++++++++++++++++++-
 drivers/acpi/dispatcher/dsmethod.c  |   52 +++++----
 drivers/acpi/dispatcher/dsutils.c   |   53 +++++++---
 drivers/acpi/events/evgpe.c         |    6 -
 drivers/acpi/events/evmisc.c        |   32 ++++--
 drivers/acpi/events/evregion.c      |   17 +--
 drivers/acpi/events/evrgnini.c      |   12 +-
 drivers/acpi/events/evxface.c       |   11 --
 drivers/acpi/executer/exfldio.c     |   37 -------
 drivers/acpi/hardware/hwgpe.c       |    2 
 drivers/acpi/hardware/hwregs.c      |   70 ++++---------
 drivers/acpi/hardware/hwtimer.c     |   28 ++---
 drivers/acpi/numa.c                 |   16 +--
 drivers/acpi/osl.c                  |   10 +
 drivers/acpi/pci_link.c             |    4 
 drivers/acpi/tables.c               |    4 
 drivers/acpi/thermal.c              |   17 ++-
 drivers/acpi/utilities/utglobal.c   |    9 -
 include/acpi/acconfig.h             |    2 
 include/acpi/acexcep.h              |    2 
 include/acpi/acglobal.h             |    2 
 include/acpi/acmacros.h             |   18 ---
 include/acpi/acpi_drivers.h         |   55 ----------
 include/linux/acpi.h                |    7 -
 init/main.c                         |    6 -
 36 files changed, 484 insertions(+), 399 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/10/09 1.1803.119.22)
   [ACPI4ASUS] globalize hotk structure
   
   This cleans the code up a bit, but mainly allows most functions
   to be called externally when need (read: video driver) arises.
   
   Signed-off-by: Karol Kozimor <sziwan@hell.org.pl

<len.brown@intel.com> (04/10/09 1.1803.119.21)
   [ACPI4ASUS] support M6700R laptops
   
   Signed-off-by: Karol Kozimor <sziwan@hell.org.pl

<len.brown@intel.com> (04/10/09 1.1803.119.20)
   [ACPI4ASUS] acpi_bus_register_driver() return code
   
   Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

<len.brown@intel.com> (04/10/09 1.1803.119.19)
   [ACPI] acpi4asus update: support W1N, v0.29
   
   Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

<len.brown@intel.com> (04/10/08 1.1803.119.18)
   [ACPI] thermal module race condition/memory leak (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=3231

<len.brown@intel.com> (04/10/08 1.1803.119.17)
   [ACPI] fix double quoted params such as acpi_os_string="a b c"
   by Christian Lupien
   http://bugzilla.kernel.org/show_bug.cgi?id=3242

<len.brown@intel.com> (04/10/08 1.1803.119.16)
   [ACPI] x86_64 build fix
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<len.brown@intel.com> (04/10/08 1.1803.119.15)
   [ACPI] fix allmodconfig build
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<len.brown@intel.com> (04/09/16 1.1832.46.34)
   add GPL to mmconfig.c

<len.brown@intel.com> (04/09/02 1.1803.119.14)
   [ACPI] delete ACPI DMI/BIOS cutoff year by default
   
   CONFIG_ACPI_BLACKLIST_YEAR=2001 for old behaviour

<len.brown@intel.com> (04/09/01 1.1803.119.13)
   [ACPI] move acpi_bios_year() to blacklist.c from dmi_scan.c (Pavel
Machek)

<len.brown@intel.com> (04/09/01 1.1803.119.12)
   [ACPI] debugging enhancements (Yi Zhu)
   
   new cmdline options: "acpi_dbg_layer=",  "acpi_dbg_level="
   and /proc/acpi/debug_layer, debug_level now describe levels
   
   http://bugzilla.kernel.org/show_bug.cgi?id=2398

<len.brown@intel.com> (04/09/01 1.1803.119.11)
   [ACPI] allow config to specify custom DSDT (Ulf Dambacher)

<len.brown@intel.com> (04/09/01 1.1803.119.10)
   [ACPI] cleanup: use ioapic_register_intr()

<len.brown@intel.com> (04/08/26 1.1803.119.9)
   [ACPI] Export acpi_strict for use in modular drivers.
   This will enable drivers to work around BIOS deficiencies,
   while still allowing the drivers to be more picky with "acpi=strict"
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

<len.brown@intel.com> (04/08/26 1.1803.119.8)
   [ACPI] fix numa build warnings (Keith Owens)
   
   Signed-off-by: Takayoshi Kochi <t-kochi@bq.jp.nec.com>

<len.brown@intel.com> (04/08/24 1.1803.119.7)
   [ACPI] quiet ACPI NUMA boot messages
   Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

<len.brown@intel.com> (04/08/21 1.1803.119.6)
   [ACPI] Enable ACPICA workarounds for 'RELAXED_AML' and 'implicit
return'
   These workarounds are disabled if "acpi=strict"

<len.brown@intel.com> (04/08/20 1.1803.119.5)
   [ACPI] ACPICA 20040816 update from Bob Moore
   
   Designed and implemented support within the AML interpreter
   for the so-called implicit return.  This support returns
   the result of the last ASL operation within a control
   method, in the absence of an explicit Return() operator.
   A few machines depend on this behavior, even though it
   is not explicitly supported by the ASL language.  It is
   optional support that can be enabled at runtime via the
   acpi_gbl_enable_interpreter_slack flag.
   
   Removed support for the PCI_Config address space from the
   internal low level hardware interfaces (acpi_hw_low_level_read
   and acpi_hw_low_level_write).  This support was not used
   internally, and would not work correctly anyway because
   the PCI bus number and segment number were not supported.
   There are separate interfaces for PCI configuration space
   access because of the unique interface.
   acpica-unix-20040816.patch
   
   AE_CODE_AML_MAX fix from Bjorn Helgaas

<len.brown@intel.com> (04/08/19 1.1803.119.4)
   [ACPI] fix __initdata bug in acpi_irq_penalty[]
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>




