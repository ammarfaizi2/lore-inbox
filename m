Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVCIUBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVCIUBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVCIUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:00:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4065 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261168AbVCIT4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:56:53 -0500
Date: Wed, 9 Mar 2005 12:39:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-pre3
Message-ID: <20050309153900.GF15690@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the third pre of v2.4.30.


It contains a small number of scattered fixes, most notably e1000 update, 
a backport of v2.6's nForce override fix, and SATA update. 

The changes which broke "tar --verify" on tapes have been reverted.

Please read the changelog for more details.


Summary of changes from v2.4.30-pre2 to v2.4.30-pre3
============================================

<davem:northbeach.davemloft.net.davemloft.net>:
  o [SPARC64]: Tomatillo PCI controller bug fixes
  o [TIGON3]: Do not touch NIC_SRAM_FIRMWARE_MBOX when TG3_FLG2_SUN_570X
  o [TIGON3]: Update driver version and reldate

<hifumi.hisashi:lab.ntt.co.jp>:
  o BUG on error handlings in Ext3 under I/O

<krzysztof.h1:wp.pl>:
  o [SPARC]: DBRI fixes and improvements

<liml:rtr.ca>:
  o sata_qstor: eh_timeout fix

<mallikarjuna.chilakala:intel.com>:
  o e1000: 1 Robert Olsson's fix and
  o e1000: 2 use netif_poll_{enable|disable}
  o e1000: Avoid race between e1000_watchdog
  o e1000: Delay clean-up of last Tx buffer
  o e1000: Fix WOL settings in 82544 based
  o e1000: Patch from Peter Kjellstroem --
  o e1000: Checks for desc ring/rx data
  o e1000: Report failure code when loopback
  o e1000: Fixes related to Cable length
  o e1000: Driver version white space,

<mat.loikkanen:synopsys.com>:
  o [libata] add ->bmdma_{stop,status} hooks

<phil:fifi.org>:
  o sk98lin workaround Asus K8V SE Deluxe buggy firmware

<slee:netengine1.com>:
  o Fix units/partition count in sd.c

Adrian Bunk:
  o drivers/scsi/sata_*: make code static

David S. Miller:
  o [SPARC64]: Fix 32bit compat layer bugs in sys_ipc() and sys_rt_sigtimedwait()
  o [AF_UNIX]: Fix SIOCINQ for STREAM
  o [SPARC64]: Accept 'm5823' clock chip as seen on SB1500

Jeff Garzik:
  o [libata sata_via] minor cleanups
  o [libata sata_via] add support for VT6421 SATA
  o [libata] resync with 2.6 msleep() updates
  o [libata] trivial: whitespace sync with 2.6
  o [libata] do not call pci_disable_device() for certain errors
  o [libata] Add missing hooks, to avoid oops in advanced SATA drivers
  o [libata] Use DMA_{32,64}BIT_MASK in ahci, sata_vsc drivers
  o [libata ahci] Print out port id on error messages
  o [libata] remove_one helper cleanup

John W. Linville:
  o libata: fix command queue leak when xlat_func fails
  o tulip: make tulip_stop_rxtx() wait for DMA to fully stop

Marcelo Tosatti:
  o Cset exclude: solar@openwall.com|ChangeSet|20041125155150|65356
  o Allow lseek on SCSI tapes
  o Allow lseek on osst to keep tar --verify happy
  o Change VERSION to 2.4.30-pre3
  o Early ACPI PCI quirk depends on CONFIG_X86_IO_APIC

Mark Lord:
  o sata_qstor: new basic driver for Pacific Digital
  o [libata qstor] minor update per LKML comments

Matt Domsch:
  o aic7xxx: don't reset chip on pause

Mikael Pettersson:
  o fix undefined behaviour in cistpl.c

Paul Fulghum:
  o fix synclinkmp register access typo

Solar Designer:
  o Fix for swapoff after re-creating device files
  o Fix proc_tty.c comment typos

Zwane Mwaikambo:
  o Fix timer override on nforce

