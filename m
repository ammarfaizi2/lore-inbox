Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270400AbTGSOwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 10:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270402AbTGSOwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 10:52:49 -0400
Received: from a3hr6fay45cl.bc.hsia.telus.net ([216.232.206.119]:21255 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S270400AbTGSOwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 10:52:35 -0400
Date: Sat, 19 Jul 2003 08:07:29 -0700
From: John Wong <kernel@implode.net>
To: linux-kernel@vger.kernel.org
Subject: DMA timeouts with 2.4.22-pre6
Message-ID: <20030719150728.GA265@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having dma timeouts with my Maxtor 6Y120P0.  It is connected as the
slave on the primary channel of the nVidia nForce2 based Asus A7N8X DX.

I did not have this problem with 2.4.21.  On the 2.4.22-pre series, I
have encountered this problem in pre4, pre5, and pre6.  I did not try 
earlier pre's.  In the pre2 -> pre3 change log, there was a mention of 
fix ide dma timeout bugs.  I am wondering if this fix is causing my newly
experienced problems.

gambit:/root# hdparm /dev/hdb

/dev/hdb:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 14946/255/63, sectors = 240121728, start = 0


Jul 11 18:59:26 gambit kernel: hdb: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jul 11 18:59:26 gambit kernel: hdb: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=98468, sector=98405
Jul 11 18:59:26 gambit kernel: end_request: I/O error, dev 03:41 (hdb),
sector 98405
Jul 11 18:59:36 gambit kernel: hdb: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jul 11 18:59:36 gambit kernel: hdb: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=98470, sector=98407
Jul 11 18:59:36 gambit kernel: end_request: I/O error, dev 03:41 (hdb),
sector 98407
Jul 11 18:59:42 gambit kernel: hdb: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jul 11 18:59:42 gambit kernel: hdb: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=98471, sector=98408
Jul 11 18:59:42 gambit kernel: end_request: I/O error, dev 03:41 (hdb),
sector 98408

John
