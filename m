Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVLSAri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVLSAri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVLSAri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:47:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030205AbVLSArh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:47:37 -0500
Date: Sun, 18 Dec 2005 16:47:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.15-rc6
Message-ID: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 there it is. 
 
Slightly delayed by me being away for a week, and now Andrew is gone, but 
looking at the changes, they all seem to be pretty trivial, so we're on 
well track for doing the final 2.6.15 this year, I think. People have 
probably already started over-feeding with the holidays just around the 
corner.

The shortlog really says it all. Apart from some sparse annotations from 
Al, it's all random small things. But do give it a try, because Santa 
Claus has his CIA spooks checking y'all out, and naughty people don't get 
any of the loot.

		Linus

----
Adam Kropelin:
      hid-core: Zero-pad truncated reports

Adrian Bunk:
      allow KOBJECT_UEVENT=n only if EMBEDDED
      drivers/base/memory.c: unexport the static (sic) memory_sysdev_class

Al Viro:
      fix iomem annotations in sparc32 pcic code
      sparc: vfc __iomem annotations and fixes
      sparc: jsflash __user annotations
      sbus/char/uctrl: missing prototypes and NULL noise removal
      sparc/kernel/time: __iomem annotations
      sparc: NULL noise removal (ebus.c)
      sun4c_memerr_reg __iomem annotations
      arch/sparc/kernel/led.c __user annotations
      iscsi gfp_t annotations
      xfs: missing gfp_t annotations
      s2io: __iomem annotations for recent changes
      auerswald.c: %zd for size_t
      em28xx: %zd for size_t
      i386,amd64: mmconfig __iomem annotations
      i386,amd64: ioremap.c __iomem annotations
      cm4000_cs: __user annotations
      dell_rbu: NULL noise removal
      wdrtas.c: fix __user annotations
      cyber2000fb.c __iomem annotations
      arcfb __user annotations
      __user annotations (booke_wdt.c)
      missing prototype (mm/page_alloc.c)
      Address of void __user * is void __user * *, not void * __user *
      ia64 sn __iomem annotations
      dst_ca __user annotations, portability fixes
      arch/alpha/kernel/machvec_impl.h: C99 struct initializer
      drivers/atm/adummy.c NULL noise removal
      mwave: missing __user in ioctl struct declaration
      drivers/input/misc/wistron_btns.c NULL noise removal
      arch/powerpc/kernel/syscalls.c __user annotations
      ppc: booke_wdt compile fix
      ppc: ppc4xx_dma DMA_MODE_{READ,WRITE} fix

Alan Stern:
      UHCI: add missing memory barriers

Andi Kleen:
      x86_64: Make sure hpet_address is 0 when any part of HPET initialization fails
      i386/x86-64: Don't call change_page_attr with a spinlock held
      i386/x86-64 Fall back to type 1 access when no entry found
      i386/x86-64 Correct for broken MCFG tables on K8 systems
      x86_64: Fix 32bit thread coredumps
      PCI: Fix dumb bug in mmconfig fix

Andreas Gruenbacher:
      ext3: fix mount options documentation

Andreas Schwab:
      KERNELRELEASE depends on CONFIG_LOCALVERSION

Andrew Morton:
      blkmtd: use clear_page_dirty()
      raw driver: Kconfig fix

Andrew Vasquez:
      [SCSI] qla2xxx: Correct mis-handling of AENs.
      [SCSI] qla2xxx: Correct short-WRITE status handling.

Antonino A. Daplas:
      fbcon: fix complement_mask() with 512 character map
      fbcon: Add ability to save/restore graphics state
      fbdev: Pan display fixes
      fbcon: Avoid illegal display panning
      fbdev: Shift pixel value before entering loop in cfbimageblit
      fbdev: Fix incorrect unaligned access in little-endian machines

Arnaldo Carvalho de Melo:
      [TCPv6]: Fix skb leak

Bartlomiej Zolnierkiewicz:
      ide-disk: flush cache after calling del_gendisk()
      ide: cleanup ide.h
      ide: cleanup ide_driver_t
      ide-cd: remove write-only cmd field from struct cdrom_info

