Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVKTXX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVKTXX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVKTXX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:23:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42512 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932118AbVKTXX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:23:58 -0500
Date: Mon, 21 Nov 2005 00:23:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/sbus/char/aurora.c: "extern inline" -> "static inline"
Message-ID: <20051120232358.GJ16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/sbus/char/aurora.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/sbus/char/aurora.c.old	2005-11-20 19:50:47.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/sbus/char/aurora.c	2005-11-20 19:50:32.000000000 +0100
@@ -124,25 +124,25 @@
  */
 
 /* Get board number from pointer */
-extern inline int board_No (struct Aurora_board const * bp)
+static inline int board_No (struct Aurora_board const * bp)
 {
 	return bp - aurora_board;
 }
 
 /* Get port number from pointer */
-extern inline int port_No (struct Aurora_port const * port)
+static inline int port_No (struct Aurora_port const * port)
 {
 	return AURORA_PORT(port - aurora_port); 
 }
 
 /* Get pointer to board from pointer to port */
-extern inline struct Aurora_board * port_Board(struct Aurora_port const * port)
+static inline struct Aurora_board * port_Board(struct Aurora_port const * port)
 {
 	return &aurora_board[AURORA_BOARD(port - aurora_port)];
 }
 
 /* Wait for Channel Command Register ready */
-extern inline void aurora_wait_CCR(struct aurora_reg128 * r)
+static inline void aurora_wait_CCR(struct aurora_reg128 * r)
 {
 	unsigned long delay;
 
@@ -161,7 +161,7 @@
  */
 
 /* Must be called with enabled interrupts */
-extern inline void aurora_long_delay(unsigned long delay)
+static inline void aurora_long_delay(unsigned long delay)
 {
 	unsigned long i;
 
@@ -420,7 +420,7 @@
 	sbus_iounmap((unsigned long)bp->r3, 4);
 }
 
-extern inline void aurora_mark_event(struct Aurora_port * port, int event)
+static inline void aurora_mark_event(struct Aurora_port * port, int event)
 {
 #ifdef AURORA_DEBUG
 	printk("aurora_mark_event: start\n");

