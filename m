Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTJHTsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTJHTsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:48:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:34460 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261760AbTJHTrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:47:49 -0400
Date: Wed, 8 Oct 2003 12:47:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0-test7 - stability freeze
Message-ID: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The -test7 kernel is out there now - I'm not reaching bkbits.net, but it's 
on the other BK sites, and the tar-ball and patches are uploading to 
kernel.org right now.

The biggest part of the test7 patches are:
 - s390 update
 - DVB update
 - NFS (v4 in particular) update
 - cpufreq updates
 - ACPI update

A lot of the rest are basically a lot of small onelines, along with fairly
minor updates (networking fixes for shared skb's for remaining cases,
janitorials, cleanups etc).

The more interesting thing is that I and Andrew are trying to calm down 
development, and I do _not_ want to see patches that don't fix a real and 
clear bug. In other words, the "cleanup and janitorial" stuff is on hold, 
and -test8 and then -test9 should be for _stability_ fixes only.

In other words, this should calm things down so that by the end of October
we can look at the state of 2.6.0 without having a lot of noise from "not
strictly necessary" stuff.

			Linus

-----

Summary of changes from v2.6.0-test6 to v2.6.0-test7
============================================

<dfages:arkoon.net>:
  o [NET]: Fix HW_FLOWCONTROL on SMP

<lxiep:us.ibm.com>:
  o PCI Hotplug: export hotplug_slots subsys

Achim Laubner:
  o gdth driver update

Adrian Bunk:
  o select for fs/Kconfig

Alan Stern:
  o USB: unusual_devs.h update

Alexander Viro:
  o EFS set_blocksize() error handling
  o Better UDF oops fix
  o Improve sget() performance

Alexey Dobriyan:
  o PCI: Remove setting TASK_RUNNING after schedule_timeout in
    /drivers/pci/

Amn3S1A:
  o USB: New unusual_devs.h entry (Minolta DiMAGE E223 Digital Camera)

Andi Kleen:
  o Reserve vserver syscall for x86-64
  o Fix -Wdeclaration-after-statement warnings for x86-64
  o Fix x86-64 compilation
  o Fix linux32 personality on x86-64
  o Remove outdated URLs from x86-64 Kconfig
  o UID16 fixes
  o cpufreq for x86-64
  o Fix x86-64 signal FPU saving bug
  o [NET]: Fix obvious 64bit bug/warning in farsync.c
  o [NET]: Fix 64-bit bugs in dscc4.c

Andrew Morton:
  o [NET]: Fix xfrm_algo.c module exports
  o dscc4 warning fixes
  o Fix memory leak in hugetlbfs
  o Fix double request_region in com20020
  o Add bin2c copyrights
  o Add missing label in isdn_common.c
  o dev_t forward compatibility fix
  o x86 mman.h fix
  o memory writeback/invalidation fixes
  o table-driven filesystems option parsing
  o module parameter array fixes
  o check permission in ->open for /proc/sys/
  o fix memleak in mtd/chips/cfi_cmdset_0020.c
  o Fix bug in SELinux convert_context
  o Pass nameidata to security_inode_permission hook
  o scripts/pnmtologo.c warning fixes
  o befs: fix resource leak on register_filesystem failure
  o misc fixes
  o /proc/PID/auxv file and NT_AUXV core note
  o update Documentation/iostats.txt
  o Fix compile warning in g_NCR5380
  o Fix allyesconfig for HugeTLB-less archs
  o ioctl32 fix to SG_IO
  o Update James Morris's email address
  o update unistd.h for sys_vserver
  o Disable floppy and the related ioctl32s on some platforms
  o fix skb leak
  o more raw driver minor numbers
  o boot-time selectable log buffer size
  o Clean up MAX_NR_NODES/NUMNODES/etc. [1-5]
  o node enumeration fixes
  o compat ioctl consolidation
  o document the macro for translating PROT_ to VM_ bits
  o /proc/sys/auxv
  o kernel documentation fixes
  o EISA_bus cleanup
  o ext3 block allocator locking fix
  o dscc4 driver fixes
  o cpufreq sysfs oops fix
  o move job control fields from task_struct to
  o fix "compat ioctl consolidation" for "move job
  o fix pte_chain leak in do_no_page()
  o fix ia64 core dump code

Andries E. Brouwer:
  o affs, befs, ext3, fat, freevxfs, hfs, hpfs, jbd, jfs sparse fixes

Armin Schindler:
  o Eicon ISDN driver: fix compile error
  o Eicon ISDN driver: cleanups

