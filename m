Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWJVA46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWJVA46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWJVA46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:56:58 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:58782 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422891AbWJVA4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:56:55 -0400
Message-id: <2472126109220008551@wsc.cz>
Subject: [PATCH 3/5] Char: sx, mark functions as devinit
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: <support@specialix.co.uk>
Date: Sun, 22 Oct 2006 02:56:55 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, mark functions as devinit

Mark as much as possible functions as __devinit to free them after driver
initialization (if no hotplug).

Cc: <R.E.Wolff@BitWizard.nl>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 2203651d857aafeb50b4b16de1a1805d796598bb
tree 0eb5e4fbe14eefaed70d80c5c3c562107d4ee75b
parent 52aaf84368d81de72e1c4a69756b10ec744fbeab
author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:59:22 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:59:22 +0200

 drivers/char/sx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index be6fff2..8c845fc 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2034,7 +2034,7 @@ #endif
 }
 
 
-static void printheader(void)
+static void __devinit printheader(void)
 {
 	static int header_printed;
 
@@ -2047,7 +2047,7 @@ static void printheader(void)
 }
 
 
-static int probe_sx (struct sx_board *board)
+static int __devinit probe_sx (struct sx_board *board)
 {
 	struct vpd_prom vpdp;
 	char *p;
@@ -2125,7 +2125,7 @@ static int probe_sx (struct sx_board *bo
    card. 0xe0000 and 0xf0000 are taken by the BIOS. That only leaves 
    0xc0000, 0xc8000, 0xd0000 and 0xd8000 . */
 
-static int probe_si (struct sx_board *board)
+static int __devinit probe_si (struct sx_board *board)
 {
 	int i;
 
@@ -2364,7 +2364,7 @@ static void __exit sx_release_drivers(vo
    EEprom.  As the bit is read/write for the CPU, we can fix it here,
    if we detect that it isn't set correctly. -- REW */
 
-static void fix_sx_pci (struct pci_dev *pdev, struct sx_board *board)
+static void __devinit fix_sx_pci(struct pci_dev *pdev, struct sx_board *board)
 {
 	unsigned int hwbase;
 	void __iomem *rebase;
