Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUKIHte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUKIHte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKIHtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:49:33 -0500
Received: from fmr06.intel.com ([134.134.136.7]:19868 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261417AbUKIHr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:47:28 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1099986428.6090.53.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Nov 2004 02:47:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/26-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20041105-26-latest-release.diff.gz

This will update the following files:

 Documentation/ibm-acpi.txt                        |  474 ++
 Documentation/kernel-parameters.txt               |    5 
 Documentation/power/video_extension.txt           |   34 
 arch/i386/kernel/acpi/boot.c                      |    8 
 arch/i386/kernel/cpu/cpufreq/acpi.c               |    4 
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c        |    3 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c        |    4 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    3 
 arch/i386/kernel/dmi_scan.c                       |   15 
 arch/i386/kernel/io_apic.c                        |    7 
 arch/i386/kernel/mpparse.c                        |    6 
 arch/i386/kernel/process.c                        |    4 
 arch/i386/mach-es7000/es7000.h                    |    7 
 arch/i386/mach-es7000/es7000plat.c                |   65 
 arch/i386/pci/irq.c                               |   25 
 arch/ia64/kernel/process.c                        |    2 
 arch/x86_64/kernel/process.c                      |    4 
 drivers/acpi/Kconfig                              |   31 
 drivers/acpi/Makefile                             |    2 
 drivers/acpi/ac.c                                 |    8 
 drivers/acpi/acpi_ksyms.c                         |    3 
 drivers/acpi/bus.c                                |   10 
 drivers/acpi/button.c                             |    8 
 drivers/acpi/dispatcher/dsmthdat.c                |   21 
 drivers/acpi/dispatcher/dsutils.c                 |    2 
 drivers/acpi/dispatcher/dswexec.c                 |   45 
 drivers/acpi/dispatcher/dswload.c                 |   22 
 drivers/acpi/dispatcher/dswstate.c                |    1 
 drivers/acpi/events/evgpe.c                       |    9 
 drivers/acpi/events/evgpeblk.c                    |    4 
 drivers/acpi/events/evxface.c                     |   45 
 drivers/acpi/executer/exconvrt.c                  |  359 -
 drivers/acpi/executer/exdump.c                    |  221 -
 drivers/acpi/executer/exfldio.c                   |    2 
 drivers/acpi/executer/exmisc.c                    |  467 +-
 drivers/acpi/executer/exoparg1.c                  |  211 -
 drivers/acpi/executer/exoparg2.c                  |  140 
 drivers/acpi/executer/exprep.c                    |    1 
 drivers/acpi/executer/exregion.c                  |    2 
 drivers/acpi/executer/exresolv.c                  |   60 
 drivers/acpi/executer/exresop.c                   |   16 
 drivers/acpi/executer/exstore.c                   |   37 
 drivers/acpi/executer/exsystem.c                  |    5 
 drivers/acpi/executer/exutils.c                   |   18 
 drivers/acpi/hardware/hwregs.c                    |   34 
 drivers/acpi/hardware/hwtimer.c                   |   19 
 drivers/acpi/ibm_acpi.c                           | 1237 ++++++
 drivers/acpi/motherboard.c                        |    4 
 drivers/acpi/namespace/nsaccess.c                 |   16 
 drivers/acpi/namespace/nsalloc.c                  |    8 
 drivers/acpi/namespace/nsdump.c                   |   61 
 drivers/acpi/namespace/nsdumpdv.c                 |   11 
 drivers/acpi/namespace/nseval.c                   |   92 
 drivers/acpi/namespace/nsinit.c                   |   27 
 drivers/acpi/namespace/nsload.c                   |   11 
 drivers/acpi/namespace/nsnames.c                  |    9 
 drivers/acpi/namespace/nssearch.c                 |   49 
 drivers/acpi/namespace/nsutils.c                  |   53 
 drivers/acpi/namespace/nswalk.c                   |    4 
 drivers/acpi/osl.c                                |   51 
 drivers/acpi/parser/psopcode.c                    |   27 
 drivers/acpi/parser/psparse.c                     |  189 
 drivers/acpi/parser/psutils.c                     |   25 
 drivers/acpi/pci_link.c                           |   27 
 drivers/acpi/power.c                              |   16 
 drivers/acpi/processor.c                          |  196 
 drivers/acpi/resources/rscalc.c                   |  112 
 drivers/acpi/scan.c                               |   11 
 drivers/acpi/sleep/main.c                         |    5 
 drivers/acpi/tables/tbconvrt.c                    |   54 
 drivers/acpi/tables/tbget.c                       |    3 
 drivers/acpi/tables/tbinstal.c                    |    3 
 drivers/acpi/tables/tbxfroot.c                    |   27 
 drivers/acpi/thermal.c                            |   20 
 drivers/acpi/utilities/utalloc.c                  |   20 
 drivers/acpi/utilities/utcopy.c                   |   27 
 drivers/acpi/utilities/utdelete.c                 |    9 
 drivers/acpi/utilities/utglobal.c                 |    5 
 drivers/acpi/utilities/utmath.c                   |   43 
 drivers/acpi/utilities/utmisc.c                   |  102 
 drivers/acpi/utilities/utobject.c                 |   60 
 drivers/acpi/utils.c                              |    2 
 drivers/acpi/video.c                              | 1988 ++++++++++
 drivers/pci/quirks.c                              |    1 
 drivers/pnp/Kconfig                               |    4 
 drivers/pnp/Makefile                              |    1 
 drivers/pnp/interface.c                           |    6 
 drivers/pnp/isapnp/Kconfig                        |    2 
 drivers/pnp/isapnp/core.c                         |    4 
 drivers/pnp/manager.c                             |   10 
 drivers/pnp/pnpacpi/Kconfig                       |   18 
 drivers/pnp/pnpacpi/Makefile                      |    5 
 drivers/pnp/pnpacpi/core.c                        |  258 +
 drivers/pnp/pnpacpi/pnpacpi.h                     |   13 
 drivers/pnp/pnpacpi/rsparser.c                    |  820 ++++
 drivers/pnp/pnpbios/Kconfig                       |    3 
 drivers/pnp/pnpbios/core.c                        |    2 
 drivers/pnp/pnpbios/rsparser.c                    |    7 
 drivers/pnp/quirks.c                              |    7 
 drivers/pnp/resource.c                            |    9 
 include/acpi/acconfig.h                           |    2 
 include/acpi/acglobal.h                           |    6 
 include/acpi/acinterp.h                           |   43 
 include/acpi/aclocal.h                            |    2 
 include/acpi/acmacros.h                           |    2 
 include/acpi/acobject.h                           |    5 
 include/acpi/acpi_bus.h                           |    4 
 include/acpi/acpiosxf.h                           |    9 
 include/acpi/acpixf.h                             |    9 
 include/acpi/actbl.h                              |    2 
 include/acpi/actbl2.h                             |   90 
 include/acpi/actypes.h                            |   17 
 include/acpi/acutils.h                            |   20 
 include/acpi/amlcode.h                            |   50 
 include/acpi/amlresrc.h                           |    4 
 include/acpi/platform/acenv.h                     |    2 
 include/acpi/processor.h                          |    4 
 include/asm-i386/processor.h                      |    2 
 include/asm-ia64/processor.h                      |    2 
 include/asm-x86_64/processor.h                    |    2 
 include/linux/acpi.h                              |   27 
 include/linux/pnp.h                               |    4 
 122 files changed, 7089 insertions(+), 1466 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/11/09 1.1803.119.53)
   [ACPI] ibm ACPI 0.8 by Chris Wright and Borislav Deianov
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/06 1.1803.162.10)
   [ACPI] ACPICA 20041105 from Bob Moore
   
   Implemented support for FADT revision 2.  This was an
   interim table (between ACPI 1.0 and ACPI 2.0) that adds
   support for the FADT reset register.
   
   Implemented optional support to allow uninitialized LocalX
   and ArgX variables in a control method.  The variables
   are initialized to an Integer object with a value
   of zero.  This support is enabled by setting the
   acpi_gbl_enable_interpreter_slack flag to TRUE,
   which is default unless booted with "acpi=strict".
   
   Implemented support for Integer objects for the SizeOf
   operator.  Either 4 or 8 is returned, depending on the
   current integer size (32-bit or 64-bit, depending on the
   parent table revision).
   
   Fixed a problem in the implementation of the SizeOf and
   ObjectType operators where the operand was resolved to
   a value too early, causing incorrect return values for
   some objects.
   
   Fixed some possible memory leaks during exceptional conditions.

