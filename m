Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUHOXIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUHOXIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUHOXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:08:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44172 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267231AbUHOXIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:08:25 -0400
Date: Sun, 15 Aug 2004 18:32:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-pre1
Message-ID: <20040815213229.GA11500@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the first 2.4.28 -pre release.

It contains a big SATA update with long list of fixes,
a networking update (mainly SCTP fixes), lib crypto fixes and 
the addition of the Khazad algorithm, add prism54 wireless driver,
SPARC64 update, cciss SCSI driver fixes, couple of storage devices 
added to SCSI device list, agpgart support for i915 chipset, 
OOM killer rare-case bugfixes, a VM bugfix which could 
cause deadlocks under OOM conditions, a bunch of warnings fixes, 
and initial support for gcc 3.4.

I still have a few bugfixes pending on my inbox, which should
be merged next week.

Read the detailed changelog for more details


Summary of changes from v2.4.27 to v2.4.28-pre1
============================================

<achew:nvidia.com>:
  o [libata] Add NVIDIA SATA driver
  o [ata] fix reversed bit definitions in linux/ata.h
  o [libata] unmap MMIO region _after_ last possible usage

<ajgrothe:yahoo.com>:
  o [CRYPTO]: Add Khazad algorithm

<alanh:fairlite.demon.co.uk>:
  o AGPgart update: Intel i915G support

<castor:3pardata.com>:
  o Add 3PARdata InServ Virtual Volume to SCSI device list

<frank_borich:us.xyratex.com>:
  o Add Xyratex 4200 to SCSI blacklist

<ha505:hszk.bme.hu>:
  o Fix i2o_pci.c warning
  o Extra tokens at #undef in ma600.c
  o Missing enforced type conversion in pc300_tty.c
  o Redefinition before undefinition in pci-pc.c
  o Redefination before undefination in fore200e.c

<jon:oberheide.org>:
  o [CRYPTO]: Email update in crypto/arc4.c

<joshk:triplehelix.org>:
  o [SPARC]: Add missing GPL module license tags to drivers

<mcgrof:ruslug.rutgers.edu>:
  o [wireless] add new prism54 driver

<sergio.gelato:astro.su.se>:
  o libata: fix kunmap() of incorrect page, in PIO data xfer

<sezeroz:ttnet.net.tr>:
  o agpgart: Missing chipset enum entry for i915
  o warning fixes: ULL-fixes
  o warning fixes: befs trivial
  o trivial iph5526.c fixes from 2.6
  o trivial nwflash.c missing -EFAULT retcode
  o backport applicom 2.6 fixes
  o trivial: various "unused" warnings
  o amd76xrom.c unused warning

Adrian Bunk:
  o 2.6.7-mm1: drivers/scsi/hosts.h -> scsi/scsi_host.h
  o update email address of Pedro Roque Marques

Bartlomiej Zolnierkiewicz:
  o DMA mode setup fixes for piix.c/ata_piix.c

Chris Wright:
  o fix possible buffer overflow in panic()

Daniel Ritz:
  o PCI: fix irq routing on acer travelmate 360 laptop

David Dillow:
  o [SPARC64]: Handle SBUS dma allocations larger than 1MB

David S. Miller:
  o [SPARC64]: Document reserved and soft2 bits in PTE
  o [SPARC64]: Reserve a software PTE bit for _PAGE_EXEC
  o [SPARC64]: Non-executable page support
  o [SPARC64]: Duh, s/_PAGE_FILE/_PAGE_EXEC/
  o [SPARC64]: Add CMT register defines
  o [SPARC64]: Kill all this silly inline memcpy handling
  o [SPARC64]: Simplify and optimize ultra3 memory copies
  o [SPARC64]: More entropy in add_timer_randomness

James Morris:
  o [CRYPTO]: Typo in Documentation/Configure.help
  o [CRYPTO]: Typo in crypto/twofish.c
  o [CRYPTO]: Typo in crypto/aes.c
  o [CRYPTO]: Typo in crypto/scatterwalk.c
  o [CRYPTO]: Typo in crypto/blowfish.c
  o [CRYPTO]: Typo in crypto/tcrypt.h

