Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWI3WeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWI3WeG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWI3WeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:34:05 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:60545 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751555AbWI3WeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:34:00 -0400
Message-id: <827213526982173@wsc.cz>
Subject: [PATCH 2/4] Char: mxser_new, use __(dev)init macros
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Sun,  1 Oct 2006 00:33:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, use __(dev)init macros

Let kernel know what can be freed after init of the driver.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d4f99406c592fb7ce2a65645d7c1f98ebe599238
tree 8ea0e12410606352dd337bd2c7a9a30cc70d0e58
parent e3d57eae41e172fbd6195a78532f3325b2441450
author Jiri Slaby <jirislaby@gmail.com> Sat, 30 Sep 2006 00:53:58 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 30 Sep 2006 00:53:58 +0200

 drivers/char/mxser_new.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 1a6a3aa..dfef9ce 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -559,7 +559,7 @@ static void process_txrx_fifo(struct mxs
 			}
 }
 
-static int mxser_initbrd(struct mxser_board *brd)
+static int __devinit mxser_initbrd(struct mxser_board *brd)
 {
 	struct mxser_port *info;
 	unsigned int i;
@@ -617,7 +617,7 @@ static int mxser_initbrd(struct mxser_bo
 	return 0;
 }
 
-static int mxser_get_PCI_conf(int board_type, struct mxser_board *brd,
+static int __init mxser_get_PCI_conf(int board_type, struct mxser_board *brd,
 		struct pci_dev *pdev)
 {
 	unsigned int i, j;
@@ -678,7 +678,7 @@ static int mxser_get_PCI_conf(int board_
 	return 0;
 }
 
-static int mxser_init(void)
+static int __init mxser_init(void)
 {
 	struct pci_dev *pdev = NULL;
 	struct mxser_board *brd;
@@ -2918,7 +2918,7 @@ static int mxser_read_register(int, unsi
 static int mxser_program_mode(int);
 static void mxser_normal_mode(int);
 
-static int mxser_get_ISA_conf(int cap, struct mxser_board *brd)
+static int __init mxser_get_ISA_conf(int cap, struct mxser_board *brd)
 {
 	int id, i, bits;
 	unsigned short regs[16], irq;