<len.brown@intel.com> (04/11/05 1.1803.163.1)
   [ACPI] Allow limiting idle C-States.
   
   Useful to workaround C3 ipw2100 packet loss,
   reducing noise or boot issues on some models.
   http://bugme.osdl.org/show_bug.cgi?id=3549
   
   For static processor driver, boot cmdline:
   processor.acpi_cstate_limit=2
   
   For processor module, /etc/modprobe.conf:
   options processor acpi_cstate_limit=2
   
   For manual processor module load:
   # modprobe processor acpi_cstate_limit=2
   
   From kernel or kernel module:
   #include <linux/acpi.h>
   acpi_set_cstate_limit(2);
   
   Inspired by patches from Jos Delbar and Andi Kleen
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/04 1.2047)
   [ACPI] delete duplicated code resulting from auto-merge

<len.brown@intel.com> (04/11/04 1.1803.119.50)
   [ACPI] disable PNPBIOS if ACPI, even without PNPACPI
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/04 1.1803.119.49)
   [ACPI] keep processor driver loaded even if acpi_disabled
   
   for benefit of powernow-k8 driver which depends on it
   but runs even if acpi is disabled.
   
   Signed-off-by: Andi Kleen <ak@suse.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/04 1.2043)
   [ACPI] enable VIA quirk to fix audio interrupt on VIA_8233_5
   http://bugzilla.kernel.org/show_bug.cgi?id=3175
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/04 1.1803.119.48)
   [ACPI] remove obsolete blacklist entries (Andi Kleen)
   http://bugzilla.kernel.org/show_bug.cgi?id=3164
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/02 1.1803.119.47)
   [ACPI] Remove default PNPACPI driver binding to legacy ACPI devices.
   
   This conflicted with PNP-aware and ACPI-aware drivers,
   and required that its exclude-list carry vendor-specific
   driver names, which we can't possibly maintain.
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/02 1.1803.119.46)
   [ACPI] fix return values for ACPI_FUNCTION_TRACE
   http://bugzilla.kernel.org/show_bug.cgi?id=3336
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/01 1.1803.119.45)
   [ACPI] correct compiled-in acpi_dbg_level default
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/01 1.1803.119.44)
   [ACPI] fix x86_64 build warnings in video.c (Luming Yu)
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/01 1.1803.119.43)
   [ACPI] ACPIPNP handle IRQ resource value of 0 (David Shaohua Li)
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/29 1.1803.119.42)
   [PNP] handler more than 16 IRQs
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.41)
   [ACPI] fix video module unload oops
   
   Signed-off-by: Luming Yu <luming.yu@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.40)
   [ACPI] create ACPI-based PNP driver.
   
   With this driver, legacy device drivers (floppy ACPI driver,
   COM ACPI driver, and ACPI motherboard driver) which
   directly use ACPI can be removed, since now we have unified PNP
   interface for legacy ACPI enumerated devices.
   
   Originally by Matthieu Castet
   Signed-off-by: Li Shaohua <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.39)
   [ACPI] export acpi_match_ids()
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.38)
   [ACPI] introduces acpi_penalize_isa_irq() to to avoid PCI
   devices use IRQ of legacy PNP devices.
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.37)
   8250_pnp serial_req.port_high fix for Tiger
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.36)
   [PATCH] apply recent ES7000 ACPI interrupt fix to MPS mode
   
   Before:
   IRQ26 -> 0:10-> 1:2
   IRQ27 -> 0:11-> 1:3
   
   After:
   IRQ26 -> 1:2
   IRQ27 -> 1:3
   IRQ58 -> 0:10
   IRQ59 -> 0:11
   
   Signed-off-by: Natalie Protasevich <Natalie.Protasevich@unisys.com>
   Signed-off-by: Len Brown <Len.Brown@intel.com>

