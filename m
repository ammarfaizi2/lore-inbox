Return-Path: <linux-kernel-owner+w=401wt.eu-S932417AbXAGGT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbXAGGT2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 01:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbXAGGT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 01:19:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36807 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417AbXAGGT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 01:19:27 -0500
Date: Sat, 6 Jan 2007 22:19:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.20-rc4
Message-ID: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1268165909-1168150763=:3661"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1268165909-1168150763=:3661
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


There's absolutely nothing interesting here, unless you want to play with 
KVM, or happened to be bitten by the bug with really old versions of the 
linker that made parts of entry.S just go away.

But check it out anyway, and the shortlog gives more details on the 
various minor fixes that have accumulated this week. Mostly in random 
device drivers.

		Linus

---
Adam Megacz (1):
      Add AFS_SUPER_MAGIC to magic.h

Adrian Bunk (2):
      [NET] drivers/net/loopback.c: convert to module_init()
      [X25]: proper prototype for x25_init_timers()

Alan (3):
      libata: fix combined mode
      atiixp: Old drivers/ide layer driver for the ATIIXP hang fix
      hpt37x: Two important bug fixes

Alan Stern (2):
      UHCI: make test for ASUS motherboard more specific
      UHCI: support device_may_wakeup

Alexey Dobriyan (2):
      [NETFILTER] xt_hashlimit.c: fix typo
      pata_optidma: typo in Kconfig

Andrew Morton (5):
      USB: funsoft is borken on sparc
      sisusb_con warning fixes
      PCI: disable PCI_MULTITHREAD_PROBE
      ip2 warning fix
      shrink_all_memory(): fix lru_pages handling

Ard van Breemen (3):
      start_kernel: test if irq's got enabled early, barf, and disable them again
      kernelparams: detect if and which parameter parsing enabled irq's
      PCI: prevent down_read when pci_devices is empty

Arnaud Patard (2):
      [ARM] 4065/1: S3C24XX: dma printk fixes
      [ARM] 4073/1: Prevent s3c24xx drivers from including asm/arch/hardware.h and asm/arch/irqs.h

Avi Kivity (39):
      KVM: Prevent stale bits in cr0 and cr4
      KVM: MMU: Implement simple reverse mapping
      KVM: MMU: Teach the page table walker to track guest page table gfns
      KVM: MMU: Load the pae pdptrs on cr3 change like the processor does
      KVM: MMU: Fold fetch_guest() into init_walker()
      KVM: MU: Special treatment for shadow pae root pages
      KVM: MMU: Use the guest pdptrs instead of mapping cr3 in pae mode
      KVM: MMU: Make the shadow page tables also special-case pae
      KVM: MMU: Make kvm_mmu_alloc_page() return a kvm_mmu_page pointer
      KVM: MMU: Shadow page table caching
      KVM: MMU: Write protect guest pages when a shadow is created for them
      KVM: MMU: Let the walker extract the target page gfn from the pte
      KVM: MMU: Support emulated writes into RAM
      KVM: MMU: Zap shadow page table entries on writes to guest page tables
      KVM: MMU: If emulating an instruction fails, try unprotecting the page
      KVM: MMU: Implement child shadow unlinking
      KVM: MMU: kvm_mmu_put_page() only removes one link to the page
      KVM: MMU: oom handling
      KVM: MMU: Remove invlpg interception
      KVM: MMU: Remove release_pt_page_64()
      KVM: MMU: Handle misaligned accesses to write protected guest page tables
      KVM: MMU: <ove is_empty_shadow_page() above kvm_mmu_free_page()
      KVM: MMU: Ensure freed shadow pages are clean
      KVM: MMU: If an empty shadow page is not empty, report more info
      KVM: MMU: Page table write flood protection
      KVM: MMU: Never free a shadow page actively serving as a root
      KVM: MMU: Fix cmpxchg8b emulation
      KVM: MMU: Treat user-mode faults as a hint that a page is no longer a page table
      KVM: MMU: Free pages on kvm destruction
      KVM: MMU: Replace atomic allocations by preallocated objects
      KVM: MMU: Detect oom conditions and propagate error to userspace
      KVM: MMU: Flush guest tlb when reducing permissions on a pte
      KVM: MMU: Destroy mmu while we still have a vcpu left
      KVM: MMU: add audit code to check mappings, etc are correct
      KVM: Improve reporting of vmwrite errors
      KVM: Initialize vcpu->kvm a little earlier
      KVM: Add missing 'break'
      KVM: Don't set guest cr3 from vmx_vcpu_setup()
      KVM: MMU: Add missing dirty bit

