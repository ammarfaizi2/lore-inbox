Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUESPet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUESPet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUESPes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:34:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56225 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264226AbUESPd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:33:59 -0400
Date: Tue, 18 May 2004 17:30:40 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-pre3
Message-ID: <20040518203039.GA9970@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the third pre of 2.4.27.

It contains network driver fixes, nForce2 hang PCI workaround, 
i810 audio fixes, JFS update, ACPI, sh64/ia64 arch updates, amongst
others.

Please refer to the detailed changeloged

Summary of changes from v2.4.27-pre2 to v2.4.27-pre3
============================================

<achurch:achurch.org>:
  o ext2fs sb= mount option fix

<chad.dupuis:hp.com>:
  o Fix HP HSG80 storage array entry on SCSI device list

<gtw:cs.bu.edu>:
  o [sound i810] silently ignore invalid PCM_ENABLE_xxx bits from userland

<jparmele:wildbear.com>:
  o ad1848: Fix crystal CS4235 mixer setup

<lkml:lievin.net>:
  o tipar char driver: wrong timeout value

<m.c.p:kernel.linux-systeme.com>:
  o copy WARN_ON() definition from 2.6

<ouellettes:videotron.ca>:
  o Remove extra semicolumn in arch/i386/mm/fault.c

<ross:datscreative.com.au>:
  o nVidia supplied nForce2 workaround

Andrew Morton:
  o sata_sx4.c warning fix

Arun Sharma:
  o ia64: make ia32 core dumps work

Bjorn Helgaas:
  o Cset exclude: arun.sharma@intel.com[helgaas]|ChangeSet|20040405163028|42090
  o ia64: Fix ia32 core dumps
  o ia64: Update defconfigs
  o ia64: Update defconfig to current generic config
  o ia64: Allow IO port space without EFI RT attribute
  o ia64: Define acpi_pci_disabled for recent ACPI update

Dave Kleikamp:
  o JFS: [CHECKER] Fix a possible null-pointer dereference
  o JFS: [CHECKER] Memory leak in jfs_link
  o JFS: [CHECKER] get rid of txAbortCommit
  o JFS: Avoid race invalidating metadata page
  o JFS: reduce stack usage
  o JFS: [CHECKER] More robust error recovery in add_index
  o JFS: module unload was not removing /proc/fs/jfs/

David Mosberger:
  o ia64: Fix typo in unwinder which could cause NULL-pointer dereferences

Don Fry:
  o pcnet32 whitespace only changes
  o pcnet32 support for 79C976
  o pcnet32 all printk under netif_msg
  o pcnet32 correct name display
  o pcnet32 add led blink capability
  o pcnet32 transmit performance fix
  o pcnet32 add register dump capability
  o pcnet32 timer to free tx skbs for 79C971/972

Gerd Knorr:
  o Fix V4L miss of range check oops

Herbert Xu:
  o [sound i810] fix wait queue race in drain_dac
  o [sound i810] fix race
  o [sound i810] remove bogus CIV_TO_LVI
  o [sound i810] clean up with macros
  o [sound i810] fix partial DMA transfers
  o [sound i810] fix playback SETTRIGGER
  o [sound i810] fix OSS fragments
  o [sound i810] remove divides on playback
  o [sound i810] fix drain_dac loop when signals_allowed==0
  o [sound i810] fix reads/writes % 4 != 0
  o [sound i810] fix deadlock in drain_dac

Jack Hammer:
  o ServeRAID driver update to 7.00.15: sync with v2.6

Jack Steiner:
  o ia64: fix HUGETLB null pointer dereference

Jeff Garzik:
  o [netdrvr b44] sync with 2.6.x version
  o Add dummy "__user" marker, for compat with 2.6.x
  o Rename get_current_user tmpvar to avoid namespace clash
  o [netdrvr] Add driver for IBM p/iSeries virtual ethernet adapters
  o [libata sata_sis] add new PCI id
  o [libata] Promise driver split part 1: clone to sx4
  o [libata] Promise driver split part 2: remove SX4 code from sata_promise
  o [libata] Promise driver split part 3: remove TX2/4 code from sata_sx4
  o [libata] Promise driver split part 4: common header
  o [libata] add ata_tf_{to,from}_fis helpers
  o [libata] clean up taskfile submission to hardware
  o [libata] remove call to WARN_ON(), 2.4 doesn't have this
  o [libata] move ATAPI startup from katad thread to workqueue thread
  o [libata] minor updates
  o [libata] move PIO data xfer from katad thread to workqueue thread
  o [libata] move probe execution from katad thread to workqueue thread
  o [libata] move ATAPI command initiation code from libata-scsi to libata-core
  o [libata] kill unnecessary include
  o [libata] internal cleanup: kill ata_pio_start
  o [libata] some work on the ATAPI path
  o [libata] Make sure to initialize PIO data xfer state
  o [libata] replace per-command semaphore with optional completion
  o [libata promise] make sure our schedule_timeout(N) are never with N==0
  o [libata] remove unused struct ata_engine
  o [libata sata_sx4] trivial: fix filename in header
  o [libata sata_sis] support SATA SCRs in PCI cfg space
  o [libata] preparation for writeback caching support
  o [libata] Maintainer annotations
  o [sound i810] sync with 2.6.x driver
  o [sound i810] bump driver to version 1.00

