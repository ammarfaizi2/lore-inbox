Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSFIFn4>; Sun, 9 Jun 2002 01:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSFIFnz>; Sun, 9 Jun 2002 01:43:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27917 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317570AbSFIFnx>; Sun, 9 Jun 2002 01:43:53 -0400
Date: Sat, 8 Jun 2002 22:42:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.21
Message-ID: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bulk of the changes are the s390 merge bits, but there are small 
details like fixing some races in the new unplugging code etc, more 
driverfs, USB, framebuffer updates etc.

The most noticeable changes (and that people will probably find some 
nagging missing things with) are the header file cleanups - expect some 
missing headers here and there - and the kernel build changes. Different 
dependency stuff etc.

		Linus

-----

Summary of changes from v2.5.20 to v2.5.21
============================================

<alex@ssi.bg>:
  o ipchains_core netlink fix
  o ipchains_core GFP_KERNEL fix

<ch@murgatroid.com>:
  o USB SA-1111 patch against usb-2.5 bitkeeper

<da-x@gmx.net>:
  o fix NULL dereferencing in dcache.c

<dank@kegel.com>:
  o must be __KERNEL__ for byteorder/generic.h

<devik@cdi.cz>:
  o USB pwc webcam patch

<johan.adolfsson@axis.com>:
  o Missing include in mm/bootmem.c

<kaz@earth.email.ne.jp>:
  o fix for /proc operation

<mark@alpha.dyndns.org>:
  o 2.5.20 ov511.c compile fixes

<martin.schwidefsky@debitel.net>:
  o s/390 patches for 2.5.20 (1..4)

<willy@debian.org>:
  o fs/locks.c: Only yield once for flocks
  o fs/locks.c: remove MSNFS define
  o fs/locks.c: more cleanup

<wli@holomorphy.com>:
  o correct zone_table comment
  o duplicate decl in sched_init()
  o make memclass() an inline
  o remove antiquated comment
  o remove macros from page_alloc.c
  o static list init page_alloc.c

<zwane@linux.realnet.co.sz>:
  o bluesmoke merge

Adrian Bunk <bunk@fs.tum.de>:
  o UHCI bix for build error under unstable debian

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o net/sched fixes
  o ipv6 raw fixes

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: Remove unused source file
  o NTFS: The beginning of 2.0.8. - Major updates for handling of case
    sensitivity
  o NTFS: Fix really dumb logic bug in boot sector recovery
  o NTFS: Fix potential 1 byte overflow in
    fs/ntfs/unistr.c::ntfs_ucstonls()
  o NTFS: 2.0.8 release. Major updates for dcache aliasing issues wrt
    short/long file names

