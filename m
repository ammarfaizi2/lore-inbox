Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbTLRKMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 05:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbTLRKMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 05:12:17 -0500
Received: from fmr03.intel.com ([143.183.121.5]:5775 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S265049AbTLRKMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 05:12:08 -0500
Subject: [BKPATCH] ACPI update for 2.6
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1071742310.2496.217.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Dec 2003 05:11:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0/acpi-20031203-2.6.0.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |   17 ++
 arch/i386/kernel/acpi/boot.c        |   68 +++++++-
 arch/i386/kernel/dmi_scan.c         |   10 -
 arch/i386/kernel/io_apic.c          |   10 -
 arch/i386/kernel/mpparse.c          |   19 ++
 arch/i386/kernel/setup.c            |    9 -
 arch/i386/mach-es7000/es7000.c      |    2 
 arch/i386/pci/acpi.c                |   13 -
 arch/i386/pci/common.c              |    5 
 arch/i386/pci/pci.h                 |    1 
 arch/x86_64/kernel/acpi/boot.c      |   71 +++++++--
 arch/x86_64/kernel/io_apic.c        |    8 -
 arch/x86_64/kernel/mpparse.c        |    2 
 arch/x86_64/kernel/setup.c          |    8 -
 drivers/acpi/bus.c                  |    4 
 drivers/acpi/dispatcher/dsinit.c    |    4 
 drivers/acpi/dispatcher/dsmethod.c  |    4 
 drivers/acpi/dispatcher/dsmthdat.c  |   45 ++++-
 drivers/acpi/dispatcher/dsopcode.c  |   22 +-
 drivers/acpi/dispatcher/dswexec.c   |   22 ++
 drivers/acpi/dispatcher/dswload.c   |    8 -
 drivers/acpi/dispatcher/dswscope.c  |    8 -
 drivers/acpi/events/evgpe.c         |   61 +++----
 drivers/acpi/events/evgpeblk.c      |    5 
 drivers/acpi/events/evmisc.c        |    3 
 drivers/acpi/events/evregion.c      |  134 ++++++++++++-----
 drivers/acpi/events/evrgnini.c      |   32 +++-
 drivers/acpi/events/evxfregn.c      |   24 ++-
 drivers/acpi/executer/exdump.c      |   50 +++---
 drivers/acpi/executer/exfldio.c     |  184 ++++++++++++------------
 drivers/acpi/executer/exmisc.c      |    6 
 drivers/acpi/executer/exmutex.c     |   12 -
 drivers/acpi/executer/exoparg1.c    |    3 
 drivers/acpi/executer/exoparg3.c    |    5 
 drivers/acpi/executer/exprep.c      |    4 
 drivers/acpi/executer/exregion.c    |   10 -
 drivers/acpi/executer/exresolv.c    |    6 
 drivers/acpi/executer/exresop.c     |    4 
 drivers/acpi/executer/exstore.c     |    3 
 drivers/acpi/executer/exsystem.c    |   21 +-
 drivers/acpi/hardware/hwacpi.c      |   13 -
 drivers/acpi/hardware/hwregs.c      |   12 -
 drivers/acpi/hardware/hwsleep.c     |   89 ++++++++---
 drivers/acpi/namespace/nsaccess.c   |    8 -
 drivers/acpi/namespace/nsalloc.c    |    7 
 drivers/acpi/namespace/nsdump.c     |   37 ++--
 drivers/acpi/namespace/nsdumpdv.c   |    2 
 drivers/acpi/namespace/nsinit.c     |   63 ++++----
 drivers/acpi/namespace/nsobject.c   |    7 
 drivers/acpi/namespace/nssearch.c   |    4 
 drivers/acpi/namespace/nsutils.c    |    6 
 drivers/acpi/namespace/nsxfname.c   |    2 
 drivers/acpi/parser/psargs.c        |    4 
 drivers/acpi/parser/psparse.c       |    4 
 drivers/acpi/parser/psxface.c       |   34 +++-
 drivers/acpi/pci_link.c             |  180 ++++++++++++++++++++---
 drivers/acpi/pci_root.c             |   95 ------------
 drivers/acpi/resources/rscalc.c     |    4 
 drivers/acpi/resources/rscreate.c   |    2 
 drivers/acpi/resources/rsdump.c     |   18 --
 drivers/acpi/resources/rsirq.c      |   38 ++--
 drivers/acpi/resources/rslist.c     |    4 
 drivers/acpi/scan.c                 |    3 
 drivers/acpi/sleep/proc.c           |    3 
 drivers/acpi/tables.c               |   30 ++-
 drivers/acpi/tables/tbget.c         |   10 -
 drivers/acpi/tables/tbgetall.c      |    3 
 drivers/acpi/tables/tbrsdt.c        |    3 
 drivers/acpi/tables/tbxface.c       |    2 
 drivers/acpi/tables/tbxfroot.c      |    3 
 drivers/acpi/thermal.c              |    1 
 drivers/acpi/utilities/utalloc.c    |   55 -------
 drivers/acpi/utilities/utdebug.c    |    2 
 drivers/acpi/utilities/utdelete.c   |    4 
 drivers/acpi/utilities/uteval.c     |    4 
 drivers/acpi/utilities/utglobal.c   |   99 ++++++++++++
 drivers/acpi/utilities/utobject.c   |   28 ---
 include/acpi/acconfig.h             |    4 
 include/acpi/acevents.h             |   11 +
 include/acpi/acglobal.h             |    3 
 include/acpi/acmacros.h             |   27 +--
 include/acpi/acobject.h             |   35 ++--
 include/acpi/acpi_drivers.h         |    4 
 include/acpi/acutils.h              |    8 +
 include/asm-i386/acpi.h             |   10 +
 include/asm-i386/system.h           |    1 
 include/asm-x86_64/acpi.h           |   27 +--
 87 files changed, 1170 insertions(+), 770 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/12/16 1.1489)
   [ACPI] set acpi_disabled=1 on failure for clean /proc
     http://bugzilla.kernel.org/show_bug.cgi?id=991

