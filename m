Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUECXIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUECXIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUECXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:08:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264153AbUECXI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:08:27 -0400
Date: Mon, 3 May 2004 20:09:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-pre2
Message-ID: <20040503230911.GE7068@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the second pre release of 2.4.27.

It contains m68k/SPARC, XFS and networking updates, big PCI hotplug
update, gcc3 fixes, riva fixes, IDE update, amongst others.

Please read the detailed changelog

Summary of changes from v2.4.27-pre1 to v2.4.27-pre2
============================================

<aj:andaco.de>:
  o [TG3]: Fix typo in TG3_TSO_FW_RODATA_ADDR definition

<gandalf:winds.org>:
  o Blue line in nVidia framebuffer (rivafb)

<jkmaline:cc.hut.fi>:
  o [CRYPTO]: Add suuport for keyed digests
  o [CRYPTO]: Add Michael MIC algorithm

<jpk:sgi.com>:
  o [XFS] Correct the (file size >= stripe unit) check inside xfs_iomap_write_delay.  It was comparing the file size, in bytes, against the stripe unit size, in FSBs.

<mchan:broadcom.com>:
  o [TG3]: Jumbo frames and FTQ reset patch
  o [TG3]: Fix jumbo frame PHY programming

Andrea Arcangeli:
  o Fix page-free-at-IRQ context BUG

Bartlomiej Zolnierkiewicz:
  o IDE PCI: fix support for PIO modes w/o IORDY flow control
  o serverworks.c: fix DMA for OSB4 (Patrick Wildi)
  o generic PCI IDE support for more Toshiba Piccolo chips (Daniel Drake)

