Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbULPO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbULPO20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbULPO1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:27:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262669AbULPOZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:25:53 -0500
Date: Thu, 16 Dec 2004 09:35:59 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-pre2
Message-ID: <20041216113559.GF8246@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second -pre of Linux v2.4.29.

It contains a relatively small number of changes: XFS sync, SPARC64 sync,
USB gadget updates, couple of libata fixes, amongst others.

Also a networking update, containing fixes for following recently discovered 
security issues:

CAN-2004-1137
IGMP vulnerabilities - local priveledge escalation and remote DoS:
http://isec.pl/vulnerabilities/isec-0018-igmp.txt

CAN-2004-1016
scm_send local DoS:
http://isec.pl/vulnerabilities/isec-0019-scm.txt

Summary of changes from v2.4.29-pre1 to v2.4.29-pre2
============================================

<alexn:dsv.su.se>:
  o Correct /dev/mptctl major number in Configure.help

<nboullis:debian.org>:
  o [SPARC64]: Add SMB_IOC_GETMOUNTUID32 to compat ioctl table

<tv:lio96.de>:
  o VM documentation fix: vm_anon_lru default is 0

Adrian Bunk:
  o remove bouncing email address of Deanna Bonds
  o add missing SCSI_SATA_AHCI Configure.help entry
  o USB_ETH{,_RNDIS} EXPERIMENTAL dependencies
  o let SCSI_SATA_NV depend on EXPERIMENTAL
  o Update email address of Philip Blundell
  o update email address of Andrea Arcangeli

Cal Peake:
  o remove obsolete PIIX config help

Chris Wright:
  o proc_tty.c warning fix
  o [IPV4/IPV6]: IGMP source filter fixes

Christoph Hellwig:
  o [XFS] handle nfs requesting ino 0 gracefully
  o [XFS] fix handling of bad inodes
  o [XFS] remove useless S_ISREG check in ->mmap and ->mprotect
  o [XFS] split pagebuf_get, use get/read_flags correctly
  o [XFS] Fix declaration of _pagebuf_find to not be static
  o [XFS] handle inode creation race
  o [XFS] call the right function in pagebuf_readahead

David Brownell:
  o usb gadget updates: core
  o usb gadget updates: ether/rndis
  o usb gadget updates: Minor update to handle more hardware

David S. Miller:
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix SMP cpu bringup bug when bigkernel
  o [IPV4]: Do not leak IP options
  o [NET]: CMSG compat code needs signedness fixes too

Dean Roehrich:
  o [XFS] Need to vn_revalidate after dm_set_fileattr
  o [XFS] update a copyright notice

Douglas Gilbert:
  o off-by-1 libata-scsi INQUIRY VPD pages 0x80 and 0x83

Eric Sandeen:
  o [XFS] Wait for all async buffers to complete before tearing down the filesystem at umount time

Geoffrey Wehrman:
  o [XFS] Add xfs_rotorstep sysctl for controlling placement of extents for new files by the inode32 allocator.

Herbert Xu:
  o [NET]: Fix CMSG validation checks wrt. signedness

Ingo Molnar:
  o floppy boot-time detection fix

Jakub Bogusz:
  o don't recursively crash in die() on CHRP/PReP machines

Jeff Garzik:
  o [libata docs] add chapter on libata driver API
  o [libata] only DMA map data for DMA commands (fix >=4GB bug)

Jon Krueger:
  o [XFS] Allow the option of skipping quotacheck processing

Len Brown:
  o [ACPI] acpi=off must disable acpi_early_init()

Luca Tettamanti:
  o radeonfb: don't try to ioreamp the entire VRAM
  o Add new PCI id to radeonfb

Marcelo Tosatti:
  o Cset exclude: vince@arm.linux.org.uk|ChangeSet|20041125151649|65331
  o backport v2.6 fork/thread file descriptor race fix
  o p8022 unregister packet type on unload
  o Make sure VC resizing fits in s16
  o psnap correctly unregister on module exit
  o Changed EXTRAVERSION to -pre2

Nathan Scott:
  o [XFS] Fix incorrect use of do_div on realtime device growfs code path
  o [XFS] Fix some locking oddities in extended attributes code (ilock excl vs shared).
  o [XFS] Convert to list_for_each_entry_safe form in reclaim list walk
  o [XFS] Ensure bytes read statistic is not updated when the generic routines fail.
  o [XFS] Add nosymlinks inode flag for the security folks, reserve projinherit flag.
  o [XFS] Update XFS quota header - add macros, use standard gpl template
  o [XFS] Make xfssyncd more generic, hand off out-of-space flushing to it; fixes two deadlocks when near-full and fixes a 4KSTACKS problem in XFS.
  o [XFS] Remove crufty old cap/mac code - never used, never compiled, gone
  o [XFS] Fix merge botch affecting xfs_setattr for realtime files
  o [XFS] Simplify page probe/submit code so buffers bayond eof not dirtied/written.
  o [XFS] Remove unused function prototypes

Randy Dunlap:
  o Fix unresolved symbol on x86-64: export swiotlb

Solar Designer:
  o [TCP]: Missing KERN_* in input path printks

Stephen Hemminger:
  o [UDP]: Select handling of bad checksums

Timothy Shimmin:
  o [XFS] xfs reservation issues with xlog_sync roundoff

Wensong Zhang:
  o [IPVS] add a sysctl variable to expire quiescent template

