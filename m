Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUJQPEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUJQPEW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJQPEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:04:22 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:30989 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269160AbUJQPEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:04:06 -0400
Date: Sun, 17 Oct 2004 11:05:11 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: akpm@osdl.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [patch 2.6.9-rc2] 3c59x: remove EEPROM_RESET for 3c905B
Message-ID: <20041017150511.GC13491@tuxdriver.com>
Mail-Followup-To: akpm@osdl.org, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040928145455.C12480@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928145455.C12480@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the EEPROM_RESET flag for the 3c905B cards.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Looks like I over-reached.  Apparently only the 3c905 cards actually
need the EEPROM reset, and the 3c905B cards don't like it...

 drivers/net/3c59x.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6/drivers/net/3c59x.c.orig	2004-10-17 10:53:38.142281232 -0400
+++ linux-2.6/drivers/net/3c59x.c	2004-10-17 10:54:25.975009552 -0400
@@ -508,12 +508,12 @@ static struct vortex_chip_info {
 	{"3c905 Boomerang 100baseT4",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII|EEPROM_RESET, 64, },
 	{"3c905B Cyclone 100baseTx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE|EEPROM_RESET, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 
 	{"3c905B Cyclone 10/100/BNC",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EEPROM_RESET, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c905B-FX Cyclone 100baseFx",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM|EEPROM_RESET, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
 	{"3c905C Tornado",
 	PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 	{"3c920B-EMB-WNM (ATI Radeon 9100 IGP)",
@@ -564,7 +564,7 @@ static struct vortex_chip_info {
 	{"3c982 Hydra Dual Port B",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_HWCKSM|HAS_NWAY, 128, },
 	{"3c905B-T4",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE|EEPROM_RESET, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM|EXTRA_PREAMBLE, 128, },
 	{"3c920B-EMB-WNM Tornado",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 
-- 
John W. Linville
linville@tuxdriver.com