<len.brown@intel.com> (04/10/28 1.1803.119.35)
   [ACPI] C1 fixes when processor driver is loaded
   honor "halt=" cmdline parameter
   use monitor/mwait when available
   http://bugzilla.kernel.org/show_bug.cgi?id=2280
   
   Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/25 1.1803.119.34)
   [ACPI] Move the "only do this once" stuff from acpi_register_gsi()
into
   eisa_set_level().
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/25 1.1803.119.33)
   [ACPI] ACPI_VIDEO is EXPERIMENTAL

<len.brown@intel.com> (04/10/25 1.1803.119.32)
   [ACPI] Extensions for Display Adapters (Bruno Ducrot)
   http://bugme.osdl.org/show_bug.cgi?id=1944
   
   Signed-off-by: Luming Yu <luming.yu@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/25 1.1803.119.31)
   [ACPI] ACPI_CUSTOM_DSDT for IA64 too
   
   Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com

<len.brown@intel.com> (04/10/23 1.1803.119.30)
   [ACPI] ibm-acpi 0.7 from Borislav Deianov
   
   The CMOS handle was incorrectly marked as required, breaking insmod
   on models without one;
   
   The BLED method was incorrectly required if LED is not defined,
   breaking LED control on the A21e.
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/23 1.2028)
   Cset exclude:
jason.davis@unisys.com[torvalds]|ChangeSet|20040914144015|50315

<len.brown@intel.com> (04/10/22 1.1803.162.9)
   [ACPI] fix build warning

<len.brown@intel.com> (04/10/22 1.1803.162.8)
   [ACPI] ACPICA 20041015 from Bob Moore
   
   Signed-off-by: Len Brown <len.brown@intel.com>
   
   Note: ACPI CA is currently undergoing an in-depth and
   complete formal evaluation to test/verify the following
   areas. Other suggestions are welcome. This will result in
   an increase in the frequency of releases and the number
   of bug fixes in the next few months.
   
   - Functional tests for all ASL/AML operators
   - All implicit/explicit type conversions
   - Bit fields and operation regions
   - 64-bit math support and 32-bit-only "truncated" math support
   - Exceptional conditions, both compiler and interpreter
   - Dynamic object deletion and memory leaks
   - ACPI 3.0 support when implemented
   - External interfaces to the ACPI subsystem
   
   Fixed two alignment issues on 64-bit platforms -
   within debug statements in acpi_ev_gpe_detect and
   acpi_ev_create_gpe_block. Removed references to the
   Address field within the non-aligned ACPI generic address
   structure.
   
   Fixed a problem in the Increment and Decrement operators
   where incorrect operand resolution could result in the
   inadvertent modification of the original integer when the
   integer is passed into another method as an argument and
   the arg is then incremented/decremented.
   
   Fixed a problem in the FromBCD operator where the upper
   32-bits of a 64-bit BCD number were truncated during
   conversion.
   
   Fixed a problem in the ToDecimal operator where the length
   of the resulting string could be set incorrectly too long
   if the input operand was a Buffer object.
   
   Fixed a problem in the Logical operators (LLess,
   etc.) where a NULL byte (0) within a buffer would
   prematurely terminate a compare between buffer objects.
   
   Added a check for string overflow (>200 characters as per
   the ACPI specification) during the Concatenate operator
   with two string operands.

<len.brown@intel.com> (04/10/22 1.1803.162.7)
   [ACPI] fix build warning in tables/tbget.c

<len.brown@intel.com> (04/10/22 1.1803.162.6)
   [ACPI] ACPICA 20041006 from Bob Moore
   
   Signed-off-by: Len Brown <len.brown@intel.com>
   
   Implemented support for the ACPI 3.0 Timer operator. This
   ASL function implements a 64-bit timer with 100 nanosecond
   granularity.
   
   Defined a new OSL interface, acpi_os_get_timer. This
   interface is used to implement the ACPI 3.0 Timer
   operator. This allows the host OS to implement the timer
   with the best clock available.  Also, it keeps the core
   subsystem out of the clock handling business, since the
   host OS (usually) performs this function.
   
   Fixed an alignment issue on 64-bit platforms. The
   hw_low_level_read/write() functions use a 64-bit address
   which is part of the packed ACPI Generic Address
   Structure. Since the structure is non-aligned, the
   alignment macros are now used to extract the address to
   a local variable before use.
   
   Fixed a problem where the ToInteger operator assumed all
   input strings were hexadecimal. The operator now handles
   both decimal strings and hex strings (prefixed with "0x").
   
   Fixed a problem where the string length in the string
   object created as a result of the internal ConvertToString
   procedure could be incorrect.  This potentially affected
   all implicit conversions and also the ToDecimalString and
   ToHexString operators.
   
   Fixed two problems in the ToString operator. If the
   length parameter was zero, an incorrect string object was
   created and the value of the input length parameter was
   inadvertently changed from zero to Ones.
   
   Fixed a problem where the optional ResourceSource string
   in the ExtendedIRQ resource macro was ignored.
   
   Simplified the interfaces to the internal division
   functions, reducing code size and complexity.

<len.brown@intel.com> (04/10/22 1.1803.162.5)
   [ACPI] place-holder for ACPI 3.0 acpi_os_get_timer()

<len.brown@intel.com> (04/10/22 1.1803.162.4)
   [ACPI] ACPICA 20040924 from Bob Moore
   
   Signed-off-by: Len Brown <len.brown@intel.com>
   
   Added a new OSL interface, acpi_os_get_timer.  This
   interface implements a 64-bit monotonic timer in 100
   nanosecond units.
   
   Implemented support for the ACPI 3.0 Timer operator.
   This 64-bit timer utilizes the timer provided by the
   acpi_os_get_timer interface.

