Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVAaIix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVAaIix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVAaIiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:38:52 -0500
Received: from fmr13.intel.com ([192.55.52.67]:11688 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261849AbVAaIiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:38:23 -0500
Subject: [BKPATCH] ACPI for 2.6.11
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1107160681.18003.51.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Jan 2005 03:38:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/to-linus

	This batch includes:

	ACPI Interpreter updates, including fixing a 2.6.11 regression
	idle-loop power saving tuning
	new pnpacpi=off cmdline parameter for debugging

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.11/acpi-20050125-2.6.11-rc2.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    3 +
 arch/i386/kernel/setup.c            |   11 ++--
 drivers/acpi/debug.c                |    8 +--
 drivers/acpi/dispatcher/dsfield.c   |    2 
 drivers/acpi/dispatcher/dsinit.c    |    2 
 drivers/acpi/dispatcher/dsmethod.c  |    2 
 drivers/acpi/dispatcher/dsmthdat.c  |    2 
 drivers/acpi/dispatcher/dsobject.c  |    4 -
 drivers/acpi/dispatcher/dsopcode.c  |    2 
 drivers/acpi/dispatcher/dsutils.c   |   12 ++--
 drivers/acpi/dispatcher/dswexec.c   |    2 
 drivers/acpi/dispatcher/dswload.c   |    2 
 drivers/acpi/dispatcher/dswscope.c  |    2 
 drivers/acpi/dispatcher/dswstate.c  |    4 +
 drivers/acpi/events/evevent.c       |    2 
 drivers/acpi/events/evgpe.c         |    2 
 drivers/acpi/events/evgpeblk.c      |    2 
 drivers/acpi/events/evmisc.c        |    2 
 drivers/acpi/events/evregion.c      |    2 
 drivers/acpi/events/evrgnini.c      |    2 
 drivers/acpi/events/evsci.c         |    2 
 drivers/acpi/events/evxface.c       |    2 
 drivers/acpi/events/evxfevnt.c      |    2 
 drivers/acpi/events/evxfregn.c      |    2 
 drivers/acpi/executer/exconfig.c    |    2 
 drivers/acpi/executer/exconvrt.c    |   15 +++++-
 drivers/acpi/executer/excreate.c    |    2 
 drivers/acpi/executer/exdump.c      |    2 
 drivers/acpi/executer/exfield.c     |    2 
 drivers/acpi/executer/exfldio.c     |    2 
 drivers/acpi/executer/exmisc.c      |    2 
 drivers/acpi/executer/exmutex.c     |    2 
 drivers/acpi/executer/exnames.c     |    2 
 drivers/acpi/executer/exoparg1.c    |    2 
 drivers/acpi/executer/exoparg2.c    |    2 
 drivers/acpi/executer/exoparg3.c    |    6 ++
 drivers/acpi/executer/exoparg6.c    |    2 
 drivers/acpi/executer/exprep.c      |    2 
 drivers/acpi/executer/exregion.c    |    2 
 drivers/acpi/executer/exresnte.c    |    2 
 drivers/acpi/executer/exresolv.c    |    2 
 drivers/acpi/executer/exresop.c     |   41 ++++++++++++++++
 drivers/acpi/executer/exstore.c     |    2 
 drivers/acpi/executer/exstoren.c    |    2 
 drivers/acpi/executer/exstorob.c    |    2 
 drivers/acpi/executer/exsystem.c    |    2 
 drivers/acpi/executer/exutils.c     |    2 
 drivers/acpi/hardware/hwacpi.c      |    2 
 drivers/acpi/hardware/hwgpe.c       |    2 
 drivers/acpi/hardware/hwregs.c      |    2 
 drivers/acpi/hardware/hwsleep.c     |    2 
 drivers/acpi/hardware/hwtimer.c     |    2 
 drivers/acpi/namespace/nsaccess.c   |   11 +---
 drivers/acpi/namespace/nsalloc.c    |    2 
 drivers/acpi/namespace/nsdump.c     |    2 
 drivers/acpi/namespace/nsdumpdv.c   |    2 
 drivers/acpi/namespace/nseval.c     |    2 
 drivers/acpi/namespace/nsinit.c     |    8 ++-
 drivers/acpi/namespace/nsload.c     |    2 
 drivers/acpi/namespace/nsnames.c    |    2 
 drivers/acpi/namespace/nsobject.c   |    2 
 drivers/acpi/namespace/nsparse.c    |    2 
 drivers/acpi/namespace/nssearch.c   |    2 
 drivers/acpi/namespace/nsutils.c    |    2 
 drivers/acpi/namespace/nswalk.c     |    2 
 drivers/acpi/namespace/nsxfeval.c   |    2 
 drivers/acpi/namespace/nsxfname.c   |    2 
 drivers/acpi/namespace/nsxfobj.c    |    2 
 drivers/acpi/parser/psargs.c        |    2 
 drivers/acpi/parser/psopcode.c      |    4 -
 drivers/acpi/parser/psparse.c       |    2 
 drivers/acpi/parser/psscope.c       |    2 
 drivers/acpi/parser/pstree.c        |    2 
 drivers/acpi/parser/psutils.c       |    4 +
 drivers/acpi/parser/pswalk.c        |    2 
 drivers/acpi/parser/psxface.c       |    2 
 drivers/acpi/pci_bind.c             |   12 ++++
 drivers/acpi/processor_idle.c       |   28 ++++++++++-
 drivers/acpi/resources/rsaddr.c     |    2 
 drivers/acpi/resources/rscalc.c     |    2 
 drivers/acpi/resources/rscreate.c   |    2 
 drivers/acpi/resources/rsdump.c     |    2 
 drivers/acpi/resources/rsio.c       |    2 
 drivers/acpi/resources/rsirq.c      |    2 
 drivers/acpi/resources/rslist.c     |    2 
 drivers/acpi/resources/rsmemory.c   |    2 
 drivers/acpi/resources/rsmisc.c     |    2 
 drivers/acpi/resources/rsutils.c    |    9 +++
 drivers/acpi/resources/rsxface.c    |    2 
 drivers/acpi/tables/tbconvrt.c      |    2 
 drivers/acpi/tables/tbget.c         |    2 
 drivers/acpi/tables/tbgetall.c      |    2 
 drivers/acpi/tables/tbinstal.c      |    2 
 drivers/acpi/tables/tbrsdt.c        |    2 
 drivers/acpi/tables/tbutils.c       |    2 
 drivers/acpi/tables/tbxface.c       |    2 
 drivers/acpi/tables/tbxfroot.c      |   22 +++++---
 drivers/acpi/utilities/utalloc.c    |   28 ++++++++++-
 drivers/acpi/utilities/utcopy.c     |    2 
 drivers/acpi/utilities/utdebug.c    |    2 
 drivers/acpi/utilities/utdelete.c   |    2 
 drivers/acpi/utilities/uteval.c     |   18 ++++++-
 drivers/acpi/utilities/utglobal.c   |   10 ++--
 drivers/acpi/utilities/utinit.c     |    2 
 drivers/acpi/utilities/utmath.c     |    2 
 drivers/acpi/utilities/utmisc.c     |   60 ++++++++++++++----------
 drivers/acpi/utilities/utobject.c   |    4 +
 drivers/acpi/utilities/utxface.c    |    4 +
 drivers/acpi/utils.c                |   16 ++++--
 drivers/pnp/pnpacpi/core.c          |   15 +++++-
 drivers/pnp/pnpbios/core.c          |    7 +-
 include/acpi/acconfig.h             |    4 -
 include/acpi/acdebug.h              |    2 
 include/acpi/acdisasm.h             |    2 
 include/acpi/acdispat.h             |    4 +
 include/acpi/acevents.h             |    2 
 include/acpi/acexcep.h              |    2 
 include/acpi/acglobal.h             |    3 -
 include/acpi/achware.h              |    2 
 include/acpi/acinterp.h             |    2 
 include/acpi/aclocal.h              |    2 
 include/acpi/acmacros.h             |    2 
 include/acpi/acnamesp.h             |    2 
 include/acpi/acobject.h             |    2 
 include/acpi/acoutput.h             |    2 
 include/acpi/acparser.h             |    4 +
 include/acpi/acpi.h                 |    2 
 include/acpi/acpiosxf.h             |    2 
 include/acpi/acpixf.h               |    2 
 include/acpi/acresrc.h              |    2 
 include/acpi/acstruct.h             |    2 
 include/acpi/actables.h             |    2 
 include/acpi/actbl.h                |    2 
 include/acpi/actbl1.h               |    2 
 include/acpi/actbl2.h               |    2 
 include/acpi/actypes.h              |    2 
 include/acpi/acutils.h              |    6 ++
 include/acpi/amlcode.h              |    3 -
 include/acpi/amlresrc.h             |    2 
 include/acpi/platform/acenv.h       |    5 +-
 include/acpi/platform/acgcc.h       |    2 
 include/acpi/platform/aclinux.h     |    2 
 include/acpi/processor.h            |    1 
 143 files changed, 407 insertions(+), 205 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (05/01/31 1.1938.498.12)
   [ACPI] tell parse_cmdline_early() that "pnpacpi=off" != "acpi=off"
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/31 1.1938.498.11)
   [ACPI] add "pnpacpi=off"
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/27 1.1938.498.10)
   [ACPI] ACPI_FUTURE_USAGE for acpi_ut_create_pkg_state_and_push() 
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/27 1.1938.498.9)
   [ACPI] reduce stack usage
   http://bugzilla.kernel.org/show_bug.cgi?id=2901
   
   Written-by: Luming Yu <luming.yu@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/26 1.1938.498.8)
   [ACPI] ACPICA 20050125 from Bob Moore
   
   Fixed a recently introduced problem with the Global
   Lock where the underlying semaphore was not created.
   This problem was introduced in version 20050114, and
   caused an AE_AML_NO_OPERAND exception during an Acquire()
   operation on _GL.
   
   The local object cache is now optional, and is disabled
   by default.  #define ACPI_ENABLE_OBJECT_CACHE to enable
   the local cache.
   
   Fixed an issue in the internal function
   acpi_ut_evaluate_object() concerning the optional "implicit
   return" support where an error was returned if no return
   object was expected, but one was implicitly returned. AE_OK
   is now returned in this case and the implicitly returned
   object is deleted.  acpi_ut_evaluate_object() is only
   occasionally used, and only to execute reserved methods
   such as _STA and _INI where the return type is known
   up front.
   
   Fixed a few issues with the internal convert-to-integer
   code. It now returns an error if an attempt is made to
   convert a null string, a string of only blanks/tabs, or a
   zero-length buffer. This affects both implicit conversion
   and explicit conversion via the ToInteger() operator.
   
   The internal debug code in acpi_ut_acquire_mutex()
   has been commented out. It is not needed for normal
   operation and should increase the performance of the entire
   subsystem. The code remains in case it is needed for debug
   purposes again.
   acpica-unix-20050125.patch

