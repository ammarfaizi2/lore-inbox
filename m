Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUEJXDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUEJXDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUEJXAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:00:51 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:34999 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261880AbUEJW7g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:59:36 -0400
Subject: [BK PATCH] SCSI updates for 2.6.6
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 10 May 2004 17:59:31 -0500
Message-Id: <1084229974.1763.512.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest set of assorted fixes, plus one new driver: the IBM
Power Raid (ipr).

The patch can be pulled from:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

<aradford:amcc.com>:
  o 3ware driver update

<noodles:earth.li>:
  o Initio INI-9X00U/UW error handling in 2.6

<praka:users.sourceforge.net>:
  o qla2xxx set current state fixes

Alan Stern:
  o (as255) Handle Unit Attention during INQUIRY better

Andrew Morton:
  o aic7xxx deadlock fix
  o scsi_disk_release() warning fix

Andrew Vasquez:
  o qla2100 fabric fixes
  o [15/15] qla2xxx: Update driver version
  o [14/15] qla2xxx: Resync with latest released firmware -- 3.02.28
  o [13/15] qla2xxx: Misc. code scrubbing
  o [12/15] qla2xxx: RIO/ZIO fixes
  o [11/15] qla2xxx: /proc fixes
  o [10/15] qla2xxx: Use readX_relaxed
  o [9/15]  qla2xxx: Tape command handling fixes
  o [8/15]  qla2xxx: Volatile topology fixes
  o [7/15]  qla2xxx: Firmware options fixes
  o [6/15]  qla2xxx: LoopID downcast fix
  o [5/15]  qla2xxx: Debug messages during ISP abort
  o [4/15]  qla2xxx: PortID binding fixes
  o [3/15]  qla2xxx: 2100 request-q contraints
  o [2/15]  qla2xxx: Remove flash routines
  o [1/15]  qla2xxx: Firmware dump fixes

Aristeu Sergio Rozanski Filho:
  o qlogic_cs: use qlogicfas408 module
  o qlogicfas: split and create a new module
  o qlogicfas: kill horrible irq probing

Bob Tracy:
  o sym53c500_cs remove irq,ioport scsi attributes
  o sym53c500_cs PCMCIA SCSI driver (round 5)

Brian King:
  o Add IBM power RAID driver 2.0.6
  o Make SCSI timeout modifiable

Chris Wright:
  o Update aacraid MAINTAINERS entry

Christoph Hellwig:
  o mca_53c9x needs CONFIG_MCA_LEGACY
  o missing pci_set_master in megaraid
  o imm/ppa style police

Eric Dean Moore:
  o MPT Fusion driver 3.01.06 update
  o MPT Fusion add back FC909 support

Herbert Xu:
  o aic7xxx: fix oops whe hardware is not present

James Bottomley:
  o fix LLD module refcounting in sr.c
  o Add SCSI IPR PCI Ids to pci_ids.h
  o Fix errors in [PATCH] aic7xxx: fix oops whe hardware is not present
  o Cset exclude: jejb@mulgrave.(none)|ChangeSet|20040404150128|05866
  o aic7xxx: compile fix for EISA only case

Jeremy Higdon:
  o minor changes to qla1280 driver

Kai Mäkisara:
  o SCSI tape log message fixes

Kurt Garloff:
  o scsi: don't attach device if PQ indicates not connected

Mark Haverkamp:
  o aacraid reset handler fix

Michael Veeck:
  o (3/5) ncr53c8x: use kernel.h min/max
  o (4/5) nsp32 (ninja): use kernel.h min/max/ARRAY_SIZE
  o (2/5) aic7xyz_old: use kernel.h min/max/ARRAY_SIZE
  o (5/5) pcmcia/nsp: use kernel.h min/max/ARRAY_SIZE

Mike Anderson:
  o fix module unload problem in sd

Pavel Machek:
  o support swsusp for aic7xxx

James


