Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUBHB25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUBHB2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:28:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36038 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261965AbUBHB2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:28:25 -0500
Date: Sun, 8 Feb 2004 02:28:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: tytso@mit.edu, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] serialP.h: remove a kernel 2.2 #ifdef
Message-ID: <20040208012822.GL7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a kernel 2.2 #ifdef from include/linux/serialP.h .

Please apply
Adrian


--- linux-2.6.2-mm1/include/linux/serialP.h.old	2004-02-08 02:25:01.000000000 +0100
+++ linux-2.6.2-mm1/include/linux/serialP.h	2004-02-08 02:25:22.000000000 +0100
@@ -26,11 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
-#if (LINUX_VERSION_CODE < 0x020300)
-/* Unfortunate, but Linux 2.2 needs async_icount defined here and
- * it got moved in 2.3 */
-#include <linux/serial.h>
-#endif
 
 struct serial_state {
 	int	magic;