<len.brown@intel.com> (05/01/21 1.1938.498.7)
   [ACPI] avoid benign AE_TYPE warnings
   caused by "implicit return" BIOS workaround
   returning unsolicited (and thus mis-typed) AML values.
   
   Signed-off-by: Bob Moore <robert.moore@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/21 1.1938.498.6)
   [ACPI] ACPICA 20050114 from Bob Moore
   
   Added 2005 copyright to all ACPICA files.
   
   Fixed an issue with the String-to-Buffer conversion code
   where the string null terminator was not included in the
   buffer after conversion, but there is existing ASL that
   assumes the string null terminator is included. This is the
   root of the ACPI_AML_BUFFER_LIMIT regression. This problem
   was introduced in the previous version when the code was
   updated to correctly set the converted buffer size as per
   the ACPI specification. The ACPI spec is ambiguous and
   will be updated to specify that the null terminator must
   be included in the converted buffer. This also affects
   the ToBuffer() ASL operator.
   
   Fixed a problem with the Mid() ASL/AML operator where it
   did not work correctly on Buffer objects. Newly created
   sub-buffers were not being marked as initialized.
   
   Fixed a problem in acpi_tb_find_table where incorrect string
   compares were performed on the oem_id and oem_table_d table
   header fields.  These fields are not null terminated,
   so strncmp is now used instead of strcmp.
   
   Implemented a restriction on the Store() ASL/AML operator
   to align the behavior with the ACPI specification.
   Previously, any object could be used as the source
   operand.  Now, the only objects that may be used are
   Integers, Buffers, Strings, Packages, Object References,
   and DDB Handles.  As acpi_gbl_enable_interpreter_slack
   is FALSE by default, "acpi=strict" is needed to enable
   this check.
   
   Enhanced the optional "implicit return" support to allow
   an implicit return value from methods that are invoked
   externally via the AcpiEvaluateObject interface.  This
   enables implicit returns from the _STA and _INI methods,
   for example.
   
   Changed the Revision() ASL/AML operator to return the
   current version of the AML interpreter, in the YYYYMMDD
   format. Previously, it incorrectly returned the supported
   ACPI version (This is the function of the _REV method).
   
   Updated the _REV predefined method to return the currently
   supported version of ACPI, now 3.

<len.brown@intel.com> (05/01/20 1.1938.498.5)
   [ACPI] Add a module parameter to allow tuning how much bus-master
activity
   we remember when entering C3 --
/sys/module/processor/parameters/bm_history
   Default varies with HZ -- 40ms for 25 - 800 HZ, 32ms for 1000 HZ.
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/20 1.1938.498.4)
   [ACPI] Make the bm_activity depend on "jiffies", instead of numbers
   of the check being called. This means bus mastering activity
   is assumed if bm_check isn't called; and multiple calls during
   one jiffy will be |='ed.
   
   Signed-off-by: Dominik Brodowski <linux@brodo.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (05/01/07 1.1938.498.3)
   [ACPI] Use kernel.h for ARRAY_SIZE() instead of using local NUM_OF().
   
   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Len Brown <len.brown@intel.com>






