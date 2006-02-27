Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWB0F1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWB0F1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 00:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWB0F1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 00:27:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750999AbWB0F1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 00:27:35 -0500
Date: Sun, 26 Feb 2006 21:27:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.16-rc5
Message-ID: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1465457956-1141018048=:22647"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1465457956-1141018048=:22647
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


The tar-ball is being uploaded right now, and everything else should 
already be pushed out. Mirroring might take a while, of course.

There's not much to say about this: people have been pretty good, and it's 
just a random collection of fixes in various random areas. The shortlog is 
actually pretty short, and it really describes the updates better than 
anything else.

Have I missed anything? Holler. And please keep reminding about any 
regressions since 2.6.15.

		Linus

---

Adrian Bunk:
      [AGPGART] help text updates
      drivers/net/tlan.c: #ifdef CONFIG_PCI the PCI specific code

Al Viro:
      GFP_KERNEL allocations in atomic (auditsc)
      don't mangle INQUIRY if cmddt or evpd bits are set
      fix handling of st_nlink on procfs root
      m68k: restore disable_irq_nosync()
      missing ntohs() in ip6_tunnel
      m68k: pm_power_off() breakage
      iomap_copy fallout (m68k)
      sd: fix memory corruption with broken mode page headers

Alan Curry:
      powerpc: fix altivec_unavailable_exception Oopses

Alessandro Zummo:
      [ARM] 3342/1: NSLU2: Protect power button init routine with machine_is_nslu2()
      [ARM] 3343/1: NAS100d: Fix incorrect I2C pin assignment
      [ARM] 3344/1: NSLU2: beeper support

Alexey Dobriyan:
      mm/mempolicy.c: fix 'if ();' typo
      drivers/fc4/fc.c: memset correct length

Alexey Korolev:
      cfi_cmdset_0001: fix range for cache invalidation

Andi Kleen:
      x86_64: Don't set CONFIG_DEBUG_INFO in defconfig
      Fix units in mbind check
      x86_64: Only do the clustered systems have unsynchronized TSC assumption on IBM systems
      x86-64/i386: Use common X86_PM_TIMER option and make it EMBEDDED
      x86_64: Disable ACPI blacklist by year for now on x86-64
      x86_64: Fix the additional_cpus=.. option
      x86_64: Move the SMP time selection earlier
      x86_64: Better ATI timer fix
      x86_64: Fix ioctl compat code for /dev/rtc

Andreas Deresch:
      i386: Handle non existing APICs without panicing

Andrew Morton:
      ramfs: update dir mtime and ctime

Andrew Victor:
      [ARM] 3325/2: GPIO function to control multi-drive (open collector) capability
      [ARM] 3348/1: Disable GPIO interrupts

