Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbULERSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbULERSC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbULERPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:15:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15115 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261338AbULERKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:10:50 -0500
Date: Sun, 5 Dec 2004 18:10:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] char/pcmcia/synclink_cs.: make some functions static
Message-ID: <20041205171047.GW2953@stusta.de>
References: <20041205170944.GV2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041205170944.GV2953@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ first mail included the wrong patch ]

The patch below makes some needlessly global functions static.


diffstat output:
 drivers/char/pcmcia/synclink_cs.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/pcmcia/synclink_cs.c.old	2004-11-07 00:36:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/pcmcia/synclink_cs.c	2004-11-07 00:39:15.000000000 +0100
@@ -923,7 +923,7 @@
 /* Return next bottom half action to perform.
  * or 0 if nothing to do.
  */
-int bh_action(MGSLPC_INFO *info)
+static int bh_action(MGSLPC_INFO *info)
 {
 	unsigned long flags;
 	int rc = 0;
@@ -1017,7 +1017,7 @@
 }
 
 /* eom: non-zero = end of frame */ 
-void rx_ready_hdlc(MGSLPC_INFO *info, int eom) 
+static void rx_ready_hdlc(MGSLPC_INFO *info, int eom) 
 {
 	unsigned char data[2];
 	unsigned char fifo_count, read_count, i;
@@ -1079,7 +1079,7 @@
 	issue_command(info, CHA, CMD_RXFIFO);
 }
 
-void rx_ready_async(MGSLPC_INFO *info, int tcd) 
+static void rx_ready_async(MGSLPC_INFO *info, int tcd) 
 {
 	unsigned char data, status;
 	int fifo_count;
@@ -1153,7 +1153,7 @@
 }
 
 
-void tx_done(MGSLPC_INFO *info) 
+static void tx_done(MGSLPC_INFO *info) 
 {
 	if (!info->tx_active)
 		return;
@@ -1190,7 +1190,7 @@
 	}
 }
 
-void tx_ready(MGSLPC_INFO *info) 
+static void tx_ready(MGSLPC_INFO *info) 
 {
 	unsigned char fifo_count = 32;
 	int c;
@@ -1239,7 +1239,7 @@
 	}
 }
 
-void cts_change(MGSLPC_INFO *info) 
+static void cts_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->cts_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1276,7 +1276,7 @@
 	info->pending_bh |= BH_STATUS;
 }
 
-void dcd_change(MGSLPC_INFO *info) 
+static void dcd_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->dcd_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1310,7 +1310,7 @@
 	info->pending_bh |= BH_STATUS;
 }
 
-void dsr_change(MGSLPC_INFO *info) 
+static void dsr_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->dsr_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -1325,7 +1325,7 @@
 	info->pending_bh |= BH_STATUS;
 }
 
-void ri_change(MGSLPC_INFO *info) 
+static void ri_change(MGSLPC_INFO *info) 
 {
 	get_signals(info);
 	if ((info->ri_chkcount)++ >= IO_PIN_SHUTDOWN_LIMIT)
@@ -2955,7 +2955,7 @@
 
 /* Called to print information about devices
  */
-int mgslpc_read_proc(char *page, char **start, off_t off, int count,
+static int mgslpc_read_proc(char *page, char **start, off_t off, int count,
 		 int *eof, void *data)
 {
 	int len = 0, l;
@@ -3212,7 +3212,7 @@
 module_init(synclink_cs_init);
 module_exit(synclink_cs_exit);
 
-void mgslpc_set_rate(MGSLPC_INFO *info, unsigned char channel, unsigned int rate) 
+static void mgslpc_set_rate(MGSLPC_INFO *info, unsigned char channel, unsigned int rate) 
 {
 	unsigned int M, N;
 	unsigned char val;
@@ -3248,7 +3248,7 @@
 
 /* Enabled the AUX clock output at the specified frequency.
  */
-void enable_auxclk(MGSLPC_INFO *info)
+static void enable_auxclk(MGSLPC_INFO *info)
 {
 	unsigned char val;
 	
