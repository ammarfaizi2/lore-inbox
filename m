Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263209AbUJ2Acz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbUJ2Acz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUJ2Aax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:30:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54278 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263260AbUJ2AZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:25:43 -0400
Date: Fri, 29 Oct 2004 02:25:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] pcmcia/yenta_socket.c: remove an unused function
Message-ID: <20041029002509.GW29142@stusta.de>
References: <20041028231326.GD3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028231326.GD3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from 
drivers/pcmcia/yenta_socket.c


diffstat output:
 drivers/pcmcia/yenta_socket.c |    9 ---------
 1 files changed, 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/pcmcia/yenta_socket.c.old	2004-10-28 23:23:42.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/pcmcia/yenta_socket.c	2004-10-28 23:23:54.000000000 +0200
@@ -109,15 +109,6 @@
 	return val;
 }
 
-static inline u8 exca_readw(struct yenta_socket *socket, unsigned reg)
-{
-	u16 val;
-	val = readb(socket->base + 0x800 + reg);
-	val |= readb(socket->base + 0x800 + reg + 1) << 8;
-	debug("%p %04x %04x\n", socket, reg, val);
-	return val;
-}
-
 static inline void exca_writeb(struct yenta_socket *socket, unsigned reg, u8 val)
 {
 	debug("%p %04x %02x\n", socket, reg, val);