Anton Blanchard <anton@samba.org>:
  o Fix for recent swap changes on 64 bit archs

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o net/ipv4/af_inet.c
  o net/ipv4/devinet.c
  o net/ipv4/icmp.c
  o net/core/dev.c
  o net/ipv4/tcp_ipv4.c
  o arch/* drivers/cdrom/* drivers/char/*

Brad Hards <bhards@bigpond.net.au>:
  o "General options" - begone

Brian Gerst <bgerst@didntduck.org>:
  o fs/inode.c list_del_init
  o missing GET_CPU_IDX in i386 entry.S

Christoph Hellwig <hch@sb.bsdonline.org>:
  o kbuild: remove CLEAN_DIRS from Makfile
  o kbuild: small toplevel makefile tidyup

Dave Jones <davej@suse.de>:
  o large x86 setup cleanup

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Fix structure alignment problem on 64-bit machines
  o JFS: Add hch's copyright
  o JFS: remove obsolete declaration

David Brownell <david-b@pacbell.net>:
  o ohci-hcd, fix urb unlink races
  o synchronous control/bulk messaging
  o uhci-hcd misc
  o relocate error checks

David S. Miller <davem@nuts.ninka.net>:
  o net/core/dev.c: Do not cast pointers to int, use long
  o sk->num no longer exists in 2.5, use inet_sk(sk)->num
  o net/core/dev.c: Make handle_diverter return 0
  o Bonding driver: Merge 2.4.x driver updates into 2.5
  o asm-generic.h: Add forward siginfo decl for the sake of
    HAVE_ARCH_SIGINFO_T platforms.
  o init/main.c: Revert recent GCC requirement change
  o Fix generic device layer init sequence
  o SunRPC: Fix size_t vs. unsigned int arg descrepancy
  o register_netdevice: Fix return value handling on success
  o sparc64/kernel/Makefile: Remove bogus binfmt_elf32.o dependency
    target
  o Sparc64: Propagate exec MM handling changes to sparc32 emulation
    layer
  o Sparc64: Propagate forget_pte changes to sparc64 ioremap
  o Sparc: Adjust to new {clear,copy}_user_page calling convention
  o IDE: Print I/O ports more portably
  o IDE: Add missing printf format specifier when printing Sparc IRQ.
  o IDE: Print 64-bit types more portably

David Woodhouse <dwmw2@infradead.org>:
  o Shared zlib include fix for 2.5 and 2.4-ac

Ghozlane Toumi <ghoz@sympatico.ca>:
  o update to pci_quirks.c

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: emi26.c small fix to enable the driver to build properly
  o USB: formatting cleanups for some USB drivers from the 2.5.20-dj3
    tree
  o Added usb-midi driver from NAGANO Daisuke with some porting from me
  o USB: split some pci specific pieces out of hcd.c into a separate
    file
  o USB: usb-midi driver: fixed memory flag, as pointed out by Oliver
    Neukum
  o USB: hcd cleanups and documentation
  o IBM PCI Hotplug driver:  polling thread locking cleanup
  o PCI Hotplug core: added #include <linux/namei.h> to fix compile
    time warning
  o IBM PCI Hotplug driver: added __init and __exit to functions that
    needed it

James Simmons <jsimmons@heisenberg.transvirtual.com>:
  o Reversed a mistake in cyber200fb.c Finshed porting the 3Dfx driver
    over to the new api
  o Ported over NeoMagic over to new api
  o Fixed a nasty bug in the 3Dfx driver and added the ahrdware
    routines for the NeoMagic chipset
  o Bug fixes for NeoMagic and 3Dfx driver
  o More bug fixes. When will it end?
  o Ported over the apollo framebuffer device. Updated the Permedia 2
    fbdev driver to the latest code. Small bug fix for the NeoMagic
    driver.
  o Ported the Maxine framebuffer driver to the new api
  o A few small fixes from porting it over to the new api. ALso a few
    more drivers from the MIPS platform ported over
  o Ported over the TX3912 framebuffer to the new api. Fixed a NODEV
    error for the Permedia framebuffer driver and patched fbcmap.c to
    prevent another Oops
  o Bug fixes for the fbdev layer

Jens Axboe <axboe@suse.de>:
  o unplugging fix

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Split Makefile into needs / needs not .config
  o kbuild: Fix make -s (silent) and add a quiet mode
  o kbuild: Fix 'make some/dir/foo.lst'
  o kbuild: Fix calling of scripts
  o kbuild: Make dependencies at compile time
  o kbuild: Use deep directory structure for include/linux/modules
  o kbuild: Clean up descending into subdirs
  o kbuild: Really stick with verbose output by default
  o kbuild: modversions improvements
  o kbuild: Build modules by default
  o kbuild: Use a standard "update-if-changed"
  o kbuild: -DMODULE for assembler source
  o kbuild: Additional config targets for testing
  o kbuild: Remove 2048 symbol limit from make xconfig
  o kbuild
  o kbuild: Fix tolower() usage in scripts/fixdep.c
  o kbuild: Use -nostdinc with kernel sources
  o kbuild: Enforce UTS limit, use LANG=C for date/time
  o kbuild: Add rules for compiling programs on the host
  o kbuild: Fix extracting of CONFIG_ references
  o kbuild: dependency generation fixes
  o ISDN: Add missing #include <linux/init.h>
  o ISDN: Fix a typo in drivers/isdn/hisax/elsa.c
  o ISDN/CAPI: Remove some left-over from the capi_driver removal
  o ISDN: Add PPP statistics in bytes
  o ISDN: Export all hisax symbols from drivers/isdn/hisax/config.o
  o ISDN: hisax/hfc_pci.c: sync with 2.4
  o ISDN: Add support for USR PCI TA
  o ISDN: Cisco HDLC update
  o ISDN: Add support for Eicon Diva 2.02
  o ISDN: Add DoV (Data over Voice) support
  o ISDN: Add support for Formula-n enter:now, a.k.a. Gerdes Power ISDN
  o ISDN: Add in-kernel ISAPnP support to HiSax driven cards
  o ISDN: MPPP crash fix
  o ISDN: LED support for netjet driver
  o ISDN/CAPI: Don't use special slab caches for CAPI objects

Linus Torvalds <torvalds@transmeta.com>:
  o Split up "iput()" and make it more readable
  o Fix extra parenthesis in the constant-address rwlock case
  o ACPI sleep depends on software suspend (at least for now)
  o Fall-out from header file cleanups
  o "make clean": get rid of temporary directories too
  o Kernel version 2.5.21
  o Clean up and fix Makefile from x86 CPU split
  o Fix x86 CPU merge dangling ends
  o Fix sound compile error exposed by header file cleanups

Martin Dalecki <dalecki@evision-ventures.com>:
  o 2.5.20 airo wireless -  "I can't get no, compilation..."
  o 2.5.20 IDE 83..85

Nicolas Pitre <nico@cam.org>:
  o [ARM PATCH] 1166/1: further cleanup of SA1110 suspend/resume code
    (2.5) Same thing as patch #1165/1 but for 2.5.x

Patrick Mochel <mochel@osdl.org>:
  o device model udpate
  o Do manual traversing of drivers' devices list when unbinding the
    driver
  o PCI driver mgmt
  o Change unused_initcall to postcore_initcall for things that must be
    initialized early, but not too early (after the core is done)
  o s/subsys_initcall/postcore_initcall/ for sys_bys and pci, so they
    get initialized early enough for arch and subsys initcalls to use
    them
  o device model update s/{driver,device}_bind/{driver,device}_attach/
    and s/{driver,device}_unbind/{driver,device}_detach/ call bus's
    match callback instead of bind callback
  o Attempt to better locking in device model core
  o Don't reference driver after you set pointer to NULL in
    device_detach
  o device detach locking, one more time: get driver and reset it in
    struct device before calling remove()

Pavel Machek <pavel@suse.cz>:
  o Re: Fix suspend-to-RAM in 2.5.20

Pavel Machek <pavel@ucw.cz>:
  o Fix suspend-to-RAM in 2.5.20
  o Cleanup swsusp in 2.5.20
  o 2.5.20 swsusp: stop abusing headers with non-inlined functions

Peter Chubb <peter@chubb.wattle.id.au>:
  o bogus casts in ide-cd.c

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o matroxfb dies when you try to use secondary head in 2.5.x

Randy Hron <rwhron@earthlink.net>:
  o remove space in cache names

Rob Radez <rob@osinvestor.com>:
  o Sparc32 code cleanups from 2.4.x

Robert Love <rml@tech9.net>:
  o remove wq_lock_t cruft
  o capability.c cleanup
  o trivial misc. scheduler cleanups
  o maintainers update
  o make smp.c preempt-safe
  o sys_sysinfo cleanup
  o remove suser()
  o remove fsuser()
  o capability.c thinko
  o set_cpus_allowed fix

Russell King <rmk@arm.linux.org.uk>:
  o fix 2.5.20 ramdisk
  o Allow mpage.c to build

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Makefile and page.h ARM updates for 2.5.20
  o [ARM] Clean up map_desc structure
  o [ARM] Cast thread_saved_{pc,fp} to unsigned long

Rusty Russell <rusty@rustcorp.com.au>:
  o Spelling
  o TAGS creation should go into arch dirs
  o Futex update I: Trivial comment removal
  o Futex II: Copy-from-user can fail
  o Futex update III: don't use put_page
  o Futex update IV: use a waitqueue

Simon Evans <spse@secret.org.uk>:
  o fix urb->next removal in konicawc driver
  o fix urb->next removal in usbvideo

Stephen Rothwell <sfr@canb.auug.org.au>:
  o fs/locks.c use list_del_init
  o fcntl_[sg]etlk() only need the file *
  o fs/locks.c: add and use IS_{POSIX, FLOCK, LEASE} macros

Tom Rini <trini@kernel.crashing.org>:
  o Cleanup i386 <linux/init.h> abuses
  o Have core/drivers.c include <linux/gfp.h>
  o Move vmalloc wrappers out of include/linux/vmalloc.h
  o Remove <linux/mm.h> from <linux/vmalloc.h>
  o More work on removing <linux/mm.h> from <linux/vmalloc.h>

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix Oops due to use of incorrect km_type in RPC socket code
  o Reduce number of LOOKUP calls in nfs_lookup_revalidate()
  o Catch a few more cases where we need to renew inode->d_time


