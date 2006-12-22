Return-Path: <linux-kernel-owner+w=401wt.eu-S1753186AbWLVWut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbWLVWut (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 17:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbWLVWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 17:50:49 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:41710 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbWLVWus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 17:50:48 -0500
Message-id: <2547431671200824742@wsc.cz>
In-reply-to: <2548619677109123490@wsc.cz>
Subject: [PATCH 2/3] Char: mxser_new, mark init functions
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 22 Dec 2006 23:51:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, mark init functions

Mark some funcions with __init and __devinit.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 04a4dbf03a9fdc4c53282ab7e1db146389140c3b
tree 916cdef3d0f3acb58de8b96db6e83c11c3f0613c
parent e3a36e41f423af467a95221598fd5754a8fb4032
author Jiri Slaby <jirislaby@gmail.com> Fri, 22 Dec 2006 22:56:33 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 22 Dec 2006 22:56:33 +0059

 drivers/char/mxser_new.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 1bb030b..2f173e9 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -316,7 +316,7 @@ static int mxser_set_baud_method[MXSER_PORTS + 1];
 static spinlock_t gm_lock;
 
 #ifdef CONFIG_PCI
-static int CheckIsMoxaMust(int io)
+static int __devinit CheckIsMoxaMust(int io)
 {
 	u8 oldmcr, hwid;
 	int i;
@@ -1373,7 +1373,7 @@ static int mxser_tiocmset(struct tty_struct *tty, struct file *file,
 	return 0;
 }
 
-static int mxser_program_mode(int port)
+static int __init mxser_program_mode(int port)
 {
 	int id, i, j, n;
 
@@ -1410,7 +1410,7 @@ static int mxser_program_mode(int port)
 	return id;
 }
 
-static void mxser_normal_mode(int port)
+static void __init mxser_normal_mode(int port)
 {
 	int i, n;
 
@@ -1443,7 +1443,7 @@ static void mxser_normal_mode(int port)
 #define EN0_PORT	0x010	/* Rcv missed frame error counter RD */
 #define ENC_PAGE0	0x000	/* Select page 0 of chip registers   */
 #define ENC_PAGE3	0x0C0	/* Select page 3 of chip registers   */
-static int mxser_read_register(int port, unsigned short *regs)
+static int __init mxser_read_register(int port, unsigned short *regs)
 {
 	int i, k, value, id;
 	unsigned int j;
