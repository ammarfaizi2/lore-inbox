Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSICUwL>; Tue, 3 Sep 2002 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSICUwL>; Tue, 3 Sep 2002 16:52:11 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:51922 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S318917AbSICUwK>; Tue, 3 Sep 2002 16:52:10 -0400
Date: Tue, 3 Sep 2002 16:56:45 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] drivers/scsi/scsi_scan.c, kernel 2.4.20-pre5
Message-ID: <Pine.LNX.4.44.0209031648170.18923-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch against the 2.4.20-pre5 code to add BLIST_LARGELUN support
to the HP OPEN- devices in drivers/scsi/scsi_scan.c

diff -Naur drivers/scsi/scsi_scan.c.orig drivers/scsi/scsi_scan.c
--- drivers/scsi/scsi_scan.c.orig	Tue Sep  3 16:51:49 2002
+++ drivers/scsi/scsi_scan.c	Tue Sep  3 16:51:57 2002
@@ -113,7 +113,6 @@
 	{"HP", "A6188A", "*", BLIST_SPARSELUN},			/* HP Va7100 Array */
 	{"HP", "A6189A", "*", BLIST_SPARSELUN},			/* HP Va7400 Array */
 	{"HP", "A6189B", "*", BLIST_SPARSELUN},			/* HP Va7410 Array */
-	{"HP", "OPEN-", "*", BLIST_SPARSELUN},			/* HP XP Arrays */
 	{"YAMAHA", "CDR100", "1.00", BLIST_NOLUN},		/* Locks up if polled for lun != 0 */
 	{"YAMAHA", "CDR102", "1.00", BLIST_NOLUN},		/* Locks up if polled for lun != 0
 								 * extra reset */
@@ -163,6 +162,7 @@
 	{"DELL", "PV530F",    "*", BLIST_SPARSELUN | BLIST_LARGELUN}, // Dell PV 530F
 	{"EMC", "SYMMETRIX", "*", BLIST_SPARSELUN | BLIST_LARGELUN | BLIST_FORCELUN},
 	{"HP", "A6189A", "*", BLIST_SPARSELUN |  BLIST_LARGELUN}, // HP VA7400, by Alar Aun
+	{"HP", "OPEN-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},	/* HP XP Arrays */
 	{"CMD", "CRA-7280", "*", BLIST_SPARSELUN | BLIST_LARGELUN},   // CMD RAID Controller
 	{"CNSI", "G7324", "*", BLIST_SPARSELUN | BLIST_LARGELUN},     // Chaparral G7324 RAID
 	{"CNSi", "G8324", "*", BLIST_SPARSELUN},     // Chaparral G8324 RAID



Thanks.



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF




