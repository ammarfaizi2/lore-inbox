Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261974AbSJFRQr>; Sun, 6 Oct 2002 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbSJFRPx>; Sun, 6 Oct 2002 13:15:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261722AbSJFROm>; Sun, 6 Oct 2002 13:14:42 -0400
Subject: PATCH: 2.5.40 Fix cs89x0 warnings
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       jgarzik@mandrakesoft.com
Date: Sun, 6 Oct 2002 18:11:30 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEwE-0001sF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/net/cs89x0.c linux.2.5.40-ac5/drivers/net/cs89x0.c
--- linux.2.5.40/drivers/net/cs89x0.c	2002-10-02 21:33:29.000000000 +0100
+++ linux.2.5.40-ac5/drivers/net/cs89x0.c	2002-10-06 00:27:50.000000000 +0100
@@ -1649,11 +1649,7 @@
 
 #ifdef MODULE
 
-static struct net_device dev_cs89x0 = {
-        "",
-        0, 0, 0, 0,
-        0, 0,
-        0, 0, 0, NULL, NULL };
+static struct net_device dev_cs89x0;
 
 /*
  * Support the 'debug' module parm even if we're compiled for non-debug to 
