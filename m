Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUA0GDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUA0GDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:03:55 -0500
Received: from fmr03.intel.com ([143.183.121.5]:28135 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262128AbUA0GDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:03:42 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1075183395.2489.52.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Jan 2004 01:03:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.2

	Most all of these updates have been in both 2.4
	and the 2.6-mm tree for some time.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.2/acpi-20040116-2.6.2.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |   17 ++
 arch/i386/boot/setup.S              |    2 
 arch/i386/kernel/acpi/boot.c        |   68 ++++++--
 arch/i386/kernel/cpu/cpufreq/acpi.c |   71 +++++++--
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
 drivers/acpi/ac.c                   |    2 
 drivers/acpi/asus_acpi.c            |    8 -
 drivers/acpi/battery.c              |    2 
 drivers/acpi/bus.c                  |    4 
 drivers/acpi/button.c               |    2 
 drivers/acpi/dispatcher/dsfield.c   |    2 
 drivers/acpi/dispatcher/dsinit.c    |    6 
 drivers/acpi/dispatcher/dsmethod.c  |    6 
 drivers/acpi/dispatcher/dsmthdat.c  |   48 ++++--
 drivers/acpi/dispatcher/dsobject.c  |    2 
 drivers/acpi/dispatcher/dsopcode.c  |   24 +--
 drivers/acpi/dispatcher/dsutils.c   |    2 
 drivers/acpi/dispatcher/dswexec.c   |   24 ++-
 drivers/acpi/dispatcher/dswload.c   |   10 -
 drivers/acpi/dispatcher/dswscope.c  |   10 -
 drivers/acpi/dispatcher/dswstate.c  |    2 
 drivers/acpi/ec.c                   |    2 
 drivers/acpi/events/evevent.c       |    2 
 drivers/acpi/events/evgpe.c         |   63 ++++----
 drivers/acpi/events/evgpeblk.c      |    7 
 drivers/acpi/events/evmisc.c        |    5 
 drivers/acpi/events/evregion.c      |  141 ++++++++++++------
 drivers/acpi/events/evrgnini.c      |   34 +++-
 drivers/acpi/events/evsci.c         |    2 
 drivers/acpi/events/evxface.c       |    2 
 drivers/acpi/events/evxfevnt.c      |    2 
 drivers/acpi/events/evxfregn.c      |   26 ++-
 drivers/acpi/executer/exconfig.c    |    2 
 drivers/acpi/executer/exconvrt.c    |    2 
 drivers/acpi/executer/excreate.c    |    2 
 drivers/acpi/executer/exdump.c      |   52 +++---
 drivers/acpi/executer/exfield.c     |    2 
 drivers/acpi/executer/exfldio.c     |  186 ++++++++++++------------
 drivers/acpi/executer/exmisc.c      |    8 -
 drivers/acpi/executer/exmutex.c     |   14 -
 drivers/acpi/executer/exnames.c     |    2 
 drivers/acpi/executer/exoparg1.c    |    5 
 drivers/acpi/executer/exoparg2.c    |    2 
 drivers/acpi/executer/exoparg3.c    |    7 
 drivers/acpi/executer/exoparg6.c    |    2 
 drivers/acpi/executer/exprep.c      |    6 
 drivers/acpi/executer/exregion.c    |   12 -
 drivers/acpi/executer/exresnte.c    |    2 
 drivers/acpi/executer/exresolv.c    |    8 -
 drivers/acpi/executer/exresop.c     |    6 
 drivers/acpi/executer/exstore.c     |    5 
 drivers/acpi/executer/exstoren.c    |    2 
 drivers/acpi/executer/exstorob.c    |    2 
 drivers/acpi/executer/exsystem.c    |   23 ++
 drivers/acpi/executer/exutils.c     |    2 
 drivers/acpi/fan.c                  |    2 
 drivers/acpi/hardware/hwacpi.c      |   15 -
 drivers/acpi/hardware/hwgpe.c       |   16 --
 drivers/acpi/hardware/hwregs.c      |   14 -
 drivers/acpi/hardware/hwsleep.c     |  167 +++++++++++++++------
 drivers/acpi/hardware/hwtimer.c     |    2 
 drivers/acpi/namespace/nsaccess.c   |   10 -
 drivers/acpi/namespace/nsalloc.c    |    9 -
 drivers/acpi/namespace/nsdump.c     |   39 ++---
 drivers/acpi/namespace/nsdumpdv.c   |    4 
 drivers/acpi/namespace/nseval.c     |    2 
 drivers/acpi/namespace/nsinit.c     |   65 ++++----
 drivers/acpi/namespace/nsload.c     |    2 
 drivers/acpi/namespace/nsnames.c    |    2 
 drivers/acpi/namespace/nsobject.c   |    9 -
 drivers/acpi/namespace/nsparse.c    |    2 
 drivers/acpi/namespace/nssearch.c   |    6 
 drivers/acpi/namespace/nsutils.c    |    8 -
 drivers/acpi/namespace/nswalk.c     |    2 
 drivers/acpi/namespace/nsxfeval.c   |    2 
 drivers/acpi/namespace/nsxfname.c   |    4 
 drivers/acpi/namespace/nsxfobj.c    |    2 
 drivers/acpi/osl.c                  |   13 -
 drivers/acpi/parser/psargs.c        |    6 
 drivers/acpi/parser/psopcode.c      |    2 
 drivers/acpi/parser/psparse.c       |    6 
 drivers/acpi/parser/psscope.c       |    2 
 drivers/acpi/parser/pstree.c        |    2 
 drivers/acpi/parser/psutils.c       |    2 
 drivers/acpi/parser/pswalk.c        |    2 
 drivers/acpi/parser/psxface.c       |   36 +++-
 drivers/acpi/pci_link.c             |  180 +++++++++++++++++++----
 drivers/acpi/pci_root.c             |   95 ------------
 drivers/acpi/power.c                |    2 
 drivers/acpi/processor.c            |    2 
 drivers/acpi/resources/rsaddr.c     |    2 
 drivers/acpi/resources/rscalc.c     |    6 
 drivers/acpi/resources/rscreate.c   |    4 
 drivers/acpi/resources/rsdump.c     |   20 --
 drivers/acpi/resources/rsio.c       |    2 
 drivers/acpi/resources/rsirq.c      |   40 ++---
 drivers/acpi/resources/rslist.c     |    6 
 drivers/acpi/resources/rsmemory.c   |    2 
 drivers/acpi/resources/rsmisc.c     |    2 
 drivers/acpi/resources/rsutils.c    |    2 
 drivers/acpi/resources/rsxface.c    |    2 
 drivers/acpi/scan.c                 |   11 -
 drivers/acpi/sleep/proc.c           |    3 
 drivers/acpi/tables.c               |   43 ++++-
 drivers/acpi/tables/tbconvrt.c      |   10 -
 drivers/acpi/tables/tbget.c         |   12 -
 drivers/acpi/tables/tbgetall.c      |    5 
 drivers/acpi/tables/tbinstal.c      |    2 
 drivers/acpi/tables/tbrsdt.c        |   16 +-
 drivers/acpi/tables/tbutils.c       |    2 
 drivers/acpi/tables/tbxface.c       |    4 
 drivers/acpi/tables/tbxfroot.c      |    9 -
 drivers/acpi/thermal.c              |    5 
 drivers/acpi/toshiba_acpi.c         |    2 
 drivers/acpi/utilities/utalloc.c    |   57 +------
 drivers/acpi/utilities/utcopy.c     |    2 
 drivers/acpi/utilities/utdebug.c    |    4 
 drivers/acpi/utilities/utdelete.c   |    6 
 drivers/acpi/utilities/uteval.c     |    6 
 drivers/acpi/utilities/utglobal.c   |  101 ++++++++++++-
 drivers/acpi/utilities/utinit.c     |    2 
 drivers/acpi/utilities/utmath.c     |    2 
 drivers/acpi/utilities/utmisc.c     |   14 +
 drivers/acpi/utilities/utobject.c   |   30 ---
 drivers/acpi/utilities/utxface.c    |    2 
 include/acpi/acconfig.h             |    8 -
 include/acpi/acdebug.h              |    2 
 include/acpi/acdisasm.h             |    2 
 include/acpi/acdispat.h             |    2 
 include/acpi/acevents.h             |   13 +
 include/acpi/acexcep.h              |    2 
 include/acpi/acglobal.h             |    5 
 include/acpi/achware.h              |    2 
 include/acpi/acinterp.h             |    2 
 include/acpi/aclocal.h              |    2 
 include/acpi/acmacros.h             |   29 +--
 include/acpi/acnamesp.h             |    2 
 include/acpi/acobject.h             |   37 ++--
 include/acpi/acoutput.h             |    2 
 include/acpi/acparser.h             |    2 
 include/acpi/acpi.h                 |    2 
 include/acpi/acpi_drivers.h         |    4 
 include/acpi/acpiosxf.h             |    2 
 include/acpi/acpixf.h               |    2 
 include/acpi/acresrc.h              |    2 
 include/acpi/acstruct.h             |    2 
 include/acpi/actables.h             |    2 
 include/acpi/actbl.h                |    9 -
 include/acpi/actbl1.h               |    2 
 include/acpi/actbl2.h               |    2 
 include/acpi/actypes.h              |    2 
 include/acpi/acutils.h              |   10 +
 include/acpi/amlcode.h              |    2 
 include/acpi/amlresrc.h             |    2 
 include/acpi/platform/acenv.h       |    2 
 include/acpi/platform/acgcc.h       |    2 
 include/acpi/platform/aclinux.h     |    2 
 include/acpi/processor.h            |    2 
 include/asm-i386/acpi.h             |   10 +
 include/asm-i386/system.h           |    1 
 include/asm-x86_64/acpi.h           |   27 +--
 172 files changed, 1493 insertions(+), 992 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/01/26 1.1491.1.7)
   [ACPI] handle system with NULL DSDT and valid XDSDT
           from ia64 via Alex Williamson

