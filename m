Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271635AbRHUK3L>; Tue, 21 Aug 2001 06:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271636AbRHUK3B>; Tue, 21 Aug 2001 06:29:01 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:16903 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S271635AbRHUK2v>;
	Tue, 21 Aug 2001 06:28:51 -0400
Date: Tue, 21 Aug 2001 12:35:58 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.2.19 - add TEAC PD/CD handling for PD disks
Message-ID: <Pine.LNX.4.21.0108211229010.682-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I am using the following one-line patch to be able to use PD disks
in my TEAC PD/CD drive, without CONFIG_SCSI_MULTI_LUN.
Could you please consider applying this for 2.2.20?

Best regards,

Wojtek

--- linux-2.2.19/drivers/scsi/scsi.c.teac	Sun Mar 25 18:31:31 2001
+++ linux-2.2.19/drivers/scsi/scsi.c	Tue Aug 21 12:10:33 2001
@@ -307,6 +307,7 @@
 {"COMPAQ","LOGICAL VOLUME","*", BLIST_FORCELUN},
 {"NEC","PD-1 ODX654P","*", BLIST_FORCELUN | BLIST_SINGLELUN},
 {"MATSHITA","PD-1","*", BLIST_FORCELUN | BLIST_SINGLELUN},
+{"TEAC","PD-1","*", BLIST_FORCELUN | BLIST_SINGLELUN},
 {"iomega","jaz 1GB","J.86", BLIST_NOTQ | BLIST_NOLUN},
 {"TOSHIBA","CDROM","*", BLIST_ISROM},
 {"MegaRAID", "LD", "*", BLIST_FORCELUN},     /* Multiple luns always safe (logical raid vols) */