Arnaldo Carvalho de Melo:
  o distribute EXPORT_SYMBOLS from netsyms.c and ksyms.c to the
    places that define them. Avoid centralization.
  o net/netsyms.c and kernel/ksyms.c bite the dust
  o [NET]: asm-parisc/checksum.h needs linux/in6.h
  o asus_acpi: don't include modversions.h

Arun Sharma:
  o [COMPAT]: Fix net bonding driver ioctl translations

Bart De Schuymer:
  o [EBTABLES]: Add ebt_limit match
  o [EBTABLES]: Use vlan_hdr not vlan_ethhdr in ebt_vlan.c
  o [BRIDGE]: Let {ip,arp}tables see bridged VLAN packets

Bartlomiej Zolnierkiewicz:
  o fix /proc/ide/hdX/settings
  o update ali14xx driver
  o update dtc2278 driver
  o update ht6560b driver
  o update qd65xx driver
  o update umc8672 driver
  o small cleanup for VIA IDE driver
  o update pdc4030 driver
  o small cleanup for AMD/nVidia IDE driver
  o cmd64x: kill dummy init_dma_cmd64x()
  o cs5530: kill dummy init_dma_cs5530()
  o generic: kill dummy init_dma_generic()
  o hpt34x: kill dummy init_dma_hpt34x()
  o it8172: kill dummy init_dma_it8172()
  o ns87415: kill dummy init_dma_ns87415()
  o opti621: kill dummy init_dma_opti621()
  o pdc202xx_new: kill dummy init_dma_pdc202new()
  o piix: kill dummy init_dma_piix()
  o sc1200: kill dummy init_dma_sc1200()
  o siimage: kill dummy init_dma_siimage()
  o sis5513: kill dummy init_dma_sis5513()
  o slc90e66: kill dummy init_dma_slc90e66()
  o remove PDC-ADMA placeholders

Ben Fennema:
  o UDF oops on inode read failure

Bjorn Helgaas:
  o [SERIAL] 2.6 ACPI serial discovery
  o [SERIAL] remove unused RS_TABLE definitions
  o [SERIAL] removing legacy UART cruft
  o [Serial] Fix warnings in 8250_acpi

Brian Gerst:
  o i386 do_machine_check() is redundant

Chas Williams:
  o [ATM]: Eliminate atm_find_ci()
  o [ATM]: Convert VCC list to hash

Chen Yang:
  o InterMezzo maintainence patch

Christoph Hellwig:
  o [PCMCIA] kill useless CS_RELEASE printing

Daniel Drake:
  o USB brlvger: Debug code fixes
  o (2.6.0-test6-bk) DocBook: Kernel-api build fix

Daniel Ritz:
  o [PCMCIA] Add missing ZV parts

Dave Jones:
  o [CPUFREQ] Typo
  o [CPUFREQ] Merge AMD Opteron/Athlon64 powernow driver
  o [CPUFREQ] update supported CPUs list in Documentation
  o [CPUFREQ] powernow-k8 compile fix
  o [CPUFREQ] Fix ordering in kconfig
  o megaraid ULL fix
  o K7 MCE handler fixes
  o Correct address in MAINTAINERS
  o ULL fixes for qlogicfc
  o Cleanup SEP errata workaround
  o fix leak in btaudio
  o logic thinko in i2c
  o Correct URL in h8300 README
  o VIA Typo in i2c
  o [AGPGART] New VIA AGP PCI id
  o [CPUFREQ] Longhaul >v1 can't use EBLCR for FSB, has to calculate it
    instead
  o [CPUFREQ] powernow-k8 isn't using cpufreq table helpers yet
  o [CPUFREQ] fix up the invalid usage of pol->policy in drv_init()
  o [CPUFREQ] update URL
  o [CPUFREQ] find_closest_fid() can be static
  o [CPUFREQ] powernow-k8 Namespace cleanups
  o [CPUFREQ] Fix my breakage of Dominik's powernow-k8 ->govenor fix
  o [CPUFREQ] Fix documentation pathname typos
  o [CPUFREQ] Enable support for VIA Ezra-T processors in longhaul
    driver
  o [CPUFREQ] Rename longhaul frequency tables. longhaul1 -> samuel1
  o [CPUFREQ] Document early samuel2 ratios
  o [CPUFREQ] More ratio table renames. longhaul2 -> ezra
  o [CPUFREQ] Ratio table renames longhaul3/c3m -> ezrat
  o [CPUFREQ] cleanup longhaul header file
  o [CPUFREQ] Fix misnaming of VIA Samuel2 CPUs
  o [CPUFREQ] Add VIA Nehemiah scaling ratios

