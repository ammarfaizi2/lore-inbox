Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbULERFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbULERFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULERE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:04:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39178 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261337AbULERCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:02:49 -0500
Date: Sun, 5 Dec 2004 18:02:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/moxa.c: remove an unused function
Message-ID: <20041205170247.GR2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused global function.


diffstat output:
 drivers/char/moxa.c |   18 ------------------
 1 files changed, 18 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/moxa.c.old	2004-11-07 00:28:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/moxa.c	2004-11-07 00:28:41.000000000 +0100
@@ -1765,7 +1765,6 @@
  *	2.  MoxaPortEnable(int port);					     *
  *	3.  MoxaPortDisable(int port);					     *
  *	4.  MoxaPortGetMaxBaud(int port);				     *
- *	5.  MoxaPortGetCurBaud(int port);				     *
  *	6.  MoxaPortSetBaud(int port, long baud);			     *
  *	7.  MoxaPortSetMode(int port, int databit, int stopbit, int parity); *
  *	8.  MoxaPortSetTermio(int port, unsigned char *termio); 	     *
@@ -1876,15 +1875,6 @@
  *                      38400/57600/115200 bps
  *
  *
- *      Function 9:     Get the current baud rate of this port.
- *      Syntax:
- *      long MoxaPortGetCurBaud(int port);
- *           int port           : port number (0 - 127)
- *
- *           return:    0       : this port is invalid
- *                      50 - 115200 bps
- *
- *
  *      Function 10:    Setting baud rate of this port.
  *      Syntax:
  *      long MoxaPortSetBaud(int port, long baud);
@@ -3093,14 +3083,6 @@
 	return (0);
 }
 
-long MoxaPortGetCurBaud(int port)
-{
-
-	if (moxaChkPort[port] == 0)
-		return (0);
-	return (moxaCurBaud[port]);
-}
-
 static void MoxaSetFifo(int port, int enable)
 {
 	void __iomem *ofsAddr = moxaTableAddr[port];