<len.brown@intel.com> (03/12/16 1.1488)
   [ACPI] /proc/acpi files appear in /proc if acpi=off (Shaohua David
Li)

<len.brown@intel.com> (03/12/15 1.1487)
   [ACPI] delete old _TRA code formerly used just by IA64. (Bjorn
Helgaas)
   The current approach is to walk the _CRS in pcibios_scan_root()
   using acpi_walk_resources().

<len.brown@intel.com> (03/12/11 1.1486)
   [ACPI] Update Linux to ACPICA 20031203 (Bob Moore)
   
   Changed the initialization of Operation Regions during subsystem init
to
   perform two entire walks of the ACPI namespace; The first to
initialize
   the regions themselves, the second to execute the _REG methods.  This
   fixed some interdependencies across _REG methods found on some
machines.
   
   Fixed a problem where a Store(Local0, Local1) could simply update the
   object reference count, and not create a new copy of the object if
the
   Local1 is uninitialized.
   
   Implemented support for the _SST reserved method during sleep
   transitions.
   
   Implemented support to clear the SLP_TYP and SLP_EN bits when waking
up,
   this is apparently required by some machines.
   
   When sleeping, clear the wake status only if SleepState is not S5.
   
   Fixed a problem in AcpiRsExtendedIrqResource() where an incorrect
   pointer arithmetic advanced a string pointer too far.
   
   Fixed a problem in AcpiTbGetTablePtr() where a garbage pointer could
be
   returned if the requested table has not been loaded.
   
   Within the support for IRQ resources, restructured the handling of
the
   active and edge/level bits.
   
   Fixed a few problems in AcpiPsxExecute() where memory could be leaked
   under certain error conditions.
   
   Improved error messages for the cases where the ACPI mode could not
be
   entered.

<len.brown@intel.com> (03/12/11 1.1485)
   [ACPI] update Linux to ACPICA 20031029 (Bob Moore)
   
   Fixed a problem where a level-triggered GPE with an associated _Lxx
   control method was incorrectly cleared twice.
   
   Fixed a problem with the Field support code where an access can occur
   beyond the end-of-region if the field is non-aligned but extends to