Bartlomiej Zolnierkiewicz (1):
      via82cxxx: fix cable detection

Ben Dooks (1):
      [ARM] 4071/1: S3C24XX: Documentation update

Benjamin Herrenschmidt (1):
      [SUNGEM]: PHY updates & pause fixes (#2)

Brice Goglin (1):
      [CPUFREQ] speedstep-centrino: missing space and bracket

Christoph Hellwig (2):
      [XFRM_USER]: avoid pointless void ** casts
      Fix BUG at drivers/scsi/scsi_lib.c:1118 caused by "pktsetup dvd /dev/sr0"

Christoph Lameter (1):
      Check for populated zone in __drain_pages

Chuck Ebbert (1):
      [NETFILTER]: ebtables: don't compute gap before checking struct type

Cyrill V. Gorcunov (1):
      qconf: fix SIGSEGV on empty menu items

Dan Williams (1):
      [ARM] 4077/1: iop13xx: fix __io() macro

Dave Jones (3):
      [CPUFREQ] longhaul: Fix up unreachable code.
      [CPUFREQ] longhaul: Kill off warnings introduced by recent changes.
      Fix implicit declarations in via-pmu

David Brownell (4):
      i2c: Migration aids for i2c_adapter.dev removal
      USB: omap_udc build fixes (sync with linux-omap)
      rtc-at91rm9200 build fix
      Update the rtc-rs5c372 driver

David Hollis (1):
      USB: asix: Fix AX88772 device PHY selection

David L Stevens (1):
      [IPV4/IPV6]: Fix inet{,6} device initialization order.

David S. Miller (2):
      [PKTGEN]: Convert to kthread API.
      [SOUND] Sparc CS4231: Use 64 for period_bytes_min

Dmitry Mishin (1):
      [NETFILTER]: compat offsets size change

Dor Laor (2):
      KVM: Improve interrupt response
      KVM: Simplify test for interrupt window

Doug Chapman (1):
      ACPI: increase ACPI_MAX_REFERENCE_COUNT for larger systems

Eric Anholt (1):
      [AGPGART] fix detection of aperture size versus GTT size on G965

Eric Sandeen (1):
      fix memory corruption from misinterpreted bad_inode_ops return values

Erik Jacobson (1):
      connector: some fixes for ia64 unaligned access errors

Evgeniy Dushistov (1):
      fix garbage instead of zeroes in UFS

Gabriel Mansi (1):
      [AGPGART] K8M890 support for amd-k8.

Georg Chini (1):
      [SOUND] Sparc CS4231: Fix IRQ return value and initialization.

Gerrit Renker (1):
      [TCP]: Use old definition of before

Guillaume Chazarain (2):
      ACPI: EC: move verbose printk to debug build only
      [CPUFREQ] Uninitialized use of cmd.val in arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c:acpi_cpufreq_target()

Hugh Dickins (2):
      fix BUG_ON(!PageSlab) from fallback_alloc
      fix OOM killing of swapoff

Ingo Molnar (6):
      KVM: Fix GFP_KERNEL alloc in atomic section bug
      KVM: Use raw_smp_processor_id() instead of smp_processor_id() where applicable
      profiling: fix sched profiling typo
      KVM: Avoid oom on cr3 switch
      KVM: Make loading cr3 more robust
      KVM: Simplify mmu_alloc_roots()

James Bursa (1):
      adfs: fix filename handling

Jens Axboe (3):
      cfq-iosched: merging problem
      cdrom: set default timeout to 7 seconds
      ide-cd maintainer

Jiri Kosina (1):
      HID: fix help texts in Kconfig

Kay Sievers (1):
      Driver core: Fix prefix driver links in /sys/module by bus-name

Len Brown (2):
      ACPI: fix section mis-match build warning
      ACPI: asus_acpi: new MAINTAINER

Lennert Buytenhek (1):
      [ARM] 4063/1: ep93xx: fix IRQ_EP93XX_GPIO?MUX numbering

Leonard Norrg√•rd (1):
      sound: hda: detect ALC883 on MSI K9A Platinum motherboards (MS-7280)

Linus Torvalds (3):
      Revert "[PATCH] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT"
      Revert "[PATCH] binfmt_elf: randomize PIE binaries (2nd try)"
      Linux 2.6.20-rc4

Mariusz Kozlowski (1):
      [AF_NETLINK]: module_put cleanup

Martin Josefsson (1):
      [NETFILTER]: nf_nat: fix MASQUERADE crash on device down

Martin Williges (1):
      USB: usblp.c - add Kyocera Mita FS 820 to list of "quirky" printers

Matthijs van Otterdijk (1):
      fix the toshiba_acpi write_lcd return value

Maxime Bizon (1):
      i2c-mv64xxx: Fix random oops at boot

Miguel Angel Alvarez (1):
      USB: fix interaction between different interfaces in an "Option" usb device

Nicolas Pitre (2):
      [ARM] 4064/1: make pxa_get_cycles() static
      [ARM] 4066/1: correct a comment about PXA's sched_clock range

OGAWA Hirofumi (1):
      x86_64: Fix dump_trace()

Oliver Neukum (1):
      USB: small update to Documentation/usb/acm.txt

Parag Warudkar (1):
      selinux: fix selinux_netlbl_inode_permission() locking

Patrick McHardy (2):
      [NETFILTER]: Fix routing of REJECT target generated packets in output chain
      [NETFILTER]: New connection tracking is not EXPERIMENTAL anymore

Paul Brook (1):
      [ARM] 4074/1: Flat loader stack alignment

Paul Mundt (1):
      Sanely size hash tables when using large base pages

Pete Zaitcev (1):
      USB storage: fix ipod ejecting issue

Phil Dibowitz (1):
      USB Storage: unusual_devs: add supertop drives

Philipp Zabel (2):
      [ARM] 4080/1: Fix for the SSCR0_SlotsPerFrm macro
      [ARM] 4081/1: Add definition for TI Sync Serial Protocol

Philippe De Muyter (1):
      i2c/m41t00: Do not forget to write year

Rafael J. Wysocki (1):
      swsusp: Do not fail if resume device is not set

Rafa≥ Bilski (2):
      [CPUFREQ] Longhaul - Fix up powersaver assumptions.
      [CPUFREQ] Longhaul - Always guess FSB

Randy Dunlap (1):
      [CPUFREQ] select consistently

Richard Purdie (3):
      [ARM] 4078/1: Fix ARM copypage cache coherency problems
      backlight: fix backlight_device_register compile failures
      Fix leds-s3c24xx hardware.h reference

Russell King (2):
      [ARM] Fix VFP initialisation issue for SMP systems
      Fix some ARM builds due to HID brokenness

Sarah Bailey (1):
      USB: Fixed bug in endpoint release function.

Segher Boessenkool (1):
      Fix insta-reboot with "i386: Relocatable kernel support"

Thomas Hellstrom (2):
      [AGPGART] Remove unnecessary flushes when inserting and removing pages.
      [AGPGART] Fix PCI-posting flush typo.

Venkatesh Pallipadi (1):
      [CPUFREQ] Bug fix for acpi-cpufreq and cpufreq_stats oops on frequency change notification

Vitaly Wool (2):
      i2c-pnx: Fix interrupt handler, get rid of EARLY config option
      i2c-pnx: Add entry to MAINTAINERS

Vivek Goyal (4):
      i386: Restore CONFIG_PHYSICAL_START option
      i386: fix modpost warning in SMP trampoline code
      i386: fix another modpost warning
      i386: modpost smpboot code warning fix

Yoshimi Ichiyanagi (1):
      KVM: Recover after an arch module load failure

akpm@osdl.org (1):
      [AGPGART] drivers/char/agp/sgi-agp.c: check kmalloc() return value

dean gaudet (1):
      [NET]: ifb double-counts packets

---1463790079-1268165909-1168150763=:3661--