Chas Williams:
  o [ATM]: get atm_guess_pdu2truesize() right
  o [ATM]: [nicstar] using dev_alloc_skb() (reported by Johnston,
  o [ATM]: [fore200e] 0.3e version by Christophe Lizzi (lizzi@cnam.fr)
  o [ATM]: [fore200e] make tasklet use configurable

Chris Wright:
  o [IPV4]: Fix return value on MCAST_MSFILTER error case

Christoph Hellwig:
  o [XFS] use kmem_alloc for noaddr buffers
  o [XFS] kill the pagebuf vs xfs_buf confusion
  o [XFS] really kill the pagebuf vs xfs_buf confusion
  o [XFS] clarify pagebuf page lookup logic
  o [XFS] cleanup pagebuf flag usage and simplify pagebuf_free
  o [XFS] close external blockdevice after final flush

David S. Miller:
  o [TG3]: Just completely delete the disabled FTQ reset code
  o [SPARC64]: Kill cast as lvalue usage in pgd/pmd macros
  o [SPARC64]: Fix rest of cast as lvalue usage in sparc64 code
  o [TG3]: Kill 'force' arg to tg3_phy_reset, it is always set
  o [TG3]: At start of tg3_phy_copper_begin, force phy out of loopback mode
  o [TG3]: Do not allow illegal ethtool advertisement bits
  o [SPARC64]: Export prom_palette
  o [TG3]: Add missing 5704 BX workaround, and fix typo in autoneg fix
  o [TG3]: Set GRC_MISC_CFG prescaler more safely
  o [TG3]: Fix serdes cfg programming on 5704
  o [TG3]: When link is down, set stats coalescing ticks to zero
  o [TG3]: Wait a bit for BMSR/BMCR bits to settle in PHY setup
  o [TG3]: Verify link advertisement correctly on 10/100 only chips
  o [TG3]: All 5705 chips need PHY reset on link-down
  o [TG3]: More PHY programming fixes
  o [TG3]: Bump driver version and reldate
  o [TG3]: Print list of important probed capabilities at driver load
  o [TG3]: Two PHY fixes
  o [TG3]: Kill uninitialized var warning
  o [TG3]: Reset fixes
  o [TG3]: Update driver version and release date
  o [SPARC]: Use 64 for KERN_SPARC_SCONS_PWROFF to prevent 2.6.x conflicts
  o [TG3]: Update driver version and reldate
  o [TG3]: Undo comment typo fix, it was wrong
  o [SPARC64]: Fix zero-extension issues wrt. {pgd,pmd}_val()
  o [SPARC64]: Update defconfig

David Stevens:
  o [IPV4]: Fix IGMP version number and timer printing for procfs

Dely Sy:
  o SHPC and PCI Express hot-plug drivers for 2.4 kernel
  o PCI Hotplug: SHPC & PCI-E hot-plug fixes

Eric Brower:
  o [SPARC]: Add sysctl to control serial console power-off restrictions
  o [SPARC64]: HDIO_DRIVE_TASK is a compatible ioctl

Eric Sandeen:
  o [XFS] Use pgoff_t for page indices, and remove some other type confusion
  o [XFS] New PFLAGS_RESTORE_FSTRANS macro to restore only FSTRANS state from saved state.

Geert Uytterhoeven:
  o [NET]: Make pktgen depend upon procfs
  o NCR53C9x unused SCp.have_data_in
  o M68k TLB fixes
  o Amiga A2065 Ethernet debug

Grant Grundler:
  o [TG3]: Fix comment typo

Harald Welte:
  o [NETFILTER]: Add more debug info to TFTP helper

Hideaki Yoshifuji:
  o [IPV6]: Mark MLDv2 report as known
  o [IPV6]: Use IANA icmpv6 type for MLDv2 report

Jakub Bogusz:
  o rivafb 16bpp text background colour fix

Jamal Hadi Salim:
  o [NET_SCHED]: Check for NULL opt in dsmark_init

Jeff Garzik:
  o [TG3]: Dump NIC-specific statistics via ethtool

Jon Oberheide:
  o [CRYPTO]: ARC4 config help clarification

Marcel Holtmann:
  o [Bluetooth] Allow normal users to release the previous created TTY
  o [Bluetooth] Fix race in RX complete routine of the USB drivers
  o [Bluetooth] Make use of request_firmware() for the 3Com driver
  o [Bluetooth] Add UART protocol id's for 3-Wire and H4DS

Marcelo Tosatti:
  o Andrew Morton: __free_pages_ok() stress testing
  o Changed EXTRAVERSION to -pre2

Matt Porter:
  o ppc32: fix head_44x.S copyrights

Nathan Scott:
  o [XFS] Fix a very hard-to-hit, small-block-size only corruption
  o [XFS] Fix delayed write buffer handling to use the correct list interfaces, add validity checks, remove unused code, fix comments.
  o [XFS] Make buffer error checking consistent, add a value range check
  o [XFS] Return the right error code on an ACL xattr version mismatch
  o [XFS] Allow xfsbufd flush intervals to take immediate effect after changing the flush sysctl value.  Fix from Bart Samwel.
  o [XFS] Clear the superblock dirty flag after flushing the log in sync_super.
  o [XFS] Fix vmtruncate abuse in the XFS setattr ATTR_SIZE operation
  o [XFS] make return value type for read() really ssize_t
  o [XFS] Define a new superblock field for more feature bits
  o [XFS] Fix debug builds - need sb_features2 details in the endian translation code.
  o Remove a bk ignored XFS cvs directory, accidentally added
  o Fix typo in delayed allocate buffer count reporting (sysrq-m)
  o Minor updates to XFS documentation
  o [XFS] Fix fsync regression resulting from moving data flushing out from under the IOLOCK.
  o [XFS] Remove extraneous vmtruncate call, missed in earlier merge
  o [XFS] Remove xfs_iaccess checks on security extended attribute namespace, done outside the filesystem.

Russell Cattelan:
  o [XFS] Fix for the xfs dir2 rebalance bug

Rusty Russell:
  o [NETFILTER]: Missing ip_rt_put in ipt_MASQUERADE

Sridhar Samudrala:
  o [SCTP] Fix typo in entry name of the remove_proc_entry() call
  o [SCTP] Update sctp_ulpevent structure to include assoc pointer and
  o [SCTP] Avoid the use of constant SCTP_IP_OVERHEAD to determin the max data size in a SCTP packet.
  o [SCTP] Cleanup sctp_packet and sctp_outq infrastructure
  o [SCTP] Partial Reliability Extension support
  o [SCTP] Propagate error from sctp_proc_init. (Olaf Kirch)

Stephen C. Tweedie:
  o fix O(N^2) dquot sync behaviour

Takayoshi Kochi:
  o PCI Hotplug: acpiphp unable to power off slots

Takayoshi Kouchi:
  o PCI Hotplug: acpiphp cleanup patch for 2.4.23-pre4

William Lee Irwin III:
  o Joel Becker: Fix summit crash: cpu_present_to_apicid() bound checking

Zwane Mwaikambo:
  o fix module load with gcc3.3.3
  o Fix typo in include/linux/compiler.h

