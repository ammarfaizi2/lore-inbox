Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUIKX0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUIKX0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 19:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUIKXZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 19:25:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268365AbUIKXZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 19:25:44 -0400
Date: Sat, 11 Sep 2004 19:01:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-pre3
Message-ID: <20040911220117.GA4669@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the third pre of 2.4.28, containing a bunch of scattered fixes.

The bigger modifications are XFS update, prism54 update, libata fixes, 
more gcc 3.4 cleanups, amongst others.

Read the detailed changelog for more details


Summary of changes from v2.4.28-pre2 to v2.4.28-pre3
============================================

<achew:nvidia.com>:
  o sata_nv: fix CK804 support
  o i810_audio.c and pci_ids.h: add support for nforce MCP2S,

<ajgrothe:yahoo.com>:
  o [CRYPTO]: Add Whirlpool digest algorithm

<apm:brigitte.dna.fi>:
  o [NETFILTER]: Fix unaligned access in arp_tables.c

<bzolnier:elka.pw.edu.pl>:
  o libata: ata_piix.c PIO fix

<davem:davemloft.net>:
  o LVM ioctl fix - Trying to vfree() nonexistent vm area

<felixb:sgi.com>:
  o [XFS] Removed xfs_iflush_all and all usages of vn_purge, except one in clear_inode path.
  o [XFS] Restored xfs_iflush_all, which is still used to finish reclaims

<ha505:hszk.bme.hu>:
  o [netdrvr fealnx] fix spin_unlock_irqrestore() usage

<ileong:nvidia.com>:
  o [ac97_codec] add new codec

