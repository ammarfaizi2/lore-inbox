Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVAJCyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVAJCyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVAJCyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:54:51 -0500
Received: from news.suse.de ([195.135.220.2]:13251 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262054AbVAJCyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:54:46 -0500
Date: Mon, 10 Jan 2005 03:54:46 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix gcc 4 compilation in drivers/eisa
Message-ID: <20050110025446.GA6880@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Drop bogus -Werror to allow compilation with gcc 4

Signed-off-by: Andi Kleen <ak@suse.de>


Index: linux/drivers/eisa/Makefile
===================================================================
--- linux.orig/drivers/eisa/Makefile	2004-03-21 21:11:50.%N +0100
+++ linux/drivers/eisa/Makefile	2005-01-09 18:51:02.%N +0100
@@ -1,8 +1,5 @@
 # Makefile for the Linux device tree
 
-# Being anal sometimes saves a crash/reboot cycle... ;-)
-EXTRA_CFLAGS    := -Werror
-
 obj-$(CONFIG_EISA)	        += eisa-bus.o
 obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
 
