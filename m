Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUFCCXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUFCCXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUFCCXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:23:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64972 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265454AbUFCCXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:23:46 -0400
Date: Wed, 2 Jun 2004 23:24:33 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-pre5
Message-ID: <20040603022432.GA6039@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes -pre5.

This time we have merges from Jeff's -netdrivers tree, David's -net tree, 
including a fix for compilation error without CONFIG_SCTP set, SPARC64 update,
i810_audio fixes, amongst others.


Summary of changes from v2.4.27-pre4 to v2.4.27-pre5
============================================

<chrisg:etnus.com>:
  o x86-64 only: ia32entry.S reg changes dropped during debugging

<kevin.curtis:farsite.co.uk>:
  o [netdrvr wan] farsync update

<pelle:dsv.su.se>:
  o tulip PCI ID for D-Link DFE-680TXD

<vda:port.imtp.ilyichevsk.odessa.ua>:
  o fealnx #0: replace dev->base_addr with ioaddr; sync with 2.6
  o fealnx #1: replace magic constants with enums
  o fealnx #2: add 'static'; fix wrapped comment
  o fealnx #3: fix pointer substraction bug
  o fealnx #4: stop doing stop_nic_rx/writel(np->crvalue) in rest_rx_descriptors()
  o fealnx #5: introduce stop_nic_rxtx(), use it where makes sense
  o fealnx #6: Francois' fixes for low memory handling; remove free_one_rx_descriptor (not used anymore)
  o fealnx #7: Garzik fix (IIRC): add locking to tx_timeout
  o fealnx #8
  o fealnx #9
  o fealnx #10
  o fealnx #11

Andrew Morton:
  o 8139too not running s3 suspend/resume pci fix

Arjan van de Ven:
  o small change for scsi 2.6 header compatibility
  o [libata] Use standard headers from include/scsi, not drivers/scsi

Daniele Venzano:
  o [netdrvr sis900] fix ISA bridge detection
  o [netdrvr sis900] cosmetic header cleanups
  o [netdrvr sis900] fix missing netif_device_detach() in suspend

David S. Miller:
  o [TCP]: Fix build in 2.4.x with SCTP disabled
  o [PKT_SCHED]: Missing rta_len init in sch_delay
  o [SPARC64]: gcc-3.4.x build fixes

Don Fry:
  o 2.4.27-pre3 pcnet32 add static to two routines
  o 2.4.27-pre3 pcnet32 avoid hard hang with some chip variants
  o 2.4.27-pre3 pcnet32 correct 79C976 variant string
  o 2.4.27-pre3 pcnet32 fix boundary comparison bug
  o 2.4.27-pre3 pcnet32 remove timer and complexity
  o pcnet32: limit frames received during interrupt
  o pcnet32: fix bogus carrier errors with 79c973
  o pcnet32: correct printk for big-endian arch
  o pcnet32: avoid timeout with tcpdump
  o pcnet32: fix for patch 8 le16_to_cpu

François Romieu:
  o [netdrvr r8169] update to 2.6.x version; many fixes and changes

Ganesh Venkatesan:
  o e1000 1/7: Clear auto-mdix mode when forcing link to
  o e1000 2/7: Workaround for link LED staying ON even when
  o e1000 3/7: Determine Link Status correctly while using
  o e1000 4/7: Rewrite logic to estimate # of tx descriptors
  o e1000 6/7: ethtool_ops support
  o e1000 7/7: Error Logging support (enabled/disabled via
  o e100 1/1: Update to sync up version numbers

Jeff Garzik:
  o [sound i810] pci id cleanups
  o [libata] add new ->bmdma_setup hook
  o [libata] use new ->bmdma_{start,setup} method to properly support ATAPI
  o [libata] more ATAPI work - translate SCSI CDB to ATA PACKET
  o [libata] random minor bug fixes
  o [libata] kill ATA_QCFLAG_POLL flag
  o [libata] internal cleanups
  o [libata] minor stuff
  o [libata] handle non-data ATAPI commands via interrupt
  o [libata] DMADIR support
  o [libata] remove redundant use of ATA_QCFLAG_SG in ATAPI packet translation
  o [libata] SCSI->ATA simulator hacking: INQUIRY command
  o [libata] comments and constants
  o [libata] scsi simulator improvements: MODE SENSE, SEEK(6,10), REZERO_UNIT
  o [libata] replace ATA_QCFLAG_ATAPI with inline helper
  o [libata] polish DocBook docs a bit
  o [netdrvr sis900] sync with 2.6.x
  o [netdrvr e1000] use generic ethtool_ops provided in net/core/ethtool.c
  o [libata promise] revert broken taskfile delivery change
  o [libata scsi] ack SYNCHRONIZE CACHE command

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre5

Patrick McHardy:
  o [IPV4,6]: Fix off-by-one in max protocol-type check

Stefan Rompf:
  o [netdrvr b44] always restore PCI config on resume