David S. Miller:
  o [KERNEL]: Do not export set_cpus_allowed twice, and only if
    CONFIG_SMP
  o [IPV4]: Do pskb_may_pull in arp_rcv() not arp_process()
  o [IPV4]: In arp_rcv(), inspect skb->nh.arph after pskb_may_pull()
    not before
  o [SPARC64]: Always use sethi+jmpl to reach VISenter{,half}
  o [NETFILTER]: Add sysctl values missing from recent commit
  o [ELF]: Handle auxv bits more cleanly in mixed 32/64 bit
    environments
  o [ELF]: Fix bug in previous change, forgot to advance ei_index over
    AT_NULL entry
  o [SPARC64]: vmap/vunmap cache flushing need not do anything
  o [SPARC]: Reserve syscall slot for VSERVER
  o [SPARC64]: Update defconfig
  o [SPARC64]: Kill stray task->tty reference in Solaris module
  o [SPARC64]: Clean up uid16 usage just like x86_64 did
  o [ECONET]: Fix packet handler to be PKT_CAN_SHARE_SKB
  o [BPQETHER]: Fix packet handler to be PKT_CAN_SHARE_SKB
  o [LAPB]: Fix packet handlers to be PKT_CAN_SHARE_SKB
  o [IPV4]: Fix ipconfig to be PKT_CAN_SHARE_SKB
  o [X25]: Fix to be PKT_CAN_SHARE_SKB
  o [NET]: Add missing skb_share_check() calls to
    econet/bpqether/lapbether/ipconfig
  o [NETLINK]: Set socket error on netlink_ack() allocation failure
  o [NET]: Delete support for old-style protocols, no longer necessary
  o [NET]: Size hh_cache->hh_data[] properly
  o [SPARC64]: Export csum_partial()
  o [SUNRPC]: Printf pointers correctly
  o [NFS]: Fix printf format warnings in fs/nfs/nfs4xdr.c
  o [USB]: Fix encapsulation of int inside of pointer in code/file.c
  o [UDP/TCP]: Fix binding conflict tests wrt. SO_BINDTODEVICE
  o [UDP]: Fix typo in SO_BINDTODEVICE changes

Dean Roehrich:
  o [XFS] Change dm_send_destroy_event to use vnode ptrs rather than
    bhv ptrs
  o [XFS] Make dm_send_data_event use vp rather than bhv

Deepak Saxena:
  o [ARM PATCH] 1624/1: BE support for io-readsl-armv4.S,
    io-reads-armv4.S, io-writesw-armv4.S

Duncan Sands:
  o USB speedtouch: extra debug messages
  o USB speedtouch: reduce memory usage
  o USB speedtouch: neater check

Eric Brower:
  o [SPARC64]: Fix kernel_thread() return value check in envctrl.c

Eric Sandeen:
  o [XFS] Allow full 32 bits in sector number when XFS_BIG_BLKNOS not
    set
  o [XFS] Fix large filesystem mounts on 64-bit platforms (2.6.x change
    only)
  o [XFS] Fix arg sent to XFS_SEND_DATA - vnode, not bhv
  o [XFS] Re-work pagebuf stats macros to help support per-cpu data

François Romieu:
  o Fix debug statement after return in
    drivers/net/wireless/arlan-main.c

Geert Uytterhoeven:
  o m68k zImage
  o Q40/Q60 interrupts
  o Sun-3 bootmem
  o Sun-3 SCSI
  o Q40/Q60 interrupts
  o M68k PCI
  o M68k bitops
  o Atari ST-RAM missing include
  o Mac SWIM floppy missing include
  o Atari ACSI fix
  o Macintosh 8390 Ethernet update
  o Atari Hades support is broken
  o Atari ST-RAM swap is broken
  o Macintosh SWIM IOP floppy is broken
  o Atari ACSI is broken
  o 53c7xx SCSI core is broken
  o Amiga A2091 SCSI is broken
  o Amiga GVP-II SCSI is broken
  o Atari Bionet Ethernet is broken
  o Atari Pamsnet Ethernet is broken
  o MVME166/7 CD2401 serial is broken
  o Macintosh CS89x0 Ethernet is broken
  o Atari frame buffer device is broken
  o Amiga CyberVision 64 frame buffer device is broken
  o Amiga Retina Z3 frame buffer device is broken
  o Amiga Cybervision 64/3D frame buffer device is broken
  o Sun-3/3x frame buffer device is broken
  o Atari NCR5380 SCSI is broken
  o Macintosh SMC 9194 Ethernet is broken
  o Dmasound config
  o Amiga Zorro bus doc updates
  o Amiga A2091 SCSI fix
  o Amiga GVP-II SCSI fix
  o Zorro include guards
  o Amiga A2232 Serial typo
  o M68k sched_clock()
  o Generic serial warning

Gerd Knorr:
  o v4l: videobuf update
  o v4l: bttv driver update
  o v4l: saa7146 driver update
  o saa7134 driver update

Greg Kroah-Hartman:
  o USB: convert usbfs to use new fs parser code
  o USB: port keyspan patch from 2.4 to 2.6
  o USB: fix up some non-GPL friendly license wording

Harald Welte:
  o [NETFILTER]: Fix UDP checksum in ip_nat_mangle_udp_packet, remove
    skb->csum hacks
  o [NETFILTER]: LOCAL_OUT NAT fix
  o [NETFILTER]: Cosmetic update to ip6t_ipv6header
  o [NETFILTER]: Fix SO_ORIGINAL_DST, broken by earlier endianness
    fixes

Herbert Xu:
  o [IPIP]: Avoid duplicate policy checks
  o [NETLINK]: netlink.h needs types.h

Hirofumi Ogawa:
  o VFAT: ->i_[cam]time cleanups (1/6)
  o use ->d_lock instead of dcache_lock in vfat_revalidate (2/6)
  o Fix unrecognized option of fat (3/6)
  o Fix cleanup option of fat (4/6)
  o lib/parser: Use "%u" instead "%d" (5/6)
  o lib/parser: Not recognize nul string as "%s" (6/6)

Ivan Kokshaysky:
  o Alpha cypress CPU frequency calibration

Jan Kara:
  o Quota bugfix

Jan Oravec:
  o [IPV6]: Deactivate timers properly in ipv6_mc_destroy_dev()

Jay Estabrook:
  o for Alpha against 2.6.0-test6

Jeff Garzik:
  o [MCA] include linux/mca-legacy.h directly, to access deprecated MCA
    API
  o [MCA] convert mca-proc to use not-deprecated functions
  o [MCA] don't include linux/mca-legacy.h from linux/mca.h
  o [wireless arlan] fix modular build
  o Misc warning fixes
  o [janitor] Replace bcopy() uses with memcpy(), where possible
  o [BK] "bk ignore" aic7xxx auto-generated files

Jens Axboe:
  o kill CDROM_SEND_PACKET
  o make ide-floppy work
  o check copy_from_user return value in sony535

Jes Sorensen:
  o qla1280 locking update

Joe Perches:
  o USB: include/linux/usb.h

John Levon:
  o fix warning with CONFIG_PROFILING=y

Jozsef Kadlecsik:
  o [NETFILTER]: Make conntrack timeouts become sysctls

Julian Anastasov:
  o [KERNEL]: Introduce list_for_each_entry_continue
  o [IPVS]: Simplify ip_vs_wrr_gcd_weight
  o [IPVS]: The NQ scheduler must not return servers with weight 0
  o [IPVS]: Use list_for_each_entry_continue in some schedulers
  o [IPVS]: Properly handle non-linear skbs
  o [IPVS]: remove some unused fields from the protocols
  o [IPV4/IPV6]: Do not modify skb->h.raw until skb is unshared
  o [IPVS]: Avoid returning NF_DROP from the packet schedulers

Jörn Engel:
  o Fix wrong CONFIG_* in comment

