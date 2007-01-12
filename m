Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbXALT1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXALT1x (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbXALT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:27:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54890 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964976AbXALT1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:27:52 -0500
Date: Fri, 12 Jan 2007 14:27:48 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.20-rc5
Message-ID: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1875538672-1168630068=:11200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1875538672-1168630068=:11200
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok, there it is, in all its shining glory.

A lot of developers (including me) will be gone next week for 
Linux.Conf.Au, so you have a week of rest and quiet to test this, and 
report any problems. 

Not that there will be any, right? You all behave now!

The patches here are pretty basic. Lots of small stuff. The shortlog 
(appended) explains it about as well as you can.

POWER, ARM, MIPS, S/390, some netfilter fixes etc.

		Linus
---
Aaron Salter (1):
      ixgb: Write RA register high word first, increment version

Adrian Drzewiecki (1):
      HID: fix mappings for DiNovo Edge Keyboard - Logitech USB BT receiver

Ahmed S. Darwish (1):
      HID: tiny patch to remove a kmalloc cast

Alexander Bigga (1):
      [MIPS] Alchemy:  Fix PCI-memory access

Andi Kleen (4):
      x86-64: Update defconfig
      i386: Update defconfig
      x86-64: Use different constraint for gcc < 4.1 in bitops.h
      x86-64: Fix warnings in ia32_aout.c

Andrew Hendry (1):
      [X25]: Trivial, SOCK_DEBUG's in x25_facilities missing newlines

Andrew Morton (1):
      FD_ZERO build fix

Anton Blanchard (2):
      [POWERPC] Fix corruption in hcall9
      [POWERPC] Fix bugs in the hypervisor call stats code

Atsushi Nemoto (6):
      [MIPS] csum_partial and copy in parallel
      [MIPS] SMTC build fix
      [MIPS] Fix build errors on SEAD
      [MIPS] TX49: Fix use of CDEX build_store_reg()
      [MIPS] PNX8550: Fix system timer initialization
      [MIPS] Fix N32 SysV IPC routines

Ayaz Abdulla (1):
      forcedeth: sideband management fix

Bart De Schuymer (1):
      [NETFILTER]: arp_tables: fix userspace compilation

Ben Dooks (1):
      [ARM] 4070/1: arch/arm/kernel: fix warnings from missing includes

Brice Goglin (1):
      increment pos before looking for the next cap in __pci_find_next_ht_cap

Christian Borntraeger (1):
      [S390] locking problem with __cpcmd.

Clemens Ladisch (1):
      [ALSA] usb-audio: work around wrong frequency in CM6501 descriptors

Craig Schlenter (1):
      [TCP]: Fix iov_len calculation in tcp_v4_send_ack().

Dan Williams (2):
      [ARM] 4079/1: iop: Update MAINTAINERS
      [ARM] 4082/1: iop3xx: fix iop33x gpio register offset

Daniel Ritz (1):
      PCMCIA: fix drivers broken by recent cleanup

Dave Hansen (1):
      Fix sparsemem on Cell

David Brownell (2):
      MMC: at91 mmc linkage updates
      rtc-sh: correctly report rtc_wkalrm.enabled

David Chinner (1):
      Revert bd_mount_mutex back to a semaphore

David Gibson (1):
      [POWERPC] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()

David Miller (1):
      really fix funsoft driver

David Woodhouse (1):
      [POWERPC] Fix manual assembly WARN_ON() in enter_rtas().

Davy Chan (1):
      [MIPS] pnx8550: Fix write_config_byte() PCI config space accessor

Dotan Barak (1):
      IB/mthca: Don't execute QUERY_QP firmware command for QP in RESET state

Erez Zilber (1):
      IB/iser: Return error code when PDUs may not be sent

Frank Blaschka (3):
      s390: qeth driver fixes: VLAN hdr, perf stats
      s390: qeth driver fixes: packet socket
      s390: qeth driver fixes: atomic context fixups

Frank Pavlic (1):
      s390: iucv Kconfig help description changes

Gautham R Shenoy (1):
      Change cpu_up and co from __devinit to __cpuinit

Giuliano Pochini (1):
      [ALSA] Fix potential NULL pointer dereference in echoaudio midi

Grant Likely (3):
      [POWERPC] Fix mpc52xx fdt to use correct device_type for sound devices
      [POWERPC] Don't include powerpc/sysdev/rom.o for arch/ppc builds
      [POWERPC] Fix mpc52xx serial driver to work for arch/ppc again

Heiko Carstens (5):
      qeth: fix uaccess handling and get rid of unused variable
      [S390] cio: use barrier() in stsch_reset.
      [S390] Fix cpu hotplug (missing 'online' attribute).
      [S390] Fix vmalloc area size calculation.
      [S390] don't call handle_mm_fault() if in an atomic context.

Henrique de Moraes Holschuh (1):
      Revert "ACPI: ibm-acpi: make non-generic bay support optional"

Hoang-Nam Nguyen (1):
      IB/ehca: Use proper GFP_ flags for get_zeroed_page()

Hongjie Yang (1):
      [S390] memory detection misses 128k.

Ingo Molnar (1):
      KVM: add VM-exit profiling

Jack Morgenstein (1):
      IB/mthca: Fix PRM compliance problem in atomic-send completions

Jack Steiner (1):
      x86-64: - Ignore long SMI interrupts in clock calibration

Jan Beulich (1):
      intel-rng workarounds

Jarek Poplawski (1):
      [IPV4] devinet: inetdev_init out label moved after RCU assignment

Jaroslav Kysela (1):
      [ALSA] version 1.0.14rc1

Jason Gaston (1):
      [ALSA] hda_intel: ALSA HD Audio patch for Intel ICH9

Jeff Garzik (1):
      Revert "[PATCH] e1000: disable TSO on the 82544 with slab debugging"

Jens Axboe (1):
      blktrace: only add a bounce trace when we really bounce

Jesse Brandeburg (2):
      ixgb: Fix early TSO completion
      ixgb: Maybe stop TX if not enough free descriptors

Jiri Kosina (2):
      HID: mousepoll parameter makes no sense for generic HID
      HID: Fix DRIVER_DESC macro

John Keller (1):
      ACPI: Altix: ACPI _PRT support

Komuro (1):
      pcnet_cs : add new id

Kyungmin Park (1):
      ARM: OMAP: fix MMC workqueue changes

Lars Ellenberg (1):
      md: pass down BIO_RW_SYNC in raid{1,10}

Len Brown (3):
      ACPI: ec: enable printk on cmdline use
      ACPI: schedule obsolete features for deletion
      ACPI: update MAINTAINERS

Linus Torvalds (3):
      Revert "[PATCH] x86-64: Try multiple timer variants in check_timer"
      Don't put "linux_banner" in the .init section
      Linux v2.6.20-rc5

Marcel Holtmann (7):
      [Bluetooth] Add packet size checks for CAPI messages
      [Bluetooth] More checks if DLC is still attached to the TTY
      [Bluetooth] Fix uninitialized return value for RFCOMM sendmsg()
      [Bluetooth] Handle device registration failures
      [Bluetooth] Correct SCO buffer size for another ThinkPad laptop
      [Bluetooth] Correct SCO buffer for Broadcom based HP laptops
      [Bluetooth] Correct SCO buffer for Broadcom based Dell laptops

Mariusz Kozlowski (1):
      [ALSA] usb: usbmixer error path fix

Mark M. Hoffman (1):
      i2c/pci: fix sis96x smbus quirk once and for all

Michael Buesch (1):
      Fix HWRNG built-in initcalls priority

Michael Chan (5):
      [BNX2]: Don't apply CRC PHY workaround to 5709.
      [BNX2]: Fix 5709 Serdes detection.
      [BNX2]: Fix bug in bnx2_nvram_write().
      [BNX2]: Update version and reldate.
      [TG3]: Add PHY workaround for 5755M.

Michael S. Tsirkin (1):
      IB/mthca: Fix off-by-one in FMR handling on memfree

Michal Ostrowski (1):
      [POWERPC] Avoid calling get_irq_server() with a real, not virtual irq.

Mikael Pettersson (1):
      MAINTAINERS: maintainer for sata_promise

Michel Dänzer (1):
      i915: Fix a DRM_ERROR that should be DRM_DEBUG.

Muli Ben-Yehuda (1):
      x86-64: tighten up printks

Nathan Lynch (2):
      [POWERPC] Fix unbalanced uses of of_node_put
      sched: tasks cannot run on cpus onlined after boot

Olaf Hering (1):
      [POWERPC] disable PReP and EFIKA during make oldconfig

Patrick McHardy (4):
      [NETFILTER]: nf_conntrack_netbios_ns: fix uninitialized member in expectation
      [NETFILTER]: nf_conntrack_ipv6: fix crash when handling fragments
      [NETFILTER]: nf_nat: fix hanging connections when loading the NAT module
      [NETFILTER]: tcp conntrack: fix IP_CT_TCP_FLAG_CLOSE_INIT value

Paul Moore (4):
      [INET]: Fix incorrect "inet_sock->is_icsk" assignment.
      NetLabel: correct locking in selinux_netlbl_socket_setsid()
      NetLabel: correct CIPSO tag handling when adding new DOI definitions
      [INET]: style updates for the inet_sock->is_icsk assignment fix

Peer Chen (1):
      [ALSA] Audio: Add nvidia HD Audio controllers of MCP67 support to hda_intel.c

Ralf Baechle (1):
      [MIPS] Malta: Add missing MTD file.

Roman Zippel (2):
      fix linux banner format string
      qconf: (re)fix SIGSEGV on empty menu items

Ron Mercer (2):
      qla3xxx: Remove NETIF_F_LLTX from driver features.
      qla3xxx: Add delay to NVRAM register access.

Russell King (5):
      [ARM] Fix kernel-mode undefined instruction aborts
      [ARM] Fix potential MMCI bug
      [ARM] pass vma for flush_anon_page()
      [ARM] Resolve fuse and direct-IO failures due to missing cache flushes
      [ARM] Provide basic printk_clock() implementation

Sean Hefty (2):
      RDMA/ucma: Fix struct ucma_event leak when backlog is full
      RDMA/ucma: Don't report events with invalid user context

Stefan Richter (1):
      ieee1394: sbp2: fix probing of some DVD-ROM/RWs

Stephen Hemminger (1):
      chelsio: error path fix

Stephen Rothwell (7):
      [POWERPC] Update ppc64_defconfig
      [POWERPC] Add legacy iSeries to ppc64_defconfig
      [POWERPC] iSeries: fix mf proc initialisation
      [POWERPC] iSeries: fix proc/iSeries initialisation
      [POWERPC] iSeries: fix lpevents initialisation
      [POWERPC] iSeries: fix viopath initialisation
      [POWERPC] iSeries: fix setup initcall

Steve Wise (1):
      RDMA/iwcm: iWARP connection timeouts shouldn't be reported as rejects

Sylvain Munaut (1):
      [POWERPC] 52xx: Don't use device_initcall to probe of_platform_bus

Takashi Iwai (2):
      [ALSA] hda-codec - Fix NULL dereference in generic hda code
      [ALSA] usbaudio - Fix kobject_add() error at reconnection

Timofei V. Bondarenko (1):
      [ALSA] _snd_cmipci_uswitch_put doesn't set zero flags

Trond Myklebust (1):
      NFS: Fix race in nfs_release_page()

Venkat Yekkirala (1):
      selinux: Delete mls_copy_context

Venkatesh Pallipadi (2):
      ACPI: rename cstate_entry_s to cstate_entry
      ACPI: delete two spurious ACPI messages

Vitaly Wool (1):
      [MIPS] PNX8550: Fix system timer support

Vivek Goyal (10):
      x86-64: Make noirqdebug_setup function non init to fix modpost warning
      i386: cpu hotplug/smpboot misc MODPOST warning fixes
      i386: make apic probe function non-init
      x86-64: modpost add more symbols to whitelist pattern2
      x86-64: Modpost whitelist reference to more symbols (pattern 3)
      x86-64: pci quirks MODPOST warning fix
      i386: Fix memory hotplug related MODPOST generated warning
      i386: Convert some functions to __init to avoid MODPOST warnings
      Kdump documentation update
      i386: sched_clock using init data tsc_disable fix

Vlad Yasevich (1):
      [SCTP]: Fix err_hdr assignment in sctp_init_cause.

Zhu Yi (2):
      ieee80211: WLAN_GET_SEQ_SEQ fix (select correct region)
      ipw2100: Fix dropping fragmented small packet problem

takada (1):
      fix typo in geode_configre()@cyrix.c

---1463790079-1875538672-1168630068=:11200--
