Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbUAEB06 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUAEB06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:26:58 -0500
Received: from cpe-68-118-249-48.ma.charter.com ([68.118.249.48]:12038 "EHLO
	clu01.photonlinux.com") by vger.kernel.org with ESMTP
	id S265838AbUAEB04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:26:56 -0500
Date: Sun, 4 Jan 2004 22:42:08 -0500 (EST)
From: online@clu01.photonlinux.com
To: linux-kernel@vger.kernel.org
Subject: Patch for scsi_scan.c Kernel Version 2.4.23
Message-ID: <Pine.LNX.4.44.0401042239510.7754-100000@clu01.photonlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a patch for scsi_scan.c to enable the proper scanning of tape
devices behind a Compaq fibre channel FCTC II tape controller.
I have tested this exhaustively using a Compaq FCTC and a Surestore DLT
80.

This patch should work for older versions of the 2.4 Kernel and version
2.6.

Thanks
Laurence Oberman
online@photonlinux.com or Laurence.Oberman@hp.com
--------------------------

Patch Notes:

This patch will allow the proper scanning and attachment of tape devices
which are located behind a Compaq F/C bridge FCTC II. If the firmware is
upgraded, the text will need to be changed to match accordingly as per
Model.

--- scsi_scan.c	2004-01-04 18:34:57.000000000 -0500
+++ scsi_scan.c.orig	2004-01-04 18:33:54.000000000 -0500
@@ -151,7 +151,7 @@
 	{"DEC","HSG80","*", BLIST_FORCELUN | BLIST_NOSTARTONADD},
 	{"COMPAQ","LOGICAL VOLUME","*", BLIST_FORCELUN},
 	{"COMPAQ","CR3500","*", BLIST_FORCELUN},
-	{"COMPAQ","FCTC c9913a","*", BLIST_FORCELUN | BLIST_SPARSELUN |
BLIST_LARGELUN},
+
 	{"NEC", "PD-1 ODX654P", "*", BLIST_FORCELUN | BLIST_SINGLELUN},
 	{"MATSHITA", "PD-1", "*", BLIST_FORCELUN | BLIST_SINGLELUN},
 	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},


