Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWAUMqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWAUMqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWAUMqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:46:38 -0500
Received: from mail.gmx.net ([213.165.64.21]:15071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932179AbWAUMqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:46:37 -0500
X-Authenticated: #6864226
From: Gerrit =?iso-8859-1?q?Bruchh=E4user?= <gbruchhaeuser@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: AHA-7850 doesn't detect scanner anymore
Date: Sat, 21 Jan 2006 13:46:34 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601211346.34426.gbruchhaeuser@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
my old "HP ScanJet IIc" used to work so perfectly but now the kernel can only 
see something at SCSI-ID 1, but is not able to detect the device properly :-(

These are the 'kernel.log' entries after I switched on 'options aic7xxx 
aic7xxx=verbose,periodic_otag' in modules.conf file :

| Jan 21 13:17:18 gbpc PCI: Enabling device 0000:00:0d.0 (0116 -> 0117)
| Jan 21 13:17:18 gbpc ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, 
low) -> IRQ 185
| Jan 21 13:17:18 gbpc ahc_pci:0:13:0: hardware scb 64 bytes; kernel scb 52 
bytes; ahc_dma 8 bytes
| Jan 21 13:17:18 gbpc ahc_pci:0:13:0: Host Adapter Bios disabled.  Using 
default SCSI device parameters
| Jan 21 13:17:18 gbpc scsi12 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, 
Rev 7.0
| Jan 21 13:17:18 gbpc <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
| Jan 21 13:17:18 gbpc aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
| Jan 21 13:17:18 gbpc
| Jan 21 13:17:33 gbpc (scsi12:A:0:0): Saw Selection Timeout for SCB 0x3
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): SCB 2: requests Check Status
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Sending Sense
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): SCB 3: requests Check Status
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Sending Sense
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): SCB 2: requests Check Status
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): Sending Sense
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:35 gbpc (scsi12:A:2:0): Saw Selection Timeout for SCB 0x3
| Jan 21 13:17:35 gbpc (scsi12:A:3:0): Saw Selection Timeout for SCB 0x2
| Jan 21 13:17:36 gbpc (scsi12:A:4:0): Saw Selection Timeout for SCB 0x3
| Jan 21 13:17:36 gbpc (scsi12:A:5:0): Saw Selection Timeout for SCB 0x2
| Jan 21 13:17:36 gbpc (scsi12:A:6:0): Saw Selection Timeout for SCB 0x3


The SCSI-terminator is properly attached to the scanner and the wires are okay 
as well. Is there a way to find-out more what actually causes the problem?

As I am not subscribed to the list, please when you answer, put my mail 
address to CC

Many thanks in advance,
Gerrit