Jeremy Higdon:
  o sata_vsc initialization fix

Karol Kozimor:
  o acpi4asus 0.28 (Karol 'sziwan' Kozimor)

Krzysztof Halasa:
  o [netdrvr tulip] fix use-after-free

Len Brown:
  o [ACPI] delete unused CONFIG_ACPI_RELAXED_AML this code is included always -- or disable at boot w/ "acpi=strict
  o [ACPI] Delete IRQ2 "cascade" in ACPI IOAPIC mode no such concept exists in ACPI, frees IRQ2 for use.
  o [ACPI] enhance intr-src-override parsing to handle ES7000 http://bugme.osdl.org/show_bug.cgi?id=2520
  o [ACPI] allow use of IRQ2 in ACPI/IOAPIC mode http://bugzilla.kernel.org/show_bug.cgi?id=2564
  o [ACPI] No IRQ known... - using IRQ 255 (Bjarni Rúnar Einarsson) http://bugzilla.kernel.org/show_bug.cgi?id=2148
  o [ACPI] battery "charged" instead of "unknown" (Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=1863
  o [ACPI] support button driver unload (Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=2281
  o [ACPI] pci-link may not always be SHARED (SuSE via Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=2404
  o [ACPI] pcibios_scan_root fix for IA64 (from IA64 tree via Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=2130
  o [ACPI] toshiba_acpi driver if acpi_disabled (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=2465
  o [ACPI] button build fix
  o [ACPI] export symbols to button module
  o [ACPI] PCI Interrupt Link fixes
  o [ACPI] rmmod ACPI modules vs /proc from Anil S Keshavamurthy and David Shaohua Li http://bugzilla.kernel.org/show_bug.cgi?id=2457
  o [ACPI] enhance "pci=noacpi" to skip PCI probe (David Shaohua Li) add "acpi=noirq" to just disable IRQ config http://bugzilla.kernel.org/show_bug.cgi?id=1662
  o [ACPI] parse ACPI MCFG table and set pci_mmcfg_base_addr from 2.6 via Sundar/Dely Sy
  o [ACPI] handle _CRS outside _PRS -- even when non-zero avoid sharing IRQ12 http://bugzilla.kernel.org/show_bug.cgi?id=2665

Marcelo Tosatti:
  o Delete: drivers/char/amd7xx_tco.c
  o Matt Domsch: Lower printk severity for PCI devices with no PCI_CACHE_LINE_SIZE implemented
  o Changed EXTRAVERSION to -pre3

Mike Miller:
  o cciss update: support for two new controllers
  o Fix cciss bug in proc reporting

Oleg Drokin:
  o [2.4] Make reiserfs not to crash on oom during mount

Pavel Machek:
  o Cleanups for b44

Pete Zaitcev:
  o tiglusb bug fixes (usb_clear_halt, usb_sndbulkpipe)
  o USB: Check results of copy_to_user in hiddev
  o USB: Fix memory leaks in speedtch
  o USB: Fix IBM USB memory key unusual dev entry

Richard Curnow:
  o Patch [sh64]: Fix liveness dependency constraints in _syscalln()
  o Fix Cayman PCI IRQ routing for PCI cards containing bridges
  o Patch [sh64]: Fix approach for calibrating CPU MHz so it works even if the I-cache is disabled
  o Patch [sh64]: Clean-up handling of the SR.WATCH bit
  o Patch [sh64]: Remove obsolete CONFIG_UNCACHED_MEMORY_OFFSET option
  o Patch [sh64]: clean-up to allow building on Cayman board without configuring PCI support
  o Patch [sh64]: Handle base of RAM not being 512Mb aligned
  o Patch [sh64]: Allow greater choice over the effective address at which the kernel runs

Sridhar Samudrala:
  o [SCTP] Fix bugs in handling overlapping INIT and peer restart over a multihomed association.
  o [SCTP] Rename SCTP_ADDR_REACHABLE as SCTP_ADDR_AVAILABLE to be consistent with the SCTP sockets API draft.

Stephen Hemminger:
  o SCTP crc table can be static const

Stéphane Eranian:
  o ia64: switch /proc/perfmon to seq_file avoid buffer overflows

Zwane Mwaikambo:
  o remove amd7(saucy)_tco