<lcapitulino:conectiva.com.br>:
  o drivers/pci/pci.c NULL pointer fix
  o Fix missing `return NULL' missing in ext3_get_journal()

<mchan:broadcom.com>:
  o [TG3]: Check MAC_STATUS_SIGNAL_DET in serdes polling

<pablo:eurodev.net>:
  o [NETLINK]: Improve sendmsg() behavior of netlink sockets

<pjones:redhat.com>:
  o [SPARC64]: Support 64-bit initrd addresses

<rgooch:safe-mbox.com>:
  o drivers/char/ib700wdt.c ibwdt_ping() fix
  o Syntax fix drivers/media/video/bttv-driver.c

<richm:oldelvet.org.uk>:
  o [SPARC64]: Set LVM fields more consistently in ioctl32.c code

<tharbaugh:lnxi.com>:
  o [netdrvr e1000] disable DITR, which apparently hurts performance

Adrian Bunk:
  o ibmphp_res.c: fix gcc 3.4 compilation
  o lmc_media.c: fix gcc 3.4 compilation
  o ircomm_param.c: fix __FUNCTION__ paste error
  o irlmp.c: fix gcc 3.4 compilation
  o asm-i386/smpboot.h: fix gcc 3.4 compilation
  o dscc4.c: fix gcc 3.4 compilation

Christoph Hellwig:
  o [XFS] Rework freeze/unfreeze infrastructure
  o [XFS] Move all ioctl definitions into a common place for 32bit ioctl translation.
  o [XFS] avoid using pid_t in ioctl ABI
  o [XFS] Fix warnings in xfs_bmap.c
  o [XFS] Remove a readahead page allocation failure warning, this will happen under normal workloads and does not indicate a problem.

Dave Kleikamp:
  o JFS: Trivial: remove dead code
  o JFS: fix memory leak in __invalidate_metapages

David S. Miller:
  o [TIGON3]: Mention that firmware is copyrighted by Broadcom
  o [TG3]: Revamp fibre PHY handling
  o [SPARC64]: Fix PCI IOMMU invalid iopte handling
  o [IPV4]: Fix theoretical loop on SMP in ip_evictor()
  o [IPV6]: ip6_evictor() has same problem as ip_evictor()
  o [TG3]: Remove autoneg handling from fibre_autoneg() unneeded
  o [TG3]: Always set MAC_EVENT_LNKSTATE_CHANGED even when serdes polling
  o Cset exclude: davem@nuts.davemloft.net|ChangeSet|20040817010145|64922
  o [TG3]: Do tg3_netif_start() under lock
  o [TCP]: When fetching srtt from metrics, do not forget to set rtt_seq
  o [TG3]: Disable CIOBE split, as per Broadcom's driver
  o [TG3]: Add 5750 A3 workaround
  o [SPARC64]: Save/restore %asi properly in signal handling
  o [SPARC64]: Remove memcpy Ultra3 PCACHE patching trick
  o [SPARC64]: Use saner local label names in Ultra3 copies
  o [SPARC64]: Revamped memcpy infrastructure
  o [SPARC64]: Update defconfig
  o [SPARC64]: Remove memcpy/bzero symbol usage in sparc64_do_profile
  o [SPARC64]: Fix arg passing to copy_in_user()
  o [MAINTAINERS]: Update my email address
  o [CREDITS]: Update my email and home address
  o [TG3]: Add capacitive coupling support
  o [TG3]: Fix clock control programming on 5705/5750
  o [TG3]: Update driver version and reldate
  o [NETLINK]: Two cleanups

Dean Roehrich:
  o [XFS] Fix lock leak in xfs_free_file_space
  o [XFS] Change DMAPI dm_punch_hole to punch holes, rather than just truncate files.

Douglas Gilbert:
  o scsi_debug update
  o scsi_error.c: break out repeatable error retries when eh mode

Eric Sandeen:
  o [XFS] Add filesystem size limit even when XFS_BIG_BLKNOS is in effect; limited by page cache index size (16T on ia32)
  o [XFS] Code checks to trap access to fsb zero

Glen Overby:
  o [XFS] Permit buffered writes to the real-time subvolume

Jack Hammer:
  o ServeRAID driver (ips) Version 7.10.18

Jason Baron:
  o ppos cleanups

Jeff Garzik:
  o [libata] resync with 2.6 (very minor, mostly cosmetic)

Jeremy Higdon:
  o Fix DMA boundary overflow bug

Krzysztof Halasa:
  o fix for integer overflow in hd6457[02] driver code

Marcelo Tosatti:
  o Fix mm.h typo introduced by s390 changes
  o Changed EXTRAVERSION to -pre3

Margit Schubert-While:
  o prism54 Update to 2.6 status
  o prism54 Bug - Fix frequency reporting

Mikael Pettersson:
  o more gcc34 lvalue fixes
  o drivers/ide/pci/sc1200.c cast-as-lvalue fix

Nathan Scott:
  o [XFS] Documentation updates
  o [XFS] Export sync_buffers routine for filesystems to use
  o [XFS] Revert to using a separate inode for metadata buffers once more
  o [XFS] Remove unneeded escape from printed string.  From Chris Wedgwood
  o [XFS] sparse: annotate source for user pointers.  From Chris Wedgwood
  o [XFS] sparse: annotate quota source for user pointers.  From Chris Wedgwood
  o [XFS] Fix a possible data loss issue after an unaligned unwritten extent write.
  o [XFS] Fix xfs_off_t to be signed, not unsigned; valid warnings emitted after stricter compilation options used by some OSDL folks.
  o [XFS] xfs_Gqm_init cannot fail, dont check return value
  o [XFS] sparse: fix header include order to get cpp macros defined correctly.  From Chris Wedgwood.
  o [XFS] sparse: rework previous mods to fix warnings in DMAPI code
  o [XFS] sparse: fix uses of NULL in place of zero and vice versa
  o [XFS] Fix signed/unsigned issues in xfs_reserve_blocks routine
  o [XFS] Fix accidental reverting of sync write preallocations
  o [XFS] Fix a blocksize-smaller-than-pagesize hang when writing buffers with a shared page.
  o [XFS] Add support for unsetting realtime flag on realtime file which has no extents allocated.
  o [XFS] Remove several macros which are no longer used anywhere
  o [XFS] Use sparse whitespace approach that Al took to be more consistent
  o [XFS] Add a realtime inheritance bit for directory inodes so new files can be automatically created as realtime files.
  o [XFS] Support for default quota limits via the zero dquot (ala grace times)
  o [XFS] Ensure maxagi not updated early during growfs, conflicts with concurrent inode allocations.  Fix from ASANO Masahiro.

Olaf Kirch:
  o [NETFILTER]: Fix pointer deref'ing in ip6t_LOG.c

Patrick McHardy:
  o [PKT_SCHED]: Use double-linked list for dev->qdisc_list
  o [PKT_SCHED]: Fix class leak in CBQ scheduler
  o [NETFILTER]: Flush fragment queue on conntrack unload
  o [NETFILTER]: Fix confusing naming in NAT-helpers
  o [NETFILTER]: Fix deadlock condition in conntrack/nat-helpers

Paul Fulghum:
  o synclinkmp transmit eom fix

Stephen Hemminger:
  o [PKT_SCHED]: Sync netem scheduler with 2.6.x

Timothy Shimmin:
  o [XFS] Fix up handling of SB versionnum when filesystem on disk has newer bit features than the kernel.
  o [XFS] Fix up header length miscalculation for version 1 logs

