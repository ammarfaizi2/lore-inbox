Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318687AbSG0DIT>; Fri, 26 Jul 2002 23:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318688AbSG0DIT>; Fri, 26 Jul 2002 23:08:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22020 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318687AbSG0DIQ>; Fri, 26 Jul 2002 23:08:16 -0400
Date: Fri, 26 Jul 2002 20:12:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.29
Message-ID: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. All over the map. IDE patches as usual, USB updates, tons of C99 
named initializers work, ACPI update, fixes from Alan, driverfs race fixes
and cleanups, SCSI driver fixes from Doug and tons of input layer updates.

Oh, and a new LDM driver, Rusty's CPU hotplug infrastructure, and Ingo's
new cleaned-up GDT code with a per-process gdt segment on x86 for
thread-local storage. And the serial and parallel port drivers seems to
work again on SMP after the big irq lock upheaval.

		Linus

----

Summary of changes from v2.5.28 to v2.5.29
============================================

<adam@skullslayer.rod.org>:
  o LSM to designated initializers

Andy Grover <agrover@groveronline.com>:
  o ACPI compile fix
  o Interpreter update
  o Use C99 initializers (Rusty Russell)
  o Last little bit of C99 init fixes Fix panic in EC driver (Dom B)
    Add a some more sanity checking (Richard Schaal)

<ahaas@neosoft.com>:
  o designated initializer patch for USB

Alan Cox <alan@irongate.swansea.linux.org.uk>:
  o I2O does not need init in genhd now
  o backpack driver only needs module license in one file
  o fix umem compile
  o epca and specialix warning fixes
  o Q40 keyboard
  o miropcm20 fails to build
  o Update i2o core functionality to 2.5
  o ad1848_lib does not build
  o CS4281 is missing in sound/pci/Config.in
  o fix ALSA PCI compile problems
  o Fix other peoples ALSA PCI fixe
  o Fix multiple driver build failures due to missing include
  o Update tlan driver to new pci api
  o Make the tulip compile again
  o Fix cisco aironet tristate check
  o atp870u scsi update
  o SuS/LSB compliance in readv/writev from 2.4
  o Handle dunord pci decode problem
  o Remove dead i2c bits from media/video

<apolkosnik@directvinternet.com>:
  o new USB scanner IDs

<ckulesa@as.arizona.edu>:
  o fix unresolved syms for serial drivers

<da-x@gmx.net>:
  o i385 mm cleanup

Martin Dalecki <dalecki@evision.ag>:
  o 2.5.28 small REQ_SPECIAL abstraction
  o 2.5.28 IDE 102-107

<devel@brodo.de>:
  o resolve ACPI lockup

<felipewd@terra.com.br>:
  o WoL support to the 8139cp ethernet driver

<gnb@alphalink.com.au>:
  o 2.5: kconfig missing EXPERIMENTAL 3 (10_13)

<johann.deneux@it.uu.se>:
  o Merged hid-lgff.c and hid-lg3d.c

<kiran@in.ibm.com>:
  o Ensure xtime_lock and timerlist_lock are on difft cachelines

<lawrence@the-penguin.otak.com>:
  o CMIPCI compile fix

<ldm@flatcap.org>:
  o New LDM Driver (Windows Dynamic Disks)

Ingo Molnar <mingo@elte.hu>:
  o Thread-Local Storage (TLS) support
  o f00f workaround update, TLS, 2.5.28
  o comment fix, 2.5.28

<oleg@tv-sign.ru>:
  o irqlock fixes

<sam@ravnborg.org>:
  o Made 'make sgmldocs' work again after serial merge [1/9]
  o kernel-doc: Improved support for man-page generation [2/9]
  o kernel-doc: Generate valid DocBook syntax [3/9]
  o kernel-doc: Fix warnings [4/9]
  o docbook: scripts/docproc improved [5/9]
  o docbook: Makefile cleanup [6/9]
  o docbook: Update documentation to reflect new docproc [7/9]
  o docbook: Move script target in top-level file [8/9]
  o docbook: Call docbook makefile with -f [9/9]
  o Remove docgen + gen-all-syms targets