the
   very end of the parent region (resulted in an AE_AML_REGION_LIMIT
   exception.)
   
   Fixed a problem with ACPI Fixed Events where an RT Clock handler
would
   not get invoked on an RTC event.  The RTC event bitmasks for the PM1
   registers were not being initialized properly.
   
   Implemented support for executing _STA and _INI methods for Processor
   objects.  Although this is currently not part of the ACPI
specification,
   there is existing ASL code that depends on the init-time execution of
   these methods.
   
   Implemented and deployed a GetDescriptorName function to decode the
   various types of internal descriptors.  Guards against null
descriptors
   during debug output also.
   
   Implemented and deployed a GetNodeName function to extract the
   4-character namespace node name.  This function simplifies the debug
and
   error output, as well as guarding against null pointers during
output.
   
   Implemented and deployed the ACPI_FORMAT_UINT64 helper macro to
simplify
   the debug and error output of 64-bit integers.  This macro replaces
the
   HIDWORD and LODWORD macros for dumping these integers.
   
   Updated the implementation of the Stall() operator to only call
   AcpiOsStall(), and also return an error if the operand is larger than
   255.  This preserves the required behavior of not relinquishing the
   processor, as would happen if AcpiOsSleep() was called for "long
   stalls".
   
   Constructs of the form "Store(LocalX,LocalX)" where LocalX is not
   initialized are now treated as NOOPs.
   
   Cleaned up a handful of warnings during 64-bit generation.
   
   Fixed a reported error where and incorrect GPE number was passed to
the
   GPE dispatch handler.  This value is only used for error output,
   however.  Used this opportunity to clean up and streamline the GPE
   dispatch code.

<len.brown@intel.com> (03/12/11 1.1484)
   [ACPI] revert two fixes in preparation for ACPICA merge

<len.brown@intel.com> (03/12/11 1.1483)
   [ACPI] replace multiple flags with acpi_noirq -- ala 2.4

<len.brown@intel.com> (03/12/10 1.1481)
   [ACPI] set APIC ACPI SCI OVR default to level/low
     http://bugzilla.kernel.org/show_bug.cgi?id=1351

<len.brown@intel.com> (03/12/02 1.1480)
   [ACPI] add warning to thermal shutdown (Pavel Machek)

<len.brown@intel.com> (03/11/30 1.1479)
   [ACPI] sync with 2.4.23
   Re-enable IRQ balacning if IOAPIC mode
   http://bugzilla.kernel.org/show_bug.cgi?id=1440
   
   Also allow IRQ balancing in PIC mode if "acpi_irq_balance"
   http://bugzilla.kernel.org/show_bug.cgi?id=1391

<len.brown@intel.com> (03/11/21 1.1477)
   [ACPI] prevent ES7000 tweak from breaking i386 IOAPIC (Andrew de
Quincey)

<len.brown@intel.com> (03/11/20 1.1476)
   [ACPI] fix compiler warning (Andrew Morton)

<len.brown@intel.com> (03/11/18 1.1450.2.3)
   [ACPI] "acpi_pic_sci=edge" in case platform requires Edge Triggered
SCI
   http://bugzilla.kernel.org/show_bug.cgi?id=1390

<len.brown@intel.com> (03/11/18 1.1450.2.2)
   [ACPI] print_IO_APIC() only after it is programmed
   http://bugzilla.kernel.org/show_bug.cgi?id=1177

<len.brown@intel.com> (03/11/07 1.1414.1.7)
   [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid.
   http://bugzilla.kernel.org/show_bug.cgi?id=1177

<len.brown@intel.com> (03/11/07 1.1414.1.6)
   [ACPI] If ACPI is disabled by DMI BIOS date, then
   turn it off completely, including table parsing for HT.
   This avoids a crash due to ancient garbled tables.
   acpi=force is available to over-ride this default.
   http://bugzilla.kernel.org/show_bug.cgi?id=1434