Anton Altaparmakov:
      NTFS: Fix a potential overflow by casting (index + 1) to s64 before doing a
      NTFS: - Cope with attribute list attribute having invalid flags.
      NTFS: Implement support for sector sizes above 512 bytes (up to the maximum
      NTFS: Do more detailed reporting of why we cannot mount read-write by

Anton Blanchard:
      powerpc: Fix runlatch performance issues
      powerpc64: remove broken/bitrotted HMT support

Antonino A. Daplas:
      Fix pseudo_palette setup in asiliantfb_setcolreg()

Atsushi Nemoto:
      [MIPS] Fixes for uaccess.h with gcc >= 4.0.1
      [MIPS] jiffies_to_compat_timeval fix

Benjamin Herrenschmidt:
      powermac: Fix loss of ethernet PHY on sleep

Björn Steinbrink:
      kjournald keeps reference to namespace

Brian Magnuson:
      fix build on x86_64 with !CONFIG_HOTPLUG_CPU

Carl-Daniel Hailfinger:
      radeonfb: resume support for Samsung P35 laptops

Catalin Marinas:
      [ARM] 3340/1: Fix the PCI setup for direct master access to SDRAM

Chris McDermott:
      x86_64: Fix NMI watchdog on x460

Christoph Hellwig:
      [SCSI] esp: fix eh locking

Christoph Lameter:
      Terminate process that fails on a constrained allocation
      page migration: Fix MPOL_INTERLEAVE behavior for migration via mbind()
      vmscan: fix zone_reclaim

Daniel Yeisley:
      i386: need to pass virtual address to smp_read_mpc()

Dave Airlie:
      drm: fixup i915 interrupt on X server exit
      drm: radeon add r300 TX_CNTL and verify bitblt packets
      drm: fix brace placement

Dave Jones:
      [AGPGART] Improve the error message shown when we detect a ServerWorks CNB20HE
      [AGPGART] Add some informational printk to nforce GART failure path.
      x86-64: react to new topology.c location

David S. Miller:
      [SPARC64]: Implement futex_atomic_op_inuser().
      [SPARC64]: Make cpu_present_map available earlier.

Eric Van Hensbergen:
      v9fs: update documentation and fix debug flag

Francois Romieu:
      r8169: fix broken ring index handling in suspend/resume
      r8169: enable wake on lan

Frank Pavlic:
      s390: V=V qdio fixes

Freddy Spierenburg:
      au1100fb: replaced io_remap_page_range() with io_remap_pfn_range()

Greg Kroah-Hartman:
      Revert mount/umount uevent removal

Haren Myneni:
      powerpc: Trivial fix to set the proper timeout value for kdump

Heiko Carstens:
      cpu hotplug documentation fix
      s390: revert dasd eer module

Herbert Xu:
      padlock: Fix typo that broke 256-bit keys
      [XFRM]: Eliminate refcounting confusion by creating __xfrm_state_put().
      [IPSEC]: Use TOS when doing tunnel lookups

Hirokazu Takata:
      m32r: __cmpxchg_u32 fix
      m32r: update sys_tas() routine
      m32r: enable asm code optimization
      m32r: fix and update for gcc-4.0

Hugh Dickins:
      tmpfs: fix mount mpol nodelist parsing
      tmpfs: recommend remount for mpol

Hugo Santos:
      [IPV6] ip6_tunnel: release cached dst on change of tunnel params

Jamal Hadi Salim:
      [NET] ethernet: Fix first packet goes out with MAC 00:00:00:00:00:00

James Bottomley:
      voyager: fix boot panic by adding topology export
      voyager: fix the cpu_possible_map to make voyager boot again
      x86: fix broken SMP boot sequence
      fix voyager after topology.c move

Jan Beulich:
      x86_64: fix USER_PTRS_PER_PGD

Jean Tourrilhes:
      [IRDA]: irda-usb bug fixes

Jon Mason:
      x86_64: no_iommu removal in pci-gart.c

Juergen Kreileder:
      Fix snd-usb-audio in 32-bit compat environment

Jun'ichi Nomura:
      dm: missing bdput/thaw_bdev at removal
      dm: free minor after unlink gendisk

Kaj-Michael Lang:
      gbefb: IP32 gbefb depth change fix

Kelly Daly:
      powerpc: disable OProfile for iSeries

Kumar Gala:
      powerpc: Enable coherency for all pages on 83xx to fix PCI data corruption
      powerpc: Fix mem= cmdline handling on arch/powerpc for !MULTIPLATFORM

Kurt Garloff:
      OOM kill: children accounting

Linus Torvalds:
      Make Kprobes depend on modules
      Linux v2.6.16-rc5

Luke Yang:
      Fix undefined symbols for nommu architecture

Marc Zyngier:
      Fix Specialix SI probing

Martin Michlmayr:
      [MIPS] Add support for TIF_RESTORE_SIGMASK for signal32
      [MIPS] Make do_signal32 return void.
      [MIPS] Fix compiler warnings in arch/mips/sibyte/bcm1480/irq.c
      gbefb: Set default of FB_GBE_MEM to 4 MB

Michael Ellerman:
      powerpc: Don't start secondary CPUs in a UP && KEXEC kernel
      powerpc: Make UP -> SMP kexec work again
      powerpc: Fix bug in spinup of renumbered secondary threads
      powerpc: Initialise hvlpevent_queue.lock correctly
      powerpc: Only calculate htab_size in one place for kexec

Michal Janusz Miroslaw:
      [SERIAL] Trivial comment fix: include/linux/serial_reg.h

Michal Ostrowski:
      Fix race condition in hvc console.

Mårten Wikström:
      [ARM] 3347/1: Bugfix for ixp4xx_set_irq_type()

Olaf Hering:
      powerpc: remove duplicate exports
      ppc: fix adb breakage in xmon

Olof Johansson:
      powerpc: Fix OOPS in lparcfg on G5
      powerpc: Update {g5,pseries,ppc64}_defconfig

Paolo 'Blaisorblade' Giarrusso:
      uml: correct error messages in COW driver
      uml: fix usage of kernel_errno in place of errno
      uml: fix ((unused)) attribute
      uml: os_connect_socket error path fixup
      uml: better error reporting for read_output
      uml: tidying COW code

Patrick McHardy:
      [XFRM]: Fix policy double put
      [NETFILTER]: Fix NAT PMTUD problems
      [NETFILTER]: Fix outgoing redirects to loopback
      [NETFILTER]: Fix bridge netfilter related in xfrm_lookup

Paul Mackerras:
      powerpc: Keep xtime and gettimeofday in sync

Pavel Machek:
      suspend-to-ram: allow video options to be set at runtime

Pekka Enberg:
      NTFS: We have struct kmem_cache now so use it instead of the typedef.

Peter Oberparleiter:
      s390: dasd reference counting

Peter Osterlund:
      pktcdvd: Correctly set rq->cmd_len in pkt_generic_packet()
      pktcdvd: Rename functions and make their return values sane
      pktcdvd: Remove useless printk statements
      pktcdvd: Fix the logic in the pkt_writable_track function
      pktcdvd: Only return -EROFS when appropriate

Prasanna S Panchamukhi:
      Kprobes causes NX protection fault on i686 SMP

R Sharada:
      powerpc64: fix spinlock recursion in native_hpte_clear

Ralf Baechle:
      H8/300: CONFIG_CONFIG_ doesn't fly.
      [MIPS] Make integer overflow exceptions in kernel mode fatal.
      [MIPS] Reformat _sys32_rt_sigsuspend with tabs instead of space for consistency.
      [MIPS] N32: Fix N32 rt_sigtimedwait and rt_sigsuspend breakage.
      [MIPS] N32: Make sure pointer is good before passing it to sys_waitid().
      [MIPS] Sibyte: #if CONFIG_* doesn't fly.
      [MIPS] Sibyte: Config option names shouldn't be prefixed with CONFIG_
      [MIPS] Follow Uli's latest *at syscall changes.
      [MIPS] Yosemite: Fix build damage by dc8f6029cd51af1b148846a32e68d69013a5cc0f.
      [MIPS] Disable CONFIG_ISCSI_TCP; it triggers a gcc 3.4 endless loop.

Rene Herman:
      snd-cs4236 typo fix

Richard Lucassen:
      [NET]: Increase default IFB device count.

Rojhalat Ibrahim:
      [MIPS] Add topology_init.

Russell King:
      [MMC] Fix mmc_cmd_type() mask
      [ARM] Add panic-on-oops support
      [ARM] Update mach-types
      [ARM] CONFIG_CPU_MPCORE -> CONFIG_CPU_32v6K
      [SERIAL] Add comment about early_serial_setup()

Samuel Thibault:
      vgacon: no vertical resizing on EGA

Segher Boessenkool:
      powerpc: Fix some MPIC + HT APIC buglets
      powerpc: Don't re-assign PCI resources on Maple

Simon Vogl:
      cfi: init wait queue in chip struct

Stefan Richter:
      sbp2: fix another deadlock after disconnection
      sbp2: variable status FIFO address (fix login timeout)
      sbp2: update 36byte inquiry workaround (fix compatibility regression)

Stephen Hemminger:
      sky2: yukon-ec-u chipset initialization
      sky2: limit coalescing values to ring size
      sky2: poke coalescing timer to fix hang
      sky2: force early transmit status
      sky2: use device iomem to access PCI config
      sky2: close race on IRQ mask update.
      skge: NAPI/irq race fix
      skge: genesis phy initialzation
      skge: protect interrupt mask

Stephen Rothwell:
      Fix compile for CONFIG_SYSVIPC=n or CONFIG_SYSCTL=n

Stephen Street:
      spi: Fix modular master driver remove and device suspend/remove

Steve French:
      CIFS: CIFSSMBRead was returning an invalid pointer in buf on socket error

Suresh Bhogavilli:
      [IPV4]: Fix garbage collection of multipath route entries

Suresh Siddha:
      x86_64: Check for bad elf entry address.

Takashi Iwai:
      alsa: fix bogus snd_device_free() in opl3-oss.c

Tejun Heo:
      libata: fix WARN_ON() condition in *_fill_sg()
      libata: fix qc->n_elem == 0 case handling in ata_qc_next_sg
      libata: make ata_sg_setup_one() trim zero length sg

Uli Luckas:
      [ARM] 3345/1: Fix interday RTC alarms

Ulrich Drepper:
      flags parameter for linkat

YOSHIFUJI Hideaki:
      [NET]: NETFILTER: remove duplicated lines and fix order in skb_clone().
      [IPV6]: Do not ignore IPV6_MTU socket option.

Zachary Amsden:
      Fix topology.c location

Zhu Yi:
      ipw2200: Suppress warning message

--21872808-1465457956-1141018048=:22647--