<sds@tislabs.com>:
  o LSM: CREDITS entries
  o LSM: file related LSM hooks

<thunder@ngforever.de>:
  o cli-sti-removal.txt fixup

Anton Blanchard <anton@samba.org>:
  o Missing memory barrier in pte_chain_unlock

Brad Hards <bhards@bigpond.net.au>:
  o trivial USB Config.help cleanups

Chris Wright <chris@wirex.com>:
  o LSM: CREDITS entry

David Brownell <david-b@pacbell.net>:
  o ehci-hcd more polite on cardbus
  o ohci unlink cleanups
  o ohci-hcd cardbus unplug, remove interrupt length limit,

David Howells <dhowells@redhat.com>:
  o read-write semaphore downgrade and trylock

Doug Ledford <dledford@redhat.com>:
  o Fix the BusLogic driver in 2.5.x
  o Fix cpqfcTS driver in 2.5.x

Greg Kroah-Hartman <greg@kroah.com>:
  o LSM: fixed up all of the other archs (non i386) to include the
    security config menu
  o updated my CREDITS entry
  o added ptrace hook for ia64
  o LSM: convert initializers to C99 style
  o LSM: fixed typo that happened in merge
  o i810_audio.c cli/sti fix
  o USB: fixed the interface names to have the proper bus id
  o USB: fix compiler warning in drivers/usb/serial/digi_acceleport.c
  o USB: deleted hid-lg3dff.c as it's no longer needed
  o USB: usb-serial.c update the version number, and document the
    previous changes
  o USB: added driver to support the I/O Networks TI based usb-serial
    devices

James Morris <jmorris@intercode.com.au>:
  o credits update

Linus Torvalds <torvalds@home.transmeta.com>:
  o cmd640 IDE driver internal spinlocks for config etc accesses
  o Remove unnecessary (and now nonworking) "sti()" in parport
    interrupt probing
  o Remove (broken) parport locking, add comment on fixing it
  o Make smp_init() happen before initializing drivers
  o Don't compile with "-g" by default, that was a left-over from the
    global irq-lock debugging
  o Clean up more x86 MM init details after splitup

Mikael Pettersson <mikpe@csd.uu.se>:
  o shrink check_nmi_watchdog stack frame
  o fix two unwrapped uses of thread_info->cpu

Neil Brown <neilb@cse.unsw.edu.au>:
  o remove sti() from calibrate_xor_block()

Patrick Mochel <mochel@osdl.org>:
  o Remove BKL from driverfs
  o Use C99 initializers in driverfs
  o driverfs: stop using vfs layer for file creation This is the first
    of a series of patches to driverfs to _not_ use the vfs layer for
    file creation and deletion. 
  o driverfs: don't use VFS for directory creation Call driverfs_mkdir
    directly, instead of going through vfs.
  o driverfs: don't use vfs for creating symlinks Add check for
    existence of dentry in driverfs_symlink and driverfs_mknod  (which
    the other creation functions use).
  o driverfs: Don't use VFS for file or directory deletion These are
    tied together a bit, so they're included in the same patch
  o fix memory leak when driverfs symlink fails

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Do not call ncp_lookup_validate on mountpoint
  o Remove unneeded server_file_handle and open_create_action property
    from ncpfs info structures
  o Return total/free space on ncpfs mounted volume
  o Allow access to all 256 volumes from Netware server
  o Use search for fileset instead of search for one item in ncpfs. It
    is much faster as you usually read whole directory in one request
    when using TCP transport, instead
  o Check for s_maxbytes and generate SIGXFSZ correctly in ncpfs's read
    and write. Only page cache generic_file_read/generic_file_write
    check for these conditions, and because of ncpfs does not use page
    cache, it must do that itself.
  o Update and fix inode attributes handling in ncpfs
  o Utilize NFS extended attributes for storing file mode and rdev.
    Make sure that you use nodev,nosuid together with nfsextras if you
    do not trust server...
  o Decide whether to build fs/ncpfs/symlinks.c or not in Makefile and
    not through ifdefing whole file out. It should make Al happier.
  o ipx use of cli/sti

Russell King <rmk@flint.arm.linux.org.uk>:
  o [SERIAL] Remove drivers/char/serial_{21285,amba}.c These drivers
    are now part of drivers/serial
  o [SERIAL] Fix documentation bug for expected stop_tx interrupt state
  o [SERIAL] Fix buglet causing (eg) ttyS-14 Allocate positive instead
    of negative line numbers when 8250.c registers a new port with the
    core.  This bug could cause registrations to erroneously fail, or
    oopsen when the pcmcia serial device is ejected.
  o [SERIAL] Stop open() looping while opening a non-present port
    Trying to open a non-present port (for configuration) causes us to
    to endlessly loop (by returning -ERESTARTSYS).  We should be
    returning success.  This cset fixes this.
  o [SERIAL] Turn on 8250 framing/parity error reporting on INPCK not
    IGNPAR
  o designated initalizers for serial/
  o [SERIAL] Fix initialiser warnings for HUB6 ports We were missing an
    element in the old_serial_port structure.

Rusty Russell <rusty@rustcorp.com.au>:
  o cpu_online() has odd semantics
  o Hot-plug CPU Boot Changes
  o Hot-plug CPU Boot Rewrite for i386
  o Hot-plug CPU Boot Rewrite for PPC

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o clean up RPC write_space() code
  o increase socket buffer for RPC over UDP
  o Reduce the number of getattr/lookup calls in
    nfs_lookup_revalidate()
  o add proper NFSv3 permissions checking

Vojtech Pavlik <vojtech@suse.cz>:
  o Fixes needed to get Logitech WingMan 3D running
  o Kernel command line [__setup()] parsing fixes in all the input
    drivers that use it, except i8042.
  o Update of the X-Box USB pad driver and documentation to version
    0.0.5
  o This patch by Brad Hards replaces the four id* fields of the input
    struct by a single struct to simplify passing it around and to
    userspace.
  o Add an i8042_restore_ctr command line option. This allows not
    restoring the CTR value after an AUX write by default, which breaks
    Transmeta Crusoe i8042 chip emulation. The option might be needed
    on some ancient hardware, though.
  o Fox a typo in input documentation. Patch by Pavel Machek
  o Remove duplicately defined keys in input.h that got there as a part
  o Osamu Tomita <tomita@cinet.co.jp>
  o Fix the PS/2 mouse wheel in Explorer PS/2 mode
  o Enable the Q40 keyboard only on the Q40 platform
  o After some grepping and talking to maintainers, I did the appended
    cleanup patch. This should be it from me until char/keyboard.c
    becomes a real input layer client, but this final patch will be
    _very_ small now :-)).
  o The following fixes compilation errors in the Acorn related input
    drivers.
  o The following patch adds the "resend" capability to the keyboard
    driver; when the host driver detects a parity or framing error, we
    can ask the keyboard to resend the data, instead of treating random
    garbage as valid data.
  o This patch adds two new serio input drivers.  Both are "UART" type
    drivers for PS/2 ports on both StrongARM and ARM Integrator
    hardware.
  o Apply Rusty's C99 initializer patch to input drivers
  o Add a GrIP MultiPort gamepad hub by Brian Bonnlander and Bill
    Soudan
  o By popular request, and explicit method of telling which events
    from a device belong together was implemented - input_sync() and
    EV_SYN. Touches every input driver. The first to make use of it is
    mousedev.c to properly merge events into PS/2 packets.
  o Small cleanup in evdev.c, which copies the data directly from input
    struct to userspace.
  o Add support for AT keyboards connected over a PS/2 to Serial
    converter to atkbd.c - trivial. Remove ps2serkbd, because it's not
    needed anymore.
  o Because the Linux Input core follows the USB HID standard where it
    comes to directions of movement and rotation, a mouse wheel should
    be positive where it "rotates forward, away from the user". We had
    the opposite in psmouse.c. Fixed this.
  o Add EVIOCSABS() ioctl to change the abs* informative values on
    input devices. This is something the X peoople really wanted.