<len.brown@intel.com> (04/10/22 1.1803.162.3)
   [ACPI] acpi_os_sleep() now takes a single 64-bit value in [ms]
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/22 1.1803.162.2)
   [ACPI] ACPICA 20040922 from Bob Moore
   
   Signed-off-by: Len Brown <len.brown@intel.com>
   
   Fixed a problem with the implementation of the LNot()
   operator where "Ones" was not returned for the TRUE
   case. Changed the code to return Ones instead of (!Arg)
   which was usually 1. This change affects iASL constant
   folding for this operator also.
   
   Fixed a problem in acpi_ut_initialize_buffer where an
   existing buffer was not initialized properly -- Now zero
   the entire buffer in this case where the buffer already
   exists.
   
   Changed the interface to acpi_os_sleep from (UINT32
   Seconds, UINT32 Milliseconds) to simply (ACPI_INTEGER
   Milliseconds). This simplifies all related code
   considerably. This requires changes/updates to all OS
   interface layers (OSLs.)
   
   Implemented a new external interface,
   acpi_install_exception_handler, to allow a system exception
   handler to be installed. This handler is invoked upon
   any run-time exception that occurs during control method
   execution.
   
   Added support for the DSDT in acpi_tb_find_table. This
   allows the DataTableRegion() operator to access the local
   copy of the DSDT.

<len.brown@intel.com> (04/10/22 1.1803.162.1)
   [ACPI] ACPICA 20040827 update from Bob Moore
   
   Signed-off-by: Len Brown <len.brown@intel.com>
   
   Implemented support for implicit object conversion in
   the non-numeric logical operators (LEqual, LGreater,
   LGreaterEqual, LLess, LLessEqual, and LNotEqual.) Any
   combination of Integers/Strings/Buffers may now be used;
   the second operand is implicitly converted on the fly to
   match the type of the first operand.  For example:
   
   LEqual (Source1, Source2)
   
   Source1 and Source2 must each evaluate to an integer, a
   string, or a buffer. The data type of Source1 dictates the
   required type of Source2.  Source2 is implicitly converted
   if necessary to match the type of Source1.
   
   Updated and corrected the behavior of the string
   conversion support.  The rules concerning conversion of
   buffers to strings (according to the ACPI specification)
   are as follows:
   
   ToDecimalString - explicit byte-wise conversion of buffer
   to string of decimal values (0-255) separated by commas.
   
   ToHexString - explicit byte-wise conversion of buffer to
   string of hex values (0-FF) separated by commas.
   
   ToString - explicit byte-wise conversion of buffer to
   string.  Byte-by-byte copy with no transform except NULL
   terminated.  Any other implicit buffer-to-string conversion
   
   byte-wise conversion of buffer to string of hex values
   (0-FF) separated by spaces.
   
   Fixed a problem in acpi_ns_get_pathname_length where the
   returned length was one byte too short in the case of a
   node in the root scope.  This could cause a fault during
   debug output.

<len.brown@intel.com> (04/10/21 1.1803.119.28)
   [ACPI] disable printk on AML breakpoint
   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=135856
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/20 1.1803.119.27)
   [ACPI] clarify #define ACPI_THERMAL_MODE_CRITICAL (Pavel Machek)

<len.brown@intel.com> (04/10/20 1.1803.119.26)
   [ACPI] simplify ES7000 IRQ re-naming scheme
   so that it works for all PCI interrupts.
   
   Signed-off-by: Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
   Signed-off-by: Len Brown <Len.Brown@intel.com>

<len.brown@intel.com> (04/10/19 1.1803.119.25)
   [ACPI] create IBM ThinkPad ACPI driver -- ibm-acpi-0.6.patch
   
   by Borislav Deianov
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/10/18 1.1803.119.24)
   [ACPI] add module parameters: processor.c2=[0,1] processor.c3=[0,1]
   to disable/enable C2 or C3
   blacklist entries for R40e and Medion 41700
   http://bugme.osdl.org/show_bug.cgi?id=3549
   
   from Andi Kleen

<len.brown@intel.com> (04/10/18 1.1803.119.23)
   [ACPI] firmware wakeup address is physical, not virtual (David
Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=3390

<len.brown@intel.com> (04/10/10 1.1988.76.3)
   EXPORT_SYMBOL(acpi_os_write_port);
   EXPORT_SYMBOL(acpi_fadt_is_v1);

<len.brown@intel.com> (04/10/08 1.1988.76.2)
   [ACPI] Notify SMM of cpufreq
   http://marc.theaimsgroup.com/?l=acpi4linux&m=109428989121089&w=2
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de>




