Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVJSBc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVJSBc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbVJSBc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:32:56 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:29715 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751469AbVJSBcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:32:53 -0400
Date: Tue, 18 Oct 2005 21:31:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, shemminger@osdl.org, mlindner@syskonnect.de,
       rroesler@syskonnect.de
Subject: [patch 2.6.14-rc4 1/3] sk98lin: remove MODULE_DEVICE_TABLE to avoid conflicts w/ skge
Message-ID: <10182005213100.12360@bilbo.tuxdriver.com>
In-Reply-To: <10182005213059.12304@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The skge driver claims support for the identical list of hardware
supported by the in-kernel sk98lin driver.  This can confuse userland
tools which pick modules based on the PCI ID lists exported through
MODULE_DEVICE_TABLE.

This patch removes the MODULE_DEVICE_TABLE line from sk98lin.  The
driver can still be loaded manually if necessary or desireable.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/sk98lin/skge.c |    2 --
 1 files changed, 2 deletions(-)

diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -5227,8 +5227,6 @@ static struct pci_device_id skge_pci_tbl
 	{ 0 }
 };
 
-MODULE_DEVICE_TABLE(pci, skge_pci_tbl);
-
 static struct pci_driver skge_driver = {
 	.name		= "sk98lin",
 	.id_table	= skge_pci_tbl,
