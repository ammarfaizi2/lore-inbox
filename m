Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVBSIg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVBSIg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVBSIg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:36:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9742 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261631AbVBSIgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:36:20 -0500
Date: Sat, 19 Feb 2005 09:36:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davem@davemloft.net
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/sunhme.c: make a struct static
Message-ID: <20050219083618.GO4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/sunhme.c.old	2005-02-16 18:48:13.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/sunhme.c	2005-02-16 19:04:48.000000000 +0100
@@ -175,13 +175,13 @@
 #define DEFAULT_IPG2       4 /* For all modes */
 #define DEFAULT_JAMSIZE    4 /* Toe jam */
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) && defined(MODULE)
 /* This happy_pci_ids is declared __initdata because it is only used
    as an advisory to depmod.  If this is ported to the new PCI interface
    where it could be referenced at any time due to hot plugging,
    the __initdata reference should be removed. */
 
-struct pci_device_id happymeal_pci_ids[] = {
+static struct pci_device_id happymeal_pci_ids[] = {
 	{
 	  .vendor	= PCI_VENDOR_ID_SUN,
 	  .device	= PCI_DEVICE_ID_SUN_HAPPYMEAL,

