Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbUBLNsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbUBLNsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:48:42 -0500
Received: from dns.systeam.it ([151.99.251.226]:9231 "EHLO systeam.it")
	by vger.kernel.org with ESMTP id S266422AbUBLNsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:48:36 -0500
Date: Thu, 12 Feb 2004 14:51:51 +0100
From: "Giuseppe Furlan" <giuseppe.furlan@systeam.it>
To: linux-kernel@vger.kernel.org
CC: "kernel" <linux-kernel@vger.kernel.org>
Subject: scsi patch for Hitachi 9960 Storage
Message-ID: <WorldClient-F200402121451.AA51510092@systeam.it>
X-Mailer: WorldClient 6.8.5
X-Authenticated-Sender: giuseppe.furlan@systeam.it
X-Spam-Processed: systeam.it, Thu, 12 Feb 2004 14:51:52 +0100
	(not processed: message from valid local sender)
X-MDRemoteIP: 10.5.0.15
X-Return-Path: giuseppe.furlan@systeam.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My configuration : 
Sun Fire V65x with LP9002L-E Emulex 
Hitachi 9960 Storage (scsi-2 protocol)
Inrage FC switch (Fabric) 

Kernel Version:
Linux 2.4.21-4.ELcustom #5 SMP 

My problem:
I cannot see luns > 8(0-7) 
This patch resolves problems regarding LUN visibility using Hitachi 9960
Storage.

Patch:

--- linux-2.4.21-4.EL/drivers/scsi/scsi_scan.c  2003-10-03
23:28:53.000000000 +0200
+++ linux-2.4.21-4.EL-old/drivers/scsi/scsi_scan.c      2004-02-12
13:00:49.000000000 +0100
@@ -186,6 +186,7 @@
        {"HITACHI", "DF600", "*", BLIST_SPARSELUN},
        {"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
        {"HITACHI", "OPEN-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},  /*
HITACHI XP Arrays */
+       {"HITACHI", "DISK-SUBSYSTEM", "*", BLIST_SPARSELUN |
BLIST_LARGELUN},  /* HITACHI 9960 */
        {"WINSYS","FLASHDISK", "*", BLIST_SPARSELUN},
        {"WINSYS","Flashdisk", "*", BLIST_SPARSELUN},
        {"DotHill","SANnet", "*", BLIST_SPARSELUN},


bye all
Giuseppe