Ben Collins:
      i2o: Do not disable pci device when it's in use

Benjamin Herrenschmidt:
      powerpc: Fix a huge page bug
      powerpc: Remove debug code in hash path
      powerpc: Fix clock spreading setting on some powermacs
      radeon drm: fix agp aperture map offset

Brian King:
      [SCSI] fix double free of scsi request queue
      Fix SCSI scanning slab corruption

Christoph Lameter:
      [IA64] Fix missing parameter for local_add/sub
      [IA64] Add __read_mostly support for IA64

Daniel Drake:
      Fix listxattr() for generic security attributes
      via82cxxx IDE: Add VT8251 ISA bridge

Daniel Jacobowitz:
      [ARM] 3205/1: Handle new EABI relocations when loading kernel modules.

Dave Airlie:
      [drm] fix radeon aperture issue

Dave C Boutcher:
      [SCSI] ibmvscsi kexec fix

Dave Jones:
      [SERIAL] 8250_pci: Remove redundant assignment, and mark fallthrough.
      broken cast in parport_pc
      ACPI: fix sleeping whilst atomic warnings on resume

David Gibson:
      powerpc: Add missing icache flushes for hugepages
      powerpc: Fix SLB flushing path in hugepage

David S. Miller:
      [TCP] Vegas: timestamp before clone
      [AF_PACKET]: Convert PACKET_MMAP over to vm_insert_page().
      [SBUSFB]: Kill 'list' member from foo_par structs, totally unused.
      [IPV6] addrconf: Do not print device pointer in privacy log message.
      [PKT_SCHED]: Disable debug tracing logs by default in packet action API.

Deepak Saxena:
      [ARM] 3191/1: Mark I/O pointer as const in __raw_reads[bwl]
      [ARM] 3199/1: Remove bogus function prototype from arch-pxa/irq.h

Dipankar Sarma:
      add rcu_barrier() synchronization point

Dmitry Torokhov:
      Input: fix an OOPS in HID driver

Eric Dumazet:
      x86_64: Bug correction in populate_memnodemap()

Hareesh Nagarajan:
      [SBUSFB] tcx: Use FB_BLANK_UNBLANK instead of magic constant.

Haren Myneni:
      fix in __alloc_bootmem_core() when there is no free page in first node's memory

hawkes@sgi.com:
      [IA64-SGI] change default_sn2 to NR_CPUS==1024

Herbert Xu:
      [GRE]: Fix hardware checksum modification

Hiroki Kaminaga:
      [ARM] 3194/1: add pfn_to_kaddr macro for ARM take2

Hugh Dickins:
      mips: setup_zero_pages count 1

Ingo Molnar:
      add hlist_replace_rcu()

Jack Steiner:
      [IA64] Limit the maximum NODEDATA_ALIGN() offset
      [IA64-SGI] Fix SN PTC deadlock recovery
      [IA64-SGI] Missed TLB flush

James Bottomley:
      [SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)

Jean Delvare:
      radeon drm: fix compilation breakage with gcc 2.95.3

Jeff Dike:
      uml skas0: stop gcc's insanity

Jeff Garzik:
      [libata] mark certain hardware (or drivers) with a no-atapi flag
      [netdrvr skge] fix build

Jeff Mahoney:
      reiserfs: skip commit on io error
      reiserfs: close open transactions on error path

Jens Axboe:
      [SCSI] fix panic when ejecting ieee1394 ipod
      cciss: double put_disk()

Jeremy Higdon:
      sgiioc4: check for no hwifs available

Jes Sorensen:
      [IA64] uncached ref count leak

Johannes Berg:
      ppc32: set smp_tb_synchronized on UP with SMP kernel

John Hawkes:
      [IA64] disable preemption in udelay()

John Keller:
      [IA64-SGI] altix: pci_window fixup

John McCutchan:
      inotify: add two inotify_add_watch flags

john stultz:
      x86_64: Fix collision between pmtimer and pit/hpet

Jordan Crouse:
      ide: core modifications for AU1200
      ide: AU1200 IDE update