Len Brown:
  o sync 2.4.22 changes into 2.6 Note that this restores
    CONFIG_ACPI_HT_ONLY as a sub-set of CONFIG_ACPI rather than a
    dependency.
  o Handle BIOS with _CRS that fails (Jun Nakajima)
  o [ACPI] Handle systems that specify non-ACPI-compliant SCI
    over-rides (Jun Nakajima)
  o Extended IRQ resource type for nForce (Andrew de Quincey)
  o IBM ThinkPAD T30/T40 oops (David Shaohua Li)
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849
  o remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
  o ACPI_CA_VERSION                 0x20030916
  o [ACPI] avoid alloc_bootmem() for accessing ACPI tables some
    platforms use ACPI tables to find memory (Jesse Barnes)
  o [ACPI] Fix IO-APIC mode SCI interrupt storm on Tyan
    http://bugzilla.kernel.org/show_bug.cgi?id=774
  o [ACPI] acpi_disabled is used after __initdata is freed
  o [ACPI] fix IO-APIC mode SCI storm due to sharing with PCI device
    (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1165
  o [ACPI] remove __initdata from acpi_disabled for module use (Andi
    Kleen)
  o [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi
    Kleen)
  o [ACPI] CONFIG_ACPI_RELAXED_AML from 2.4
    http://bugzilla.kernel.org/show_bug.cgi?id=1248
  o [ACPI] ACPI Component Architecture 20030918 (Bob Moore)
  o [ACPI] CONFIG_ACPI is no longer necessary to enable HT (from
    2.4.23) if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y
  o [ACPI] add CONFIG_ACPI_RELAXED_AML to config menu
  o [ACPI] acpi_pci_link_allocate() should stick with irq.active if
    set. (Andrew de Quincey) Fixes OSDL #1186 "broken USB" and others
  o [ACPI] GV3 IO port is 16-bits (Venkatesh Pallipadi)
  o [ACPI] acpi4asus-0.24a-0.25-2.6.0-test (Karol Kozimor)
  o [ACPI] acpi4asus-0.25-0.26.diff (Karol Kozimor)
  o [ACPI] build fix: remove 2nd __exit from asus_acpi.c
  o [ACPI] deal with lack of acpi prt entries gracefully (Jesse Barnes)

Linus Torvalds:
  o Select the i8042 driver for mouse and keyboard only on PC's
  o Fix bogus preprocessor end comment to match the real scope
  o Use "select" instead of "depends on" to select GAMEPORT support
    automatically for the sound drivers that require it. 
  o Fix PCMCIA cut-and-paste cs.c bug introduced by the recent update.
  o Fix __wake_up_sync() module export. It hadn't been correcly moved
    from kernel/ksyms.c to kernel/sched.c.
  o Avoid warnings in uid/gid usage by making the assignment
    unconditional. Simplify the macros.
  o Fix up recent net/ipv4/ipconfig.c typo breakage
  o Revert the move of ptrinfo - it may make NOMMU compile, but it
    breaks everybody else.

Luiz Capitulino:
  o USB: fix drivers/usb/host/uhci-debug.c warning when !CONFIG_PROC_FS
  o [IPV4]: Fix route.c build warning when procfs is disabled

Marc Zyngier:
  o ne3210 update

Martin Schwidefsky:
  o s390 (1/7): base patch
  o s390 (2/7): common i/o layer
  o s390 (3/7): dasd driver
  o s390 (4/7): ctc driver
  o s390 (5/7): iucv driver
  o s390 (6/7): qeth driver
  o s390 (7/7): zfcp host adapter

Matthew Dharm:
  o USB: fix freecom.c

Matthew Wilcox:
  o Remove ELF_CORE_SYNC
  o PA-RISC updates
  o unify drivers/Kconfig

Matthias Urlichs:
  o minor edit typo

Michael Hunold:
  o DVB: MAINTAINERS, CREDITS, ioctl-number.txt updates
  o Update V4L2 "Hexium" driver
  o firmware update for av7110 dvb driver
  o add new DVB-T frontend driver
  o video capture updates for saa7146 core
  o multiple device *read* opens support
  o update copyright and licensing
  o usual c99 initializer fixes
  o various patches for non-av7110 dvb-drivers
  o various av7110 dvb-driver updates
  o update dvb frontend drivers
  o Kconfig and Makefile updates, inspired by Adrian Bunk and Roman
    Zippel
  o some more av7110 dvb-driver updates
  o fix v4l1 backward compatibility in saa7146 driver
  o firmware blob for new DVB-T frontend driver

Michael Shields:
  o [SPARC64]: Fix watchdog on CP1500/Netra-t1
  o [SPARC64]: Fix typo in bbc_envctrl.c

Mikael Pettersson:
  o fix drivers/char/misc.c module autoloading breakage

Miles Bader:
  o Triple the memory size used on the v850 gdb simulator
  o Add sched_clock on v850
  o Remove some old debugging stuff on the v850
  o Update v850 Kconfig debugging menu
  o Move `ptrinfo' function from mm/slab.c to mm/memory.c
  o Changes to v850 platform linker-script fragments

Nathan Scott:
  o [XFS] Clean up inode revalidation code slightly

Nick Piggin:
  o remove bogus UP on SMP kernel error
  o AS fix
  o AS buglet
  o remove io context refcounting debug

Nicolas Pitre:
  o [ARM PATCH] 1674/1: better ARM division routines
  o [ARM PATCH] 1660/1: misc PXA/Lubbock fixes

Patrick McHardy:
  o [NETFILTER]: Don't call ip_conntrack_put with ip_conntrack_lock
    held
  o [NETFILTER]: Add size check for udp packet mangling
  o [NETFILTER]: Fix REJECT is used in LOCAL_OUT

Patrick Mochel:
  o [pci] Remove drivers/pci/power.c
  o [pci] Remove ->save_state() from struct pci_driver
  o [pci] Really delete drivers/pci/power.c
  o Remove ->save_state() in nsp32.c
  o Remove ->save_state() from vlsi_ir.c
  o Remove ->save_state() in sc1200.c

Paul Mackerras:
  o PPC32: Reformat bits of include/asm-ppc/uaccess.h
  o PPC32: Add hook for Mac-on-Linux to use exception vector 0x2f00
  o PPC32: Make 4 the default for CONFIG_NR_CPUS on PPC32
  o PPC32: Update defconfigs

Pete Zaitcev:
  o [SPARC]: jsflash update

Petr Vandrovec:
  o [IPV4]: Fix deadlock on ip_mc_list->lock

Petri Koistinen:
  o [NET]: Modernize network device help text
  o [CRYPTO]: Kconfig URL updates

Randy Dunlap:
  o janitor: fix cciss for !CONFIG_PROC_FS
  o janitor: Audit av7110_ir_init
  o janitor: opl3sa2 cleanups/checker
  o janitor: cleanup includes (sound/oss)
  o janitor: cleanup includes (drivers/char)
  o janitor: fix toshiba for !CONFIG_PROC_FS
  o janitor: saa7146_register_extension failure report back its
  o janitor: convert strtok to strsep (sound/oss)
  o janitor: init_nfsd() error handling
  o janitor: cleanup includes (mtd)
  o janitor: cpqarray for !CONFIG_PROC_FS
  o janitor: saa7146_register_extension failure report (ttpci)
  o janitor: cleanup includes (media/video)
  o janitor: cleanup includes (oss/dmasound)
  o janitor: cleanup includes (wireless/arlan)
  o janitor: Audit copy_to_user (ttusb)
  o janitor: fix for not CONFIG_PROC_FS
  o janitor: cleanup includes (drivers/media)
  o janitor: cleanup includes (cdrom)
  o janitor: saa7146_register_extension (ci) failure report
  o janitor: cleanup includes (telephony)
  o janitor: cleanup includes (drivers/video)
  o janitor: cleanup includes (acpi)
  o [NET]: Remove verify_area() in net/wan/sbni (from
    domen@coderock.org)
  o janitor: schedule_timeout sets curr->state (arm)
  o [NET]: schedule_timeout() sets curr_state, from Alexey Dobriyan
    <adobriyan@mail.ru>
  o [COSA]: schedule_timeout() sets curr_state, from Alexey Dobriyan
    <adobriyan@mail.ru>
  o [ATM]: schedule_timeout() sets curr_state, from Alexey Dobriyan
    <adobriyan@mail.ru>
  o fix warning in mm/memory for SWAP=n

Randy Hron:
  o [PCMCIA] remove unneeded includes

Rik van Riel:
  o syscall number for vserver

Robert Johnson:
  o PCI: __init documetation

Robin Farine:
  o [ARM PATCH] 1675/1: remove definitions of non-implemented system
    calls from include/asm-arm/unistd.h

Roland McGrath:
  o fix vsyscall page in core dumps
  o remove unused `locks' field from task_struct

Rolf Eike Beer:
  o shut up gcc 3.3 for scripts/pnmtologo.c

Russell King:
  o [PCMCIA] Socket quiescing changes
  o [SERIAL] Change maintainer entry for serial
  o [ARM] Fix ARM "make help" output
  o [ARM] Select decompressor mmu handling based upon the architecture
    IDs
  o [ARM] Remove redundant include of net/bluetooth/Kconfig
  o [ARM] Add ARMv5TEJ to processor architecture list
  o [ARM] Add system device for LEDs
  o [ARM] leds.c, being so basic, needs linux/compiler.h
  o [ARM] Make ARM use Pat's generic PM suspend to RAM support
  o [ARM] Make die() more correct
  o [ARM] Prepare Integrator support code for multiple machine support
  o [ARM] Clean up Integrator interrupt number definitions
  o [ARM] Move Integrator flash map to driver model
  o [ARM] Add sysdev model for Integrator/AP
  o [ARM] Update Integrator IRQ decoding
  o [ARM] Fix badly placed writeback/invalidation fixes
  o [ARM] Ensure BK file modes allow others to read
  o Fix sysrq-t free stack output

Rusty Russell:
  o [NETFILTER]: LOCAL_OUT NAT fix, part 2
  o Bugzilla bug # 267 - scripts_ver_linux fix
  o Use mod_timer in net_wanrouter_af_wanpipe.c
  o Remove extra #includes
  o Remove racy check_mem_region() call from pcbit_drv.c
  o Obvious sched doc fix
  o Rearrange error handling in fs_pipe.c a bit
  o Bugzilla bug # 984 - 2.6 readme is still for 2.5
  o Add hint on sysrq on some keyboards
  o Fix Linux 2.5 -> Linux 2.6
  o correct number of CPUs in Kconfig help file
  o Documentation_vm_hugetlbfs.txt cleanup
  o kconfig language doc r.e. ---help---
  o hlist constification
  o drivers_media_Kconfig URL update
  o sysv_hash() is cleanups
  o drivers_ide_Kconfig URL updates
  o Update for Documentation_binfmt_misc-document
  o Fix comment in parse_hex_value
  o irq_affinity_write_proc no longer writes garbage into irq proc
    entries
  o More modules.txt removals
  o [PATCH ac97_plugin_ad1980.c: warning fix
  o Bugzilla bug # 993 - Documenation_Changes still reads 2.5
  o update Kanoj Sarcar email address in docs
  o Get rid of magic numbers in fs
  o unused variable in drivers_char_esp.c
  o drivers_cpufreq_Kconfig URL update
  o ISDN PCBIT: fix nonmodular compile
  o Change list_emtpy() to take a const pointer
  o HISAX_SEDLBAUER_CS needs HISAX_SEDLBAUER
  o 2 spelling patches in helps
  o Small cleanups for input
  o unused variable in drivers_char_isicom.c
  o Christoph Hellwig no longer works at Caldera
  o Documentation_Changes visual cleanup

Sam Ravnborg:
  o kbuild: Remove all cscope files during mrproper
  o kbuild: fixes for separate output directory

Sander van Malssen:
  o fix btaudio error case

Sridhar Samudrala:
  o [SCTP] PPC64 port: Don't overload the optval arg of ADDRS_NUM
    socket
  o [SCTP] ADDIP: Support to send ASCONF chunk with ADD/DEL IP params
  o [SCTP] ADDIP: Handle ERROR chunk in response to an ASCONF chunk
  o [SCTP] ADDIP: Support for the creation of ASCONF_ACK chunk (Kevin)
  o [SCTP] Convert tv_add from static inline to a macro to fix an
    obscure assembler problem with parisc64.
  o [SCTP] Fix bugs in conversions between msecs and jiffies

Stephen Hemminger:
  o Fix warnings in hamradio/baycom build
  o [IRDA]: Get rid of destructor for irda devices
  o [IRDA]: Add alloc_irdadev() interface
  o [IRDA]: Convert irport to alloc_irdadev()
  o [IRDA]: Convert ali-ircc to alloc_irdadev()
  o [IRDA]: Convert donauboe to alloc_irdadev()
  o [IRDA]: Convert nsc-ircc to alloc_irdadev()
  o [IRDA]: Convert w83977af_ir to alloc_irdadev()
  o [IRDA]: Convert sir to alloc_irdadev()
  o [IRDA]: Convert via-ircc to alloc_irdadev()
  o [IRDA]: Use unregister_netdev instead of explicit reference to
    rtnl_lock
  o [IRDA]: Use register_netdev instead of explicit reference to
    rtnl_lock
  o [IRDA]: In smsc-ircc2 use request_region instead of check_region
  o [IRDA]: In smsc-ircc2 use request_region earlier in the setup
    process
  o [IRDA]: In smsc-ircc2, fix whitespace and indentation
  o [IRDA]: Convert smsc-ircc2 to alloc_irdadev()
  o [IRDA]: Convert irda-usb to alloc_irdadev()
  o [NET]: Consolidate skb delivery
  o [NET]: More likely/unlikely in skbuff.h
  o [NET]: syncppp needs to pullup headers
  o [IRDA]: Dongle module owner support
  o [IRDA]: Missing header file change from dongle owner changes
  o [IRDA]: Tekram dongle module conversion
  o [IRDA]: act200l dongle module conversion
  o [IRDA]: actisys dongle module conversion
  o [IRDA]: ep7211_ir dongle module conversion
  o [IRDA]: esi dongle module conversion
  o [IRDA]: girbil dongle module conversion
  o [IRDA]: litelink dongle module conversion
  o [IRDA]: ma600 dongle module conversion
  o [IRDA]: mcp2120 dongle module conversion
  o [IRDA]: old_belkin dongle module conversion
  o [IRDA]: Fix BUG() in irlmp seq file code
  o [IRDA]: Fix spinlock badness in last dongle changes
  o [NET]: Convert dvb-net to use alloc_netdev()
  o monotonic seqlock for cyclone timer
  o monotonic seqlock for HPET timer

Stephen Lord:
  o [XFS] Be consistent about when we dump error messages. Make sure
    the hex component of an error message only comes out when the
    message does.
  o [XFS] use dev_t less in xfs
  o [XFS] Switch pagebuf hashing to be based on the block_device
    address rather than the dev_t. Should give better distribution. Mod
    from Al Viro.
  o Remove dead file xfs_attr_fetch.c
  o [XFS] Remove dead flags
  o [XFS] remove unused va_fsid field
  o [XFS] remove dead function xfs_trans_iput
  o [XFS] Fix a broken interaction between a buffered read into an
    unwritten extent and a direct write
  o [XFS] Fix build
  o [XFS] fix merge error in pagebuf flush logic, bogus spinlock obtain
    was left in the code.
  o [XFS] fix the other half of the merge snafu
  o [XFS] fix log recovery report string formatting
  o [XFS] Re-work pagebuf & xfs stats to use per-cpu variables - big
    globals that are written all the time
  o [XFS] Close some holes in the metadata flush logic used during
    unmount, make sure we have no pending I/O completion calls for
    metadata, and that we only keep hold of metadata buffers for I/O
    completion if we want to. Still not perfect, but better than it
    was.
  o [XFS] When calculating the number of pages to probe for an
    unwritten extent, use the size of the extent, not the page count of
    the pagebuf which is initialized to zero.
  o [XFS] Either handle preemption with get/put or not, but don't get
    without a put!  Fix code for preemptable kernels.
  o [XFS] Code cleanup
  o [XFS] Code cleanup
  o [XFS] small cleanup

Steven Cole:
  o USB: remove reference to modules.txt in drivers/usb/input/Kconfig

Tiago Sousa:
  o [NETFILTER]: Add support for mIRC's 'server lookup' DCC address
    detection to ip_conntrack_irc.c

Tom Rini:
  o [SERIAL] Fix for NS16550A on a Super I/O on PPC
  o [SERIAL] Make the Startech UART detection 'more correct'
  o PPC32: Move a few more IBM-40x specific SPRs to the right file

Tommy Christensen:
  o [VLAN]: Do not modify the data of shared SKBs

Trond Myklebust:
  o UDP round trip timer fix. Modify Karn's algorithm so that we
    inherit timeouts from previous requests.
  o Make the client act correctly if the RPC server's asserts that it
    does not support a given program, version or procedure call.
  o Fix up hangs with the upcall mechanism for RPCSEC_GSS and the NFSv4
    idmapper.
  o Increase the NFS readahead so that we at least fill the RPC slot
    table.
  o Fix an Oops in the NFSv4 asynchronous unlink code. The v4 getattr
    "bitmap" was allocated on the stack.
  o Clean up the nfs_fhget() function. Have the called pass the
    superblock as a parameter instead of passing it in the form
  o Rename the struct "nfs4_shareowner". The name was confusing and
    didn't really relate to any of the RFCs.
  o The NFSv4 state model assumes that the client machine identifies
    itself to the server once and once only.
  o Simplify the synchronous NFS read call interface by passing a
    pointer to a filled nfs_read_data structure (the same struct used
    by the asynchronous function calls)
  o Simplify NFS synchronous write call interface. Pass a pointer to a
    filled nfs_write_data struct like we do for asynchronous function
    calls
  o NFSv4 state model update
  o Clean up the nfs4_stateid and nfs4_verifier typedefs

Ulrich Drepper:
  o [NET]: Use task->tgid instead of task->pid in SCM credentials code

Urban Widmark:
  o [SMBFS]: Create OLD_TO_NEW_foo macros in highuid.h and use them
    instead of direct references to low2highfoo.

Vinay K. Nallamothu:
  o [X25]: Use mod_timer(), add missing sock locking to x25_accept()

Wensong Zhang:
  o [IPVS] fix the unlocking bug in the ip_vs_conn_seq_stop

Wim Van Sebroeck:
  o USB: problem with uhci-hcd in versions 2.6.0-test5 and 2.6.0-test6


