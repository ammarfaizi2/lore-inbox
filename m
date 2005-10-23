Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVJWIN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVJWIN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 04:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJWIN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 04:13:27 -0400
Received: from magic.adaptec.com ([216.52.22.17]:50655 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751395AbVJWIN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 04:13:26 -0400
Subject: [PATCH] e1000 : Fixes e1000_suspend warning when CONFIG_PM is not
	enabled
From: Ashutosh Naik <ashutosh_naik@adaptec.com>
To: linux-net@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: linux.nics@intel.com
Content-Type: multipart/mixed; boundary="=-WSL2YOewf+ex5xbh7qWz"
Message-Id: <1130055202.16820.11.camel@kir9060>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 23 Oct 2005 13:43:22 +0530
X-OriginalArrivalTime: 23 Oct 2005 08:13:07.0094 (UTC) FILETIME=[99470360:01C5D7A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WSL2YOewf+ex5xbh7qWz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This Patch fixes the warning

drivers/net/e1000/e1000_main.c:3645: warning: `e1000_suspend' defined
but not used

Signed-off-by: Ashutosh Naik <ashutosh_naik@adaptec.com>

--=-WSL2YOewf+ex5xbh7qWz
Content-Disposition: attachment; filename=e1000-patch.txt
Content-Type: text/plain; name=e1000-patch.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ruNp linux-2.6.14-rc5/drivers/net/e1000/e1000_main.c linux-2.6.14-e1000-patch/drivers/net/e1000/e1000_main.c
--- linux-2.6.14-rc5/drivers/net/e1000/e1000_main.c	2005-10-23 13:06:51.000000000 +0530
+++ linux-2.6.14-e1000-patch/drivers/net/e1000/e1000_main.c	2005-10-23 13:19:32.000000000 +0530
@@ -162,8 +162,8 @@ static void e1000_vlan_rx_add_vid(struct
 static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
 
-static int e1000_suspend(struct pci_dev *pdev, pm_message_t state);
 #ifdef CONFIG_PM
+static int e1000_suspend(struct pci_dev *pdev, pm_message_t state);
 static int e1000_resume(struct pci_dev *pdev);
 #endif
 

--=-WSL2YOewf+ex5xbh7qWz--