Kazunori MIYAZAWA:
      [IPv6] IPsec: fix pmtu calculation of esp

Keith Owens:
      [IA64] Allow salinfo_decode to detect signals on read
      [IA64] Define an ia64 version of __raw_read_trylock

Keshavamurthy Anil S:
      kprobes: fix race in aggregate kprobe registration
      kprobes: no probes on critical path
      kprobes: increment kprobe missed count for multiprobes

Knut Petersen:
      fbdev: fix switch to KD_TEXT, enhanced version

Kyungmin Park:
      mtd onenand driver: check correct manufacturer
      mtd onenand driver: fix unlock problem in DDP
      mtd onenand driver: reduce stack usage
      mtd onenand driver: use platform_device.h instead device.h

Linus Torvalds:
      Allow arbitrary shared PFNMAP's
      Remove (at least temporarily) the "incomplete PFN mapping" support
      Allow arbitrary read-only shared pfn-remapping too
      Revert revert of "[SCSI] fix usb storage oops"
      get_user_pages: don't try to follow PFNMAP pages
      Expose "Optimize for size" option for everybody
      Move size optimization option outside of EMBEDDED menu, mark it EXPERIMENTAL
      Make sure we copy pages inserted with "vm_insert_page()" on fork
      Linux v2.6.15-rc6

Lothar Wassmann:
      [ARM] 3201/1: PXA27x: Prevent hangup during resume due to inadvertedly enabling MBREQ (replaces: 3198/1)

Mao, Bibo:
      Kprobes: Reference count the modules when probed on it

Marcelo Tosatti:
      [ARM SMP] mpcore_wdt bogus fpos check
      ide: MPC8xx IDE depends on IDE=y && BLK_DEV_IDE=y

Marcus Sundberg:
      [NETFILTER]: ip_nat_tftp: Fix expectation NAT

Mark A. Greer:
      i2c: Fix i2c-mv64xxx compilation error

Mark Lord:
      [SCSI] Fix incorrect pointer in megaraid.c MODE_SENSE emulation
      libata-core.c:  fix parameter bug on kunmap_atomic() calls

Martin Waitz:
      [NET]: make function pointer argument parseable by kernel-doc

Matt Domsch:
      ipmi: fix panic generator ID

Matt Helsley:
      Add getnstimestamp function
      Add timestamp field to process events

Matthew Wilcox:
      [SCSI] Negotiate correctly with async-only devices

Mauro Carvalho Chehab:
      V4L/DVB (3087) fix analog NTSC for pcHDTV 3000
      V4L/DVB: (3086a) Whitespaces cleanups part 1
      V4L/DVB: (3086b) Whitespaces cleanups part 2
      V4L/DVB: (3086c) Whitespaces cleanups part 3
      V4L/DVB: (3086c) Whitespaces cleanups part 4
      V4L/DVB: (3151) I2C ID renamed to I2C_DRIVERID_INFRARED

Michael Chan:
      [TG3]: Fix nvram arbitration bugs.
      [TG3]: Fix suspend and resume
      [TG3]: Fix 5704 single-port mode
      [TG3]: Fix low power state

Michael Reed:
      [SCSI] fix OOPS due to clearing eh_action prior to aborting eh command

Michal Ostrowski:
      powerpc/pseries: Fix TCE building with 64k pagesize
      Fix windfarm model-id table

Mike Kravetz:
      powerpc/pseries: boot failures on numa if no memory on node

Mike Miller:
      cciss: fix for deregister_disk

Milton Miller:
      PCI express must be initialized before PCI hotplug

NeilBrown:
      md: fix a use-after-free bug in raid1
      md: use correct size of raid5 stripe cache when measuring how full it is

Nicolas Pitre:
      input: fix ucb1x00-ts breakage after conversion to dynamic input_dev allocation

Nikola Valerjev:
      [ARM] 3200/1: Singlestep over ARM BX and BLX instructions using ptrace fix

Olaf Hering:
      powerpc: correct the NR_CPUS description text
      pcnet32: use MAC address from prom also on powerpc
      ieee80211_crypt_tkip depends on NET_RADIO

Ole Reinhardt:
      fbdev: make pxafb more robust to errors with CONFIG_FB_PXA_PARAMETERS

Olof Johansson:
      powerpc: remove redundant code in stab init
      powerpc: Set cache info defaults

Pablo Neira Ayuso:
      [NETFILTER]: Fix incorrect argument to ip_nat_initialized() in ctnetlink

Paolo 'Blaisorblade' Giarrusso:
      uml: arch/um/scripts/Makefile.rules - remove duplicated code
      uml - fix some funkiness in Kconfig

Paolo Galtieri:
      IPMI oops fix

Patrick McHardy:
      [NETFILTER]: Fix ip_conntrack_flush abuse in ctnetlink
      [NETFILTER]: Fix CTA_PROTO_NUM attribute size in ctnetlink
      [NETFILTER]: Mark ctnetlink as EXPERIMENTAL
      [NETFILTER]: Wait for untracked references in nf_conntrack module unload
      [NETFILTER]: Fix unbalanced read_unlock_bh in ctnetlink
      [NETFILTER]: Don't use conntrack entry after dropping the reference

Paul Jackson:
      [SPARC]: atomic_clear_mask build fix
      [SPARC]: block/ needed in final image link

Paul Mackerras:
      powerpc/pseries: Optimize IOMMU setup
      ppc: Build in all three of powermac, PREP and CHRP support

Pekka J Enberg:
      uml: fix compile error for tt

Pierre Ossman:
      [MMC] Proper check of SCR error code
      Add try_to_freeze to kauditd

Ricardo Cerqueira:
      V4L/DVB: (3135) Fix tuner init for Pinnacle PCTV Stereo

Rob Landley:
      uml: fix dynamic linking on some 64-bit distros

Robin Holt:
      [IA64] Updates to the sn2_defconfig for 2.6.15.
      [IA64] Change SET_PERSONALITY to comply with comment in binfmt_elf.c.
      [IA64] fix for SET_PERSONALITY when CONFIG_IA32_SUPPORT is not set.

Russell King:
      [ARM] Add memory.txt to 00-INDEX
      [MMC] Explain the internals of mmc_power_up()

Salyzyn, Mark:
      dpt_i2o fix for deadlock condition

Sascha Sommer:
      V4L/DVB: (3113) Convert em28xx to use vm_insert_page instead of remap_pfn_range

Sergei Shtylylov:
      Au1550 AC'97 OSS driver spinlock fixes

Shaohua Li:
      x86: fix NMI with CPU hotplug
      i386/x86-64 disable LAPIC completely for offline CPU

Srivatsa Vaddagiri:
      Fix bug in RCU torture test
      Fix RCU race in access of nohz_cpu_mask

Stefan Richter:
      ieee1394: resume remote ports when starting a host (fixes device recognition)
      ieee1394: write broadcast_channel only to select nodes (fixes device recognition)

Stephen Hemminger:
      sk98lin: rx checksum offset not set
      [TG3]: remove warning on race
      [NET]: Fix NULL pointer deref in checksum debugging.
      skge: get rid of warning on race
      [VLAN]: Fix hardware rx csum errors

Steven Whitehouse:
      [DECNET]: add memory buffer settings 

Thomas Young:
      [TCP] Vegas: stop resetting rtt every ack
      [TCP] Vegas: Remove extra call to tcp_vegas_rtt_calc

Tony Luck:
      [IA64] refresh tiger_defconfig ready for 2.6.15
      [IA64] Split 16-bit severity field in sal_log_record_header

Vojtech Pavlik:
      Dmitry Torokhov is input subsystem maintainer
      Input: ALPS - correctly report button presses on Fujitsu Siemens S6010

Yasunori Goto:
      Fix Kconfig of DMA32 for ia64
      Fix calculation of grow_pgdat_span() in mm/memory_hotplug.c

Yasuyuki Kozakai:
      [NETFILTER]: nf_conntrack: Fix missing check for ICMPv6 type
      [NETFILTER]: nfnetlink: Fix calculation of minimum message length

