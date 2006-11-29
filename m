Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966653AbWK2KFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966653AbWK2KFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758815AbWK2KE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:04:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2569 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758816AbWK2KEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:04:12 -0500
Date: Wed, 29 Nov 2006 11:04:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove drivers/char/riscom8.c:baud_table[]
Message-ID: <20061129100417.GK11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c7bce3097c0f9bbed76ee6fd03742f2624031a45 removed all usages of 
baud_table[] but not the array itself.

Spotted by the GNU C compiler.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/drivers/char/riscom8.c.old	2006-11-29 09:55:13.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/char/riscom8.c	2006-11-29 09:55:23.000000000 +0100
@@ -82,11 +82,6 @@
 static struct riscom_board * IRQ_to_board[16];
 static struct tty_driver *riscom_driver;
 
-static unsigned long baud_table[] =  {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 76800, 0, 
-};
-
 static struct riscom_board rc_board[RC_NBOARD] =  {
 	{
 		.base	= RC_IOBASE1,

