Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbVBDQ15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbVBDQ15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbVBDQ15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:27:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49791 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266392AbVBDQWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:22:52 -0500
To: lm@bitmover.com
Cc: Stelian Pop <stelian@popies.net>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
X-Message-Flag: Warning: May contain useful information
References: <20050202155403.GE3117@crusoe.alcove-fr>
	<200502030028.j130SNU9004640@terminus.zytor.com>
	<20050203033459.GA29409@bitmover.com>
	<20050203193220.GB29712@sd291.sivit.org>
	<20050203202049.GC20389@bitmover.com>
	<20050203220059.GD5028@deep-space-9.dsnet>
	<20050203222854.GC20914@bitmover.com>
	<20050204130127.GA3467@crusoe.alcove-fr>
	<20050204160631.GB26748@bitmover.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 04 Feb 2005 08:22:48 -0800
In-Reply-To: <20050204160631.GB26748@bitmover.com> (Larry McVoy's message of
 "Fri, 4 Feb 2005 08:06:31 -0800")
Message-ID: <52fz0c9twn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Feb 2005 16:22:49.0071 (UTC) FILETIME=[C47C27F0:01C50AD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Larry> You need to rethink your math, you are way off.  I'll
    Larry> explain it so that the rest of the people can see this is
    Larry> just pure FUD.

    [...]

    Larry> The CVS tree has 96% of all the deltas to all your source
    Larry> files.  96%.

    Larry> My good friend Stelian would have you believe that you are
    Larry> missing 50% of your data when in fact you are missing NONE
    Larry> of your data, you have ALL of your data in an almost the
    Larry> identical form.

    Larry> What Stelian is complaining about is the patch set which is
    Larry> easily extractable from CVS is at a coarser granularity
    Larry> than the patch set extractable from BK.  That's true but so
    Larry> what?  Before BK you only a handful of patches between
    Larry> releases, now you have thousands.

I don't pretend to understand all the tools or where information is
being lost, but I did use Stelian's HOWTO to make a subversion kernel
tree last night.  I'm including log information for what happen to be
the two most recent subversion changesets in my tree.  I think we can
all agree that quite a bit of useful information is lost to users of
the subversion tree.

------------------------------------------------------------------------
r26549 | torvalds | 2005-01-31 07:47:51 -0800 (Mon, 31 Jan 2005) | 208 lines

Merge bk://linux-acpi.bkbits.net/to-linus
into ppc970.osdl.org:/home/torvalds/v2.6/linux

2005/01/31 01:37:39-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/31 01:35:48-05:00 len.brown
[ACPI] tell parse_cmdline_early() that "pnpacpi=off" != "acpi=off"

Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/31 00:15:20-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/31 00:12:40-05:00 len.brown
[ACPI] add "pnpacpi=off"

Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/30 23:51:03-05:00 len.brown
Merge intel.com:/home/lenb/bk/26-latest-ref
into intel.com:/home/lenb/src/26-latest-dev

2005/01/27 18:16:15-05:00 len.brown
[ACPI] ACPI_FUTURE_USAGE for acpi_ut_create_pkg_state_and_push()

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/27 18:15:47-05:00 len.brown
[ACPI] reduce stack usage
http://bugzilla.kernel.org/show_bug.cgi?id=2901

Written-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/26 02:38:19-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/26 02:32:41-05:00 len.brown
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

2005/01/24 23:32:11-05:00 len.brown
Merge

2005/01/21 17:45:56-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/21 17:44:33-05:00 len.brown
[ACPI] avoid benign AE_TYPE warnings
caused by "implicit return" BIOS workaround
returning unsolicited (and thus mis-typed) AML values.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/21 00:28:02-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/21 00:18:05-05:00 len.brown
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

2005/01/20 22:58:53-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/20 22:43:52-05:00 len.brown
[ACPI] Add a module parameter to allow tuning how much bus-master activity
we remember when entering C3 -- /sys/module/processor/parameters/bm_history
Default varies with HZ -- 40ms for 25 - 800 HZ, 32ms for 1000 HZ.

Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/20 21:52:27-05:00 len.brown
[ACPI] Make the bm_activity depend on "jiffies", instead of numbers
of the check being called. This means bus mastering activity
is assumed if bm_check isn't called; and multiple calls during
one jiffy will be |='ed.

Signed-off-by: Dominik Brodowski <linux@brodo.de>
Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/20 16:46:39-05:00 len.brown
Merge intel.com:/home/lenb/bk/26-latest-ref
into intel.com:/home/lenb/src/26-latest-dev

2005/01/20 13:23:36-05:00 len.brown
Merge intel.com:/home/lenb/bk/26-latest-ref
into intel.com:/home/lenb/src/26-latest-dev

2005/01/19 21:16:57-05:00 len.brown
Merge intel.com:/home/lenb/bk/26-latest-ref
into intel.com:/home/lenb/src/26-latest-dev

2005/01/07 14:48:18-05:00 len.brown
Merge intel.com:/home/lenb/bk/26-latest-ref
into intel.com:/home/lenb/src/26-latest-dev

2005/01/07 13:42:16-05:00 len.brown
[ACPI] Use kernel.h for ARRAY_SIZE() instead of using local NUM_OF().

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>

2005/01/06 02:06:24-05:00 len.brown
Merge intel.com:/home/lenb/src/26-stable-dev
into intel.com:/home/lenb/src/26-latest-dev

2005/01/05 23:56:52-05:00 torvalds
acpi video device enumeration: fix incorrect device list allocation

It didn't allocate space for the final terminating entry,
which caused it to overwrite the next slab entry, which in turn
sometimes ended up being a slab array cache pointer. End result:
total slab cache corruption at a random time afterwards. Very
nasty.

2005/01/04 22:57:14-05:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.10
into intel.com:/home/lenb/src/26-stable-dev

BKrev: 41fe5327BXOmplstrv49I26qAg7mIA

------------------------------------------------------------------------
r26548 | torvalds | 2005-01-31 07:43:58 -0800 (Mon, 31 Jan 2005) | 189 lines

Merge bk://kernel.bkbits.net/davem/net-2.6
into ppc970.osdl.org:/home/torvalds/v2.6/linux

2005/01/30 14:39:30-08:00 torvalds
Merge bk://bk.arm.linux.org.uk/linux-2.6-rmk
into ppc970.osdl.org:/home/torvalds/v2.6/linux

2005/01/30 13:20:58-08:00 kaber
[PATCH] Fix conntrack fragment route cache memory leak

Thanks to Russell King for some excellent debugging.

Conntrack defragments locally generated packets before they hit
ip_fragment.  In this case the fragments have skb->dst set, and
that needs to be released.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

2005/01/30 19:38:54+00:00 rmk
[ARM] [3/4] Introduce usr_entry macro to contain common entry code

This is the third of 4 patches which factor out common code in
the ARM exception entry assembly code, aiming towards a reduction
in the size of the changes required here for SMP support.  These
patches are low impact, and will be merged over the coarse of the
next few days.

This patch addresses the code handling exception entry from user
modes.

2005/01/29 19:19:10-08:00 torvalds
Merge bk://bk.arm.linux.org.uk/linux-2.6-rmk
into ppc970.osdl.org:/home/torvalds/v2.6/linux

2005/01/29 09:24:47-08:00 axboe
[PATCH] cfq-iosched: in_driver accounting bug

Yet another accounting bug, this time hits on requeue. It is possible
for ->accounted to be set with ->in_flight, so don't nest the
cfq_account_completion() inside the ->in_flight check.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

2005/01/29 09:24:34-08:00 ak
[PATCH] x86-64: Fix empty nodes handling with SRAT

Handle empty nodes in SRAT parsing. Avoids an oops at boot time.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

2005/01/29 09:24:19-08:00 ak
[PATCH] x86-64: Fix missing TLB flushes in change_page_attr

Fix bug in change_page_attr - with multiple pages it would not flush
correctly. Also add a small optimization of not flushing when not needed.

Found and fixed by Andrea.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

2005/01/29 13:08:30+00:00 rmk
[ARM] [2/4] Introduce inv_entry macro to contain common entry code

This is the second of 4 patches which factor out common code in
the ARM exception entry assembly code, aiming towards a reduction
in the size of the changes required here for SMP support.  These
patches are low impact, and will be merged over the coarse of the
next 3 days.

This patch addresses the code handling exception entry from
invalid (irq, fiq, abort) modes.  However, in converting to a
macro, a minor bug has been fixed which would merely cause a
misleading register dump.

2005/01/28 22:29:02-05:00 mkrikis
[PATCH] fix an oops in ata_to_sense_error

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

2005/01/28 16:13:31-08:00 Andries.Brouwer
[PATCH] document atkbd.softraw

Document atkbd.softraw (and shorten a few long lines nearby).

2005/01/28 16:08:48-08:00 torvalds
Merge bk://bk.arm.linux.org.uk/linux-2.6-rmk
into ppc970.osdl.org:/home/torvalds/v2.6/linux

2005/01/28 23:23:38+00:00 rmk
[ARM] [1/4] Introduce svc_entry macro for common entry code

This is the first of 4 patches which factor out common code in
the ARM exception entry assembly code, aiming towards a reduction
in the size of the changes required here for SMP support.  These
patches are low impact, and will be merged over the coarse of the
next 4 days.

This patch addresses the code handling exception entry from
supervisor (kernel) mode.

2005/01/28 22:39:31+00:00 elf
[ARM PATCH] 2442/1: Simplifying NODES_SHIFT

Patch from Marc Singer

The special case for the Sharp LH processors is unnecessary.  A macro
override makes it cleaner and concentrates the change where it ought
to be.  The default in include/asm-arm/numnodes.h means that only
platforms that care to change the default need to do anything.

Signed-off-by: Marc Singer
Signed-off-by: Russell King

2005/01/28 22:14:31+00:00 ben-linux
[ARM PATCH] 2440/1: S3C2410 - serial auto-flow-control enable

Patch from Ben Dooks

Patch from Shannon Holland
Enable automatic flow control if requested.

Signed-off-by: Shannon Holland

Signed-off-by: Ben Dooks
Signed-off-by: Russell King

2005/01/28 22:08:02+00:00 ben-linux
[ARM PATCH] 2439/1: S3C2410 - serial driver parity selection

Patch from Ben Dooks

Patch from Dimitry Andric.
The s3c2410 serial driver selects the opposite parity
mode if parity is enabled.

Signed-off-by: Dimitry Andric

Signed-off-by: Ben Dooks
Signed-off-by: Russell King

2005/01/28 22:01:24+00:00 ben-linux
[ARM PATCH] 2438/1: S3C2410 - fix IO address calculations

Patch from Ben Dooks

Patch from Dimitry Andric.
The include/asm-arm/arch-s3c2410/io.h file converts
PC style port addresses to real ARM addresses, and
needs to return an `void __iomem *` to avoid a number
of warnings:
  CC      drivers/ide/ide-iops.o
drivers/ide/ide-iops.c: In function `ide_insw':
drivers/ide/ide-iops.c:49: warning: passing arg 1 of `__raw_readsw' makes pointer from integer without a cast
drivers/ide/ide-iops.c: In function `ide_insl':
drivers/ide/ide-iops.c:59: warning: passing arg 1 of `__raw_readsl' makes pointer from integer without a cast
drivers/ide/ide-iops.c: In function `ide_outsw':
drivers/ide/ide-iops.c:79: warning: passing arg 1 of `__raw_writesw' makes pointer from integer without a cast
drivers/ide/ide-iops.c: In function `ide_outsl':
drivers/ide/ide-iops.c:89: warning: passing arg 1 of `__raw_writesl' makes pointer from integer without a cast
  CC      lib/iomap.o
lib/iomap.c: In function `ioread8_rep':
lib/iomap.c:140: warning: passing arg 1 of `__raw_readsb' makes pointer from integer without a cast
lib/iomap.c: In function `ioread16_rep':
lib/iomap.c:144: warning: passing arg 1 of `__raw_readsw' makes pointer from integer without a cast
lib/iomap.c: In function `ioread32_rep':
lib/iomap.c:148: warning: passing arg 1 of `__raw_readsl' makes pointer from integer without a cast
lib/iomap.c: In function `iowrite8_rep':
lib/iomap.c:156: warning: passing arg 1 of `__raw_writesb' makes pointer from integer without a cast
lib/iomap.c: In function `iowrite16_rep':
lib/iomap.c:160: warning: passing arg 1 of `__raw_writesw' makes pointer from integer without a cast
lib/iomap.c: In function `iowrite32_rep':
lib/iomap.c:164: warning: passing arg 1 of `__raw_writesl' makes pointer from integer without a cast

Signed-off-by: Dimitry Andric

Signed-off-by: Ben Dooks
Signed-off-by: Russell King

2005/01/28 22:38:30+01:00 wim
[WATCHDOG] i8xx_tco.c-ICH4/6/7-patch

Added support for the ICH4-M, ICH6, ICH6R, ICH6-M, ICH6W and ICH6RW
chipsets. Also added support for the "undocumented" ICH7.

BKrev: 41fe523ecAJ3I6z55zHXaAI1vsDZ8Q

------------------------------------------------------------------------

