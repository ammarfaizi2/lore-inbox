Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSFQCnO>; Sun, 16 Jun 2002 22:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSFQCnN>; Sun, 16 Jun 2002 22:43:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24068 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316673AbSFQCnJ> convert rfc822-to-8bit; Sun, 16 Jun 2002 22:43:09 -0400
Date: Sun, 16 Jun 2002 19:40:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.22
Message-ID: <Pine.LNX.4.33.0206161936210.1386-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g5H2h5j04963
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. This should make cardbus work again, and gets rif of the IDE "oops 
on shutdown" thing. Big x86-64 merge, and lots of acpi updates. IDE 
updates (as usual) and a lot of compiler warning work by various people. 
IrDA update and SCSI cleanups..

What else can you ask for?

		Linus

-----

Summary of changes from v2.5.21 to v2.5.22
============================================

<agrover@aracnet.com>:
  o ACPI updates (1-3)
  o ACPI cleanups (1-2)

<baccala@vger.freesoft.org>:
  o DBRI driver: Add T7903 doc URL

<bheilbrun@paypal.com>:
  o Compile error, ALSA Cirrus Logic driver

<bwheadley@earthlink.net>:
  o add Aiptek 8000U USB driver

<da-x@gmx.net>:
  o 2.5.21 - list.h cleanup

<flavien@lebarbe.net>:
  o usblp_ioctl for non-little-endian machines

<green@angband.namesys.com>:
  o many reiserfs updates

<jejb@mulgrave.(none)>:
  o 53c700
  o [SCSI 53c700] bux fix in tag starvation, cosmetic cleanup of
    set_depth
  o [SCSI 53c700] update version to 2.8

<mitch@sfgoth.com>:
  o atm warning fix (vs 2.5.21)

<patch@luckynet.dynu.com>:
  o new list macros for USB

<tiwai@suse.de>:
  o usb_set_interface for discontinous altsettings

<willy@debian.org>:
  o fs/locks.c cleanup

<wli@holomorphy.com>:
  o remove forget_pte() remnants

<zwane@linux.realnet.co.sz>:
  o 2.5.21 deadlocks on UP (SMP kernel) w/ IOAPIC

Alexander Viro <viro@math.psu.edu>:
  o resync (1-14)

Andi Kleen <ak@muc.de>:
  o 2.5.21 x86-64 jumbo patch - arch specific changes
  o network maintainer
  o i386 mptable cpu name decoding cleanup
  o i386 stack frame security fix
  o CONFIG_ISA for several driver dirs

Andrew Morton <akpm@zip.com.au>:
  o ext3 out-of-inodes fix
  o ext2_put_inode race fix
  o ext3 ordering fix
  o stram.c compile fix
  o writeback memory allocation robustness
  o fix smbfs oops

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o scsi stuff
  o SCSI stuff part 2

Benjamin LaHaise <bcrl@redhat.com>:
  o pci dma patch rediffed for 2.5.21
  o ns83820.c update to 0.18
  o 2.5.20 x86 iobitmap cleanup

Brad Hards <bhards@bigpond.net.au>:
  o USB: usb-midi Configure.help entry
  o USB Checker missing null pointer checks fix
  o USB Checker missing unlocks fixes

Christopher Hoover <ch@hpl.hp.com>:
  o [ARM PATCH] 1169/1: Add support for LEDS on BadgePAD 4 Add support
    for LEDS on BadgePAD 4.

David Brownell <david-b@pacbell.net>:
  o cdc-ether, remove warning
  o ohci-hcd, speedups+misc
  o ohci-hcd init err detect
  o ohci-hcd init err detect

David S. Miller <davem@redhat.com>:
  o TLB gather: Distinguish between full-mm and partial-mm flushes
  o Sparc: Fix copy_{to,from}_user return value handling
  o Sparc64: readv/writev SuS compliance fix for sparc32 compat
  o Get Sparc64 building again, both UP and SMP
  o Build fix for 2.5.x
  o Another Sparc build fix
  o Warning fix

