Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTALIlD>; Sun, 12 Jan 2003 03:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTALIlC>; Sun, 12 Jan 2003 03:41:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24523 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267331AbTALIlC>; Sun, 12 Jan 2003 03:41:02 -0500
Date: Sun, 12 Jan 2003 09:49:47 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 code from mcfserial.h
Message-ID: <20030112084947.GQ21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some #if'd code for kernel 2.0 from 
drivers/serial/mcfserial.h.

Please apply
Adrian


--- linux-2.5.56/drivers/serial/mcfserial.h.old	2003-01-12 09:44:38.000000000 +0100
+++ linux-2.5.56/drivers/serial/mcfserial.h	2003-01-12 09:45:04.000000000 +0100
@@ -69,13 +69,8 @@
 	struct work_struct	tqueue_hangup;
 	struct termios		normal_termios;
 	struct termios		callout_termios;
-#if LINUX_VERSION_CODE <= 0x020100
-	struct wait_queue	*open_wait;
-	struct wait_queue	*close_wait;
-#else
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
-#endif
 
 };
 