<len.brown@intel.com> (04/01/26 1.1491.1.6)
   [ACPI] move zero initialized data to .bss
   	from Jes Sorensen

<len.brown@intel.com> (04/01/26 1.1491.1.5)
   [ACPI] on SCI allocation failure, don't mistakenly free IRQ0
   	from Jes Sorensen

<len.brown@intel.com> (04/01/26 1.1491.1.4)
   [ACPI] fix ACPI spec URL in comment - from Randy Dunlap

<len.brown@intel.com> (04/01/23 1.1491.1.3)
   [ACPI] acpi_bus_add() ignored _STA's return value
     from Bjorn Helgaas

<len.brown@intel.com> (04/01/17 1.1491.1.2)
   [ACPI] ACPICA 20040116 from Bob Moore
   
   The purpose of this release is primarily to update the copyright
years
   in each module, thus causing a huge number of diffs.  There are a few
   small functional changes, however.
   
   Improved error messages when there is a problem finding one or more
of
   the required base ACPI tables
   
   Reintroduced the definition of APIC_HEADER in actbl.h
   
   Changed definition of MADT_ADDRESS_OVERRIDE to 64 bits (actbl.h)
   
   Removed extraneous reference to NewObj in dsmthdat.c

<len.brown@intel.com> (04/01/15 1.1491.1.1)
   [ACPI] change hard-coded IO width to programmable width
   	http://bugzilla.kernel.org/show_bug.cgi?id=1349
   	from David Shaohua Li and Venatesh Pallipadi

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