Jeff Garzik:
  o [libata] don't probe from workqueue
  o [libata] PCI IDE DMA code shuffling
  o [libata] PCI IDE command-end/irq-acknowledge cleanup
  o [libata] ->qc_prep hook
  o [libata] Add Intel ICH5/6 driver
  o [IDE] Introduce SATA enable/disable config option
  o [libata ata_piix] disable combined mode
  o [libata/IDE nvidia] shuffle pci ids
  o [libata] move some code around
  o [libata] fix build error, minor cleanups
  o [libata ata_piix] combined mode bug fix; improved ICH6 support
  o [libata sata_sil] Re-fix mod15write bug
  o [libata] add ->qc_issue hook
  o [libata] add ata_queued_cmd completion hook
  o [libata] create, and use, ->irq_clear hook
  o [ata] add ata_ok() inlined helper, and ATA_{DRDY,DF} bit to linux/ata.h
  o [libata] split ATA_QCFLAG_SG into ATA_QCFLAG_{SG,SINGLE}
  o [libata] create, and use aga_sg_init[_one] helpers
  o [libata sata_promise] update driver to use new ->qc_issue hook
  o [libata] transfer mode cleanup
  o [libata] fix completion bug, better debug output
  o [libata] transfer mode bug fixes and type cleanup
  o [libata] pio/dma flag bug fix, and cleanup
  o [libata] convert set-xfer-mode operation to use ata_queued_cmd
  o [libata sata_promise] convert to using packets for non-data taskfiles
  o [libata sata_sx4] deliver non-data taskfiles using Promise packet format
  o [libata] update IDENTIFY DEVICE path to use ata_queued_cmd
  o [libata] export msleep for use in libata drivers
  o [libata] ATAPI work - PIO xfer, completion function
  o [libata ata_piix] make sure AHCI is disabled, if h/w is used by this driver
  o [libata] flags cleanup
  o [libata] ATAPI work - cdb len, new taskfile protocol, cleanups
  o [libata] fix a 2.6-ism that snuck in

Liam Girdwood:
  o Fix unsafe reset in ac97_codec.c, support WM9713, more fixes

Marcelo Tosatti:
  o Herbert Xu: delete zero sized files from BK repository
  o Changed Makefile to 2.4.28-pre1

Martin Devera:
  o [PKT_SCHED]: Fix borrowing fairness in htb

Mikael Pettersson:
  o gcc-3.4 fixes 1/3: fastcall mismatches
  o gcc-3.4 fixes 2/3: bogus lvalues
  o gcc-3.4 fixes 3/3: misc remaining issues

Mike Miller:
  o cciss update [1/5] PCI ID fix for cciss SATA hba
  o cciss update [2/5] fix for 32/64-bit conversions
  o cciss update [3/5] pci_dev->irq fix
  o cciss update [4/5] fix for HP utilities
  o cciss update [5/5] maintainers update for HP drivers

Pat LaVarre:
  o ata_check_bmdma
  o SATAPI despite no data

Pete Zaitcev:
  o David Brownell: Fix uhci-hcd oops

Richard Hitt:
  o s390x: enable ioctl's for UTS global 3270
  o UTS Global Cisco CLAW driver: avoid packets from being lost under heavy load
  o UTS Global Cisco CLAW driver: remove old ifdefs and adds GPL header
  o UTS Global Cisco CLAW driver: Fix 64-bit handling

Ricky Beam:
  o [libata sata_sil] add drive to mod15write quirk list

Rik van Riel:
  o reserved buffers only for PF_MEMALLOC

Sridhar Samudrala:
  o [SCTP] SPARSE cleanup backported from 2.6
  o [SCTP] Set/Get default SCTP_PEER_ADDR_PARAMS for endpoint when associd and peer address are 0.
  o [SCTP] Fix data not being delivered to user in SHUTDOWN_SENT state
  o [SCTP] Fix issues with handling stale cookie error over multihoming associations.
  o [SCTP] Fix missing '+' in the computation of sack chunk size in sctp_sm_pull_sack().
  o [SCTP] Mark chunks as ineligible for fast retransmit after they are retransmitted. Also mark any chunks that could not be fit in the PMTU sized packet as ineligible for fast retransmit.

Tom 'spot' Callaway:
  o [SPARC]: Fix copy_user.S with gcc 3.3

William Lee Irwin III:
  o [SPARC32]: Mark William Lee Irwin III as maintainer
  o Fix OOM killer issues: kill all threads of a process and ignore kernel threads
  o OOM killer: make jiffies comparison wrap safe

