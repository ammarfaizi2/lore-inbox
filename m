Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUJDMZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUJDMZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUJDMZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:25:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4655 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267356AbUJDMZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:25:41 -0400
Date: Mon, 4 Oct 2004 13:25:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3c59x: VORTEX select MII
Message-ID: <Pine.LNX.4.44.0410041321470.2623-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3c59x now uses generic_mii_ioctl, so VORTEX should select MII.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.9-rc3-mm2/drivers/net/Kconfig	2004-10-04 11:59:59.000000000 +0100
+++ linux/drivers/net/Kconfig	2004-10-04 13:10:05.000000000 +0100
@@ -691,6 +691,7 @@ config ELMC_II
 config VORTEX
 	tristate "3c590/3c900 series (592/595/597) \"Vortex/Boomerang\" support"
 	depends on NET_VENDOR_3COM && (PCI || EISA)
+	select MII
 	---help---
 	  This option enables driver support for a large number of 10mbps and
 	  10/100mbps EISA, PCI and PCMCIA 3Com network cards:

