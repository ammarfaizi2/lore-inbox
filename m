Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSKVXcO>; Fri, 22 Nov 2002 18:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSKVXcO>; Fri, 22 Nov 2002 18:32:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37896
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265409AbSKVXcC>; Fri, 22 Nov 2002 18:32:02 -0500
Date: Fri, 22 Nov 2002 15:38:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux v2.5.49
In-Reply-To: <Pine.LNX.4.44.0211221351040.1763-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10211221536400.13936-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Russell and I have hooked togather and relayed it to the UK.
So just wait for Russell to annouce the download points.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 22 Nov 2002, Linus Torvalds wrote:

> 
> Ok, I appear to be without network connectivity at home at least over the 
> weekend, and master.kernel.org is going down for some maintenance this 
> afternoon, so here's my current tree.
> 
> Architecture updates, threading improvements, shm fix (the cause of 
> the Oracle problems), networking, scsi, modules, you name it, it's here.
> 
> Due to my lacking network connection over the weekend, I'd suggest 
> discussing issues on linux-kernel, since emailing them to me won't much 
> help ;/
> 
> The joys of switching ISPs..
> 
> 		Linus
> 
> -----
> 
> Summary of changes from v2.5.48 to v2.5.49
> ============================================
> 
> <bdschuym@pandora.be>:
>   o [EBTABLES]: Use correct base pointer in ebt_do_table
>   o add necessary #ifdefs to netfilter_bridge.h, vs 2.5.48
> 
> <chris@qwirx.com>:
>   o [SPARC]: Add missing iounmap to display7seg driver
> 
> <greearb@candelatech.com>:
>   o [VLAN]: Quiet some printks and free devices/groups correctly
> 
> <hadi@cyberus.ca>:
>   o [SCH_GRED]: Array overflow fixes, found by Stanford checker
> 
> <jgrimm2@us.ibm.com>:
>   o [IPV6]: Export ipv6_chk_addr
> 
> <joe@wavicle.org>:
>   o vicam.c
> 
> <maneesh@in.ibm.com>:
>   o dcache usage cleanups
> 
> <petkan@tequila.dce.bg>:
>   o ADM8513 support added;
> 
> <rread@clusterfs.com>:
>   o fix intermezzo compile
> 
> <sridhar@dyn9-47-18-140.beaverton.ibm.com>:
>   o [SCTP] Support for Peer address parameters socket option
>   o [SCTP] udp-style connect support(non-blocking)
>   o [SCTP] Fix for sideeffect violation in sctp_sf_heartbeat()
>   o [SCTP] Blocking connect() support
>   o [SCTP] MSG_EOR support for recvmsg()
> 
> <taral@taral.net>:
>   o [IPSEC]: Fix double unlock in esp/ah
> 
> Adrian Bunk <bunk@fs.tum.de>:
>   o dv1394 devfs missing brace
>   o fix compile error in usb-serial.c
> 
> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
>   o [IPSEC]: Policy timeout and pfkey acquire fixes
> 
> Andi Kleen <ak@muc.de>:
>   o Some leftover nsec stat fixes (ADFS,AFS,CIFS)
> 
> Andrew Morton <akpm@digeo.com>:
>   o fix the build for egcs-1.1.2
>   o detect uninitialised per-cpu storage
>   o explicitly initialise kstat per-cpu storage
>   o misc
>   o shmdt bugfix
>   o radix-tree reinitialisation fix
>   o Add SMP barrier to ipc's grow_ary()
>   o reduce CPU cost in loop
>   o Expanded bad page handling
>   o Make inode_ops->setxattr value parameter const
>   o fix endian problem in ext3 htree code
>   o remove a warning from __block_write_full_page()
>   o ext2/ext3 Orlov directory accounting fix
>   o bootmem crash fix
>   o Fix busy-wait with writeback to large queues
>   o Remove mapping->vm_writeback
>   o strengthen the `incremental min' logic in the page
>   o handle zones which are full of unreclaimable pages
>   o no-buffer-head ext2 option
> 
> Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
>   o inode_mknod parameters
>   o compilation fix (tpyo)
>   o *_mknod prototype
>   o kill i_dev
>   o fcntl fix
> 
> Andy Grover <agrover@groveronline.com>:
>   o ACPI: Fix compilation error when CONFIG_SOFTWARE_SUSPEND is not set
>     (Shawn Starr)
>   o ACPI: fix debug print levels, and use down() instead of
>     down_interruptible(), and some whitespace.
>   o ACPI: Interpreter fixes Fixed memory leak in method argument
>     resolution Fixed Index() operator to work properly with a target
>     operand Fixed attempted double delete in the Index() code Code size
>     improvements Improved debug/error messages and levels Fixed a
>     problem with premature deletion of a buffer object
>   o ACPI: Add ec_read and ec_write external functions Other ec.c
>     cleanups, too
> 
> Anton Blanchard <anton@samba.org>:
>   o disable old stat on ppc64
> 
> Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
>   o tr: make CONFIG_TR depend on CONFIG_LLC=y
>   o wdt: fix up header cleanups: add include linux/interrupt.h
>   o hotplug: fix up header cleanups: add include linux/interrupts.h
>   o sound: more fixups for header cleanup: add include
>     <linux/interrupt.h>
>   o i2c: fix up header cleanups: add include <linux/interrupt.h>
>   o input: fix up header cleanups: add include <linux/interrupt.h>
>   o smbfs: fixup header cleanups: forward declare struct sock, add
>     include/uio.h
>   o scsi: fix up header cleanups: add include <linux/interrupt.h>
>   o hd: fix up header cleanup: add include <linux/interrupt.h>
>   o i2o: fix up header cleanups: add include <linux/interrupt.h>
>   o tcic: fix up header cleanups: add include <linux/interrupt.h>
>   o sound: fix up header cleanups: add include <linux/interrupt.h>
>   o net/core: export sk_send_sigurg, its needed by x25 when built as a
>     module
>   o net: fix up header cleanups: remove unneeded sched.h include
>   o drivers/net: fix up header cleanup: remove unneeded sched.h
>     includes
>   o o drivers/net/hamradio: fix up header cleanups: remove uneeded
>     sched.h includes
>   o o drivers/net/wan/lmc: fix up header cleanups: remove uneeded
>     sched.h includes
> 
> Art Haas <ahaas@airmail.net>:
>   o C99 initializer for fs/afs/inode.c
>   o C99 initializers for drivers/serial
>   o C99 initializer for drivers/zorro/proc.c
>   o C99 initializers for drivers/message/i2o/i2o_config.c
>   o C99 initializers for drivers/pci
>   o C99 initiailzers for fs/intermezzo
>   o C99 initializers for drivers/pcmcia
>   o C99 initializers for drivers/ieee1394
>   o C99 initializers for drivers/input
>   o C99 initializers for drivers/block/cciss_scsi.c
>   o C99 initializers for drivers/scsi
>   o C99 initializers for drivers/cdrom
>   o C99 initializers for drivers/i2c
>   o C99 initializers for drivers/parisc
>   o C99 initializers for drivers/parport
>   o C99 initializers for drivers/pnp
>   o C99 initializers for drivers/sgi
>   o C99 initializers for drivers/s390
>   o C99 initializers for drivers/tc
>   o C99 initializers for drivers/telephony
>   o fix C99 initializers fix
>   o C99 initializer for init/initramfs.c
>   o C99 initializer for drivers/parisc/ccio-dma.c
>   o C99 initializer for fs/ext2/dir.c
>   o C99 initializer for fs/sysv/super.c
> 
> Ben Fennema <bfennema@falcon.csc.calpoly.edu>:
>   o fix nanosecond stat timefields in UDF
> 
> Brian Gerst <bgerst@didntduck.org>:
>   o break up fs/devices.c
> 
> Chris Wright <chris@wirex.com>:
>   o sys_capget should use current if the pid argument is 0
>   o remove duplicated assignment from sys_capget
> 
> Christoph Hellwig <hch@lst.de>:
>   o make scsi_ioctl.h useable without including scsi.h
>   o rationalize allocation and freeing of struct scsi_device
>   o remove dead struct/typedef from hosts.h
>   o remove unused includes and misleading comments from scsi_lib.c
>   o fix compilation for !CONFIG_SWAP
>   o uClinux bits for /dev/zero
> 
> Dave Jones <davej@codemonkey.org.uk>:
>   o A new Athlon 'bug'
>   o Move watchdog drivers to drivers/char/watchdog/
> 
> David S. Miller <davem@nuts.ninka.net>:
>   o [SPARC64]: PCI device name changes
>   o [SPARC64]: Missing linux/interrupt.h includes
>   o arch/sparc64/kernel/sys_sunos32.c: Include net/sock.h
>   o [SPARC64]: More missing includes after the cleanups
>   o [SPARC64]: Nanosecond time changes
>   o [SPARC64]: More nanosecond timestamp updates
>   o [SCSI]: drivers/scsi/scsi.h needs linux/init.h
>   o [PARPORT]: drivers/parport/ieee1284.c needs sched.h and timer.h
>   o [QLOGICFC]: drivers/scsi/qlogicfc.c needs interrupt.h
>   o [SPARC64]: drivers/sbus/char/bbc_i2c.c needs interrupt.h
>   o [SCSI]: drivers/scsi/qlogicpti.c needs interrupt.h
>   o [SCSI]: drivers/scsi/qlogicisp.c needs interrupt.h
>   o [SCSI]: drivers/scsi/aic7xxx_old.c needs interrupt.h
>   o [SCSI]: drivers/scsi/esp.c needs interrupt.h plus fix abort/reset
>     locking
>   o [SCSI]: drivers/scsi/sym53c8xx_2/sym_glue.h needs interrupt.h
>   o [SPARC]: Module loading API updates
>   o [SOUND]: sound/sparc/{amd7930,cs4231}.c needs interrupt.h
>   o [SPARC]: Implement module_{init,core}_size
>   o [SPARC64]: isa_{device,bus} --> sparc_isa_{device,bus}
>   o [SPARC]: Add set_tid_address syscall vectors
>   o [IPSEC]: Make xfrm_user key manager return proper errors
>   o [CRYPTO]: Forgot to add crypto_null.c in previous commit
>   o [CRYPTO]: Kill stray CRYPTO_ALG_TYPE_COMP
>   o [NET]: Make sock_ioctl truly static
>   o [SPARC]: Add epoll syscall entries
>   o [TG3]: Use spin_lock_irq{save,restore} on tx_lock
>   o [VLAN]: remove vlan_devices[] entries properly
>   o [SPARC64]: Move data.cacheline_aligned right before edata
>   o [XFRM_USER]: Index xfrma array correctly
>   o [SPARC]: Remove schedule_tail ifdefs
>   o [SPARC]: Update for new do_fork semantics
>   o [SPARC]: Handle clone flag name changes
> 
> David S. Miller <davem@redhat.com>:
>   o Missing unlock_kernel() in fs/block_dev.c
> 
> David Woodhouse <dwmw2@infradead.org>:
>   o JFFS2 update
>   o Fix nanosecond merge
> 
> Dominik Brodowski <linux@brodo.de>:
>   o cpufreq: cleanups
> 
> Douglas Gilbert <dougg@torque.net>:
>   o scsi_debug 1.65 for lk 2.5.48
> 
> Eric Brower <ebrower@usa.net>:
>   o [SPARC]: Make APC idle a boot time cmdline option
> 
> Greg Kroah-Hartman <greg@kroah.com>:
>   o USB: vicam.c driver fixes
>   o ISDN: Convert usages of pcibios_* functions to pci_*
>   o PCMCIA: remove usage of pcibios_read_config_dword
>   o PCI: removed pcibios_read_config_* and pcibios_write_config_*
>     functions
>   o USB:  usb-serial core updates
> 
> Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
>   o IPv6: Fix BUG When Received Unknown Protocol
> 
> Ingo Molnar <mingo@elte.hu>:
>   o threading enhancements, tid-2.5.48-C0
> 
> Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
>   o alpha: initrd vs. "mem=" fix
>   o PCI: transparent bridge detection fix
>   o PCI setup: misc cleanups and fixes
>   o compile fixes
>   o PCI: rename exported pbus_* functions
> 
> James Bottomley <jejb@mulgrave.(none)>:
>   o fix queue run on returning I/O [axboe@suse.de]
>   o fix queue plug performance problem found by akpm
> 
> James Morris <jmorris@intercode.com.au>:
>   o [CRYPTO] kstack cleanup (v0.28)
>   o [CRYPTO]: Fix non-modular build
>   o [CRYPTO]: Add maintainers entry
>   o [CRYPTO]: Minor doc update
>   o [CRYPTO]: Add null algorithms and minor cleanups
> 
> Jeff Garzik <jgarzik@redhat.com>:
>   o [CRYPTO]: Kill accidental double memset
> 
> Jon Grimm <jgrimm@touki.austin.ibm.com>:
>   o [SCTP] sctp_params cleanup (jgrimm)
>   o [SCTP] More param handling, mostly handling hostname parm (jgrimm)
>   o [SCTP]: sctp_process_init can fail; cleanup and bail on errors. 
>     (jgrimm)
>   o [SCTP] sctp_addr code cleanup
>   o [SCTP] Handle "no route" case for output handler (jgrimm)
>   o [SCTP] Addr family cleanup part 2.  (jgrimm)
>   o [SCTP]: enable v6 autobinding
>   o [SCTP] PF_INET6 sockets should accept v4 addresses into association
> 
> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
>   o kbuild: Fix KBUILD_MODNAME
>   o kbuild: arch/i386/oprofile/Makefile cosmetics
> 
> Linus Torvalds <torvalds@home.transmeta.com>:
>   o Devfs was broken by the nanosecond inode times. Fix properly
>   o Parts of "module.c" was needed even when no module support was
>     enabled, so split it up into "extable.c"
>   o Broken applications do not realize that a zero return from
>     "write()" is an error condition, and hang retrying.
>   o Don't trust "rq->cmd_len", most of the internal IDE-CD command
>     sending routines don't set it up.
>   o Add <asm/io.h> include for readw uses in <pcmcia/mem_op.h>
> 
> Luca Barbieri <ldb@ldb.ods.org>:
>   o dup_mmap tiny optimization
>   o Small futex improvement
> 
> Martin Schwidefsky <schwidefsky@de.ibm.com>:
>   o s390: config & make
>   o s390: system calls
>   o s390: mman
>   o s390: 64bit sector_t
>   o s390: module loader
>   o s390: missing includes
>   o s390: uaccess bug
>   o s390: gcc 3.2 fixes
>   o s390: ebcdic conversion bug
>   o s390: flushtlb bug
>   o s390: isclean bug
>   o s390: 31bit emulation
>   o s390: xpram driver
>   o s390: warnings
>   o s390: sclp driver part 1
>   o s390: sclp driver part 2
> 
> Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
>   o usb-storage: change function signatures and cleanup debug msgs
>   o usb-storage: fix missed changes in freecom.c and isd200.c
>   o usb-storage: code consolidation
> 
> Matthew Wilcox <willy@debian.org>:
>   o missing smp.h in topology.c
>   o remove sched.h from sctp/sm.h
>   o rename get_lease to break_lease
> 
> Neil Brown <neilb@cse.unsw.edu.au>:
>   o Fix *_mergeable_bvec routines for linear/raid0
>   o Fix r5 bug - wrong variable used
>   o Tidy up some handling of sb_dirty in md.c
>   o Remove unused variable in umem.c
>   o Avoid 'defined but not used' warning with i386/xor.h
>   o NFSv3 to extract large symlinks from paginated requests
>   o Fix err in size calculation for readdir response
>   o Fix bug in svc_udp_recvfrom
>   o Avoid copying unfragmented udp NFS requests
>   o Only set dest addr in NFS/udp reply, not NFS/tcp
>   o kNFSd - 1 of 2 - Change NFSv4 xdr decoding to cope with separate
>     pages
>   o kNFSd - 2 of 2 - Change NFSv4 reply encoding to cope with multiple
>     pages
> 
> nicolas.mailhot@laposte.net <Nicolas.Mailhot@laposte.net>:
>   o Via KT400 agp support
> 
> Patrick Mansfield <patmans@us.ibm.com>:
>   o Re: 2.5.48 /proc/scsi directory missing
>   o remove unused includes and misleading comments from scsi_lib.c
> 
> Patrick Mochel <mochel@osdl.org>:
>   o make sure DEBUG is #undef'd so it's really turned off
>   o make sure cpu class is registered before cpu driver
>   o driver model: make sure driver is added to class it belongs to
>   o driver model: catch one last #define DEBUG 0
>   o driver model: don't double up() if device registration fails
>   o driver model: typo in intf.c
>   o kobject - expose backend helpers to registration interface
>   o sysfs: do permission checking on open
>   o driver model: exploit kobject contstructs
>   o driver model: keep reference to device during device_add()
>   o sysfs: various updates
>   o driver model: update and clean bus and driver support
>   o driver model: make classes and interfaces use kobject
>     infrastructure
>   o USB: minor driver model-related updates
>   o partitions: use the name in disk->kobj.name, instead of
>     disk->disk_name
> 
> Paul Mackerras <paulus@samba.org>:
>   o PPC32: adjust some includes in response to recent include cleanups
>   o PPC32: adjust <asm/atomic.h> so it doesn't need <asm/system.h>
>   o PPC32: Move BUG() definition from asm-ppc/page.h to
>     asm-ppc/processor.h
>   o PPC32: clean up the arch/ppc/boot Makefiles
> 
> Pete Zaitcev <zaitcev@redhat.com>:
>   o [SPARC]: Fix finish_arch_switch and factor PIL users
> 
> Petr Vandrovec <vandrove@vc.cvut.cz>:
>   o [LLC]: Fix timer_init calls
>   o Merge lcall7 and lcall27 code paths in ia32
>   o Mark executable files as executable on ncpfs
>   o Small matroxfb fixes
> 
> Richard Henderson <rth@are.twiddle.net>:
>   o Fix carry ripple in 3 and 4 word addition and subtraction macros
>   o Fix a whole pile of signed/unsigned comparison warnings
>   o Remove duplicate sys_rx164.o in GENERIC kernel
>   o Avoid multi-line string literal for asm block
>   o Add Alpha entry in MAINTAINERS
>   o Misc alpha compilation fixes
>   o Include IEEE1394 configury
>   o Add new syscalls
>   o Remove dead module code so that builds with CONFIG_MODULES=n will
>     succeed.
>   o Fix scsi build wrt include files
>   o Cset exclude: rth@are.twiddle.net|ChangeSet|20021118212616|10632
>   o Add dummy <asm/suspend.h> for alpha
> 
> Richard Henderson <rth@dorothy.sfbay.redhat.com>:
>   o Remove osf_swapon; fall back to sys_swapon immediately
>   o [ALPHA] Update clone syscall for child_tid argument
> 
> Rik van Riel <riel@conectiva.com.br>:
>   o advansys.c buffer overflow
> 
> Robert Love <rml@tech9.net>:
>   o ALSA compiler warnings fixes
> 
> Russell King <rmk@flint.arm.linux.org.uk>:
>   o [ARM] Add cpu_flush_pmd()
>   o [ARM] Acorn SCSI build fixes
>   o [ARM] 2.5.48 Build fixes (round 1)
>   o [ARM] 2.5.48 module fixups (and disable module loading for ARM)
>   o [ARM] Undefine symbol "arm", update mach-types
>   o [ARM] 2.5.48 Build fixes (round 2)
>   o [ARM] Update ARM bitops to operate on unsigned long quantities
>   o [ARM] Fix ARM module support
>   o [ARM] Fixups for 2.5.48-bkcur
> 
> Rusty Russell <rusty@rustcorp.com.au>:
>   o kallsyms for new modules
>   o PPC32: In-kernel module linker for PPC
>   o module device table restoration
>   o Module length calculation fix and module with no init fix
> 
> Sam Ravnborg <sam@ravnborg.org>:
>   o [SPARC64]: Use kbuild more consistently, add archhelp target
>   o [SPARC64]: Makefile cleanups
> 
> Stelian Pop <stelian@popies.net>:
>   o sonypi driver update
>   o meye driver update
> 
> Steve French <stevef@steveft21.ltcsamba>:
>   o Properly emulate POSIX semantics for deleting of open files and
>     renaming over open files.  Fix oops in readpages caused by
>     unitialized aops field
> 
> Tom Rini <trini@kernel.crashing.org>:
>   o Add back in <asm/system.h> and <linux/linkage.h> to
>     <linux/interrupt.h>
> 
> Trond Myklebust <trond.myklebust@fys.uio.no>:
>   o Support for micro/nanosecond [acm]time in the NFS client
>   o Split buffer overflow checking out of struct nfs4_compound
> 
> William Lee Irwin III <wli@holomorphy.com>:
>   o Numa-Q bootup failure fix
>   o input: fix up header cleanups: add <linux/interrupt.h>
>   o sched: privatizes the sibling inlines to sched.c, the sole caller
>     of them
> 
> Zwane Mwaikambo <zwane@holomorphy.com>:
>   o USB core/config.c == memory corruption
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