François Romieu <romieu@cogenit.fr>:
  o 2.5.21 - hdlc drivers fixes
  o 2.5.21 - hdlc drivers fixes
  o 2.5.21 - hdlc drivers fixes
  o 2.5.21 - hdlc drivers fixes

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: printer fix as found by the CHECKER tool
  o USB keyspan_pda.c : fix problems found by CHECKER
  o USB: fixed problems when CONFIG_HOTPLUG=n and usb drivers were
    built into the kernel
  o USB: usb-serial api changes
  o USB visor driver: changes due to core api changes
  o USB whiteheat driver: changes due to the usb-serial api changes
  o USB serial drivers: changed startup() to attach() due to usbserial
    api change
  o USB: fixups due to the aiptek patch to get everything to build
    properly

Hugh Dickins <hugh@veritas.com>:
  o tmpfs 1/5 rename nlink
  o tmpfs 2/5 long symlinks
  o tmpfs 3/5 mknod times
  o tmpfs 4/5 swapoff tweaks
  o tmpfs 5/5 SMP-safe
  o swap 1/3 swapon leak
  o swap 2/3 unsafe SwapCache check
  o swap 3/3 unsafe Dirty check

Ingo Molnar <mingo@elte.hu>:
  o get rid of rq->frozen, fix context switch races
  o put the sync wakeup feature back in, based on Mike Kravetz's patch
  o rq-lock optimization in the preemption case, from Robert Love, plus
    some more cleanups
  o set_cpus_allowed() optimization from Mike Kravetz: we can set
    p->thread_info->cpu directly if the task is not running and is not
    on any runqueue.
  o wait_task_inactive() preemption-latency optimization: we should
    enable/disable preemption to not spend too much time with
    preemption disabled. wait_task_inactive() can take quite some time
    occasionally ...
  o squeeze a few more cycles out of the wakeup hotpath
  o do a manual preemption-check in task_rq_unlock()
  o 
  o revert the raw spinlock usage - it's too dangerous and volatile
  o make irqbalance work on UP-IOAPIC systems, fix from Zwane Mwaikambo

Jean Tourrilhes <jt@hpl.hp.com>:
  o IrDA updates 1/4
  o IrDA update 2/4
  o IrDA update 3/4
  o IrDA update 4/4

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o net driver 8139cp updates

Jens Axboe <axboe@suse.de>:
  o final plug stuff
  o generic tag update

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Small fixes
  o kbuild: Pass <target> to fixdep
  o kbuild: Generate dependencies for all targets
  o kbuild: Rearrange Rules.make
  o kbuild: Rules.make cleanup
  o kbuild: Put .cmd/.d files into the same directory as the target
  o kbuild: Optimize include of .*.cmd
  o kbuild: Generate modversions only for selected objects
  o kbuild: Track dependencies for .ver files
  o kbuild: Improve output alignment
  o kbuild: Remove mod-subdirs variable
  o kbuild: Fix unaligned access in sanity check
  o kbuild: Allow for ',' in file names
  o kbuild: Add $(HOST_LOADLIBES) when compiling host programs directly
  o ISDN: Eicon fix macro clash
  o ISDN: Fix warning and cleanup in new hisax sub-driver
  o ISDN: Fix some typos in drivers/isdn/hisax/Config.in
  o kbuild: Move various targets into noconfig section
  o ISDN: Fix bugs found by the Stanford checker

Kanoj Sarcar <kanojsarcar@yahoo.com>:
  o Sparc64: Fix module symbols when stack debugging is on

Linus Torvalds <torvalds@home.transmeta.com>:
  o cardbus.c fixes
  o fix up fall-out from header cleanups
  o More include header fixes for emu10k driver
  o Undo bogus 390 block layer merge (which re-introduced long-gone
    hardsects array)
  o jdev/s_dev are now regular dev_t's, compare them as such
  o Bitops need "unsigned long", but byte arrays
  o Remove old duplicate ACPI DEBUGGER_THREADING define
  o Fix printk type warning (mpc_cpufeature is long)
  o Add infrastructure to easily make _correct_ bitmap members in
    structures and unions (and why not other variables too..)
  o Fix various sound compiler warnings (and outright bugs
  o Cleanup, use new bitmap declarator instead of doing it by hand
  o Fix smbfs debug macros
  o Linux kernel 2.5.22
  o Brad Heilbrun: fix IDE for highmem support
  o revert to correct C99 behaviour Cset exclude:
    bcrl@redhat.com|ChangeSet|20020429021546|12619

Martin Dalecki <dalecki@evision-ventures.com>:
  o 2.5.20 IDE 86-92
  o 2.5.20 locks.h cleanup
  o kill warnings (1-19)
  o 2.5.21 "I can't get no compilation"

Nemosoft Unv. <nemosoft@smcc.demon.nl>:
  o PWC 8.7 for 2.5.20

Oliver Neukum <oliver@neukum.name>:
  o USB: small optimisation for hpusbscsi
  o USB: saving memory on kaweth

Pavel Machek <pavel@ucw.cz>:
  o suspend-to-{ram/disk} cleanups/fixes for 2.5.21

Peter Chubb <peter@chubb.wattle.id.au>:
  o yenta_socket driver PCI irq routing fix

Robert Love <rml@tech9.net>:
  o net/socket.c memory leak fix
  o uber trivial sysrq.c patch
  o kernel preemption bits (1/2)
  o kernel preemption bits (2/2)
  o scheduler whitespace/comment merge from -ac

Russell King <rmk@arm.linux.org.uk>:
  o Fix more header file breakage

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Generic hook for page faults Provide a method where various
    other parts of the kernel (eg, alignment fault handler, PCI
    subsystems, etc) can hook into the page fault processing to handle
    alignment and PCI faults respectively.
  o [ARM] asm-arm/bitops.h - add fls() and stream-line
    sched_find_first_bit()
  o [ARM] Fix ARM build (, -> _) The kbuild infrastructure in 2.5.21
    uses the filename to generate a dependency file, which is passed
    into gcc using -Wp,-MD,filename.
  o [ARM] 3 trivial changes

Stephen Rothwell <sfr@canb.auug.org.au>:
  o utimes permission check

William Stinson <wstinson@infonie.fr>:
  o [janitor] update the isicom.c multiport serial driver to 1) check
    the result of copy_from_user  2) return -EFAULT in case not all
    data was copied 3) release resources in case of failure
  o [janitor] update the istallion.c multiport serial driver 1) checks
    the result of copy_XX_user and returns -EFAULT in case not all data
    was copied. 
  o [janitor] update the ray_cs.c PCMCIA client driver for the Raylink
    wireless LAN card 1) checks the result of copy_to_user and  2)
    returns -EFAULT in case not all data was copied. 
  o [janitor] check copy_from_user return val in e100 net driver
  o [janitor] update the stallion.c multiport serial driver checks the
    result of copy_to_user and returns -EFAULT in case not all data was
    copied. Patch also changes the return code
  o [janitor] update the optcd  Optics Storage 8000 AT CDROM driver 1)
    remove call to check_region  2) check the status of call to
    request_region  3) and return an error in case of problem.
  o [janitor] request_region cleanups for mcd and mcdx ancient cd-rom
    drivers
  o [janitor] update the ni65 network driver to 1) remove call to
    check_region and use request_region instead checking the return
    value  2) release region resource in case of driver initialisation
    error
  o [janitor] update the sdlamain Multiprotocol WAN Link Driver to 1)
    check the status of call to request_region  2) and return an error
    in case of problem.
  o [janitor] update the DAC960 Driver for Mylex
    DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers to  1) check
    result of calls to request_region and handle failure to allocate
    region resource 2) add and use an extra label "Failure1" which
    frees the region resource in case of device driver initialisation
    error later on
  o [janitor] update the eexpress.c net driver to 1) check the status
    of call to request_region  2) and return an error and release the
    interrupt held in case of problem.
  o [janitor] update the comx-hw-comx wan driver to remove call to
    check_region and check the status of call to request_region
    instead.
  o [janitor] update the eepro Intel EtherExpress Pro/10 device driver
    to 1) check the status of call to request_region  2) and return an
    error in case of problem.
  o [janitor] update the atarilance Ethernet driver for VME Lance cards
    on the Atari to check the result of request_irq and exit in case of
    error
  o [janitor] update the yam hamradio driver to


