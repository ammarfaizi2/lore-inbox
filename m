Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVBKOwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVBKOwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 09:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBKOwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 09:52:32 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:55731 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262250AbVBKOw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 09:52:27 -0500
Message-ID: <420CC8E3.8060007@ru.mvista.com>
Date: Fri, 11 Feb 2005 18:01:55 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Fix typos in cpm_uart_cpm2.c
Content-Type: multipart/mixed;
 boundary="------------060505010008020009000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060505010008020009000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch applies to the kernel 2.6.11-rc3 and removes
excess '~' before the bit masks.

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>



--------------060505010008020009000003
Content-Type: text/plain;
 name="cpm2uart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm2uart.diff"

diff -uprN a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c	2005-02-11 17:20:45.000000000 +0300
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c	2005-02-11 17:26:45.000000000 +0300
@@ -127,7 +127,7 @@ void scc1_lineif(struct uart_cpm_port *p
 	io->iop_pdird |= 0x00000002;	/* Tx */
 
 	/* Wire BRG1 to SCC1 */
-	cpm2_immr->im_cpmux.cmx_scr &= ~0x00ffffff;
+	cpm2_immr->im_cpmux.cmx_scr &= 0x00ffffff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00000000;
 	pinfo->brg = 1;
 }
@@ -140,7 +140,7 @@ void scc2_lineif(struct uart_cpm_port *p
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
-	cpm2_immr->im_cpmux.cmx_scr &= ~0xff00ffff;
+	cpm2_immr->im_cpmux.cmx_scr &= 0xff00ffff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00090000;
 	pinfo->brg = 2;
 }
@@ -153,7 +153,7 @@ void scc3_lineif(struct uart_cpm_port *p
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
-	cpm2_immr->im_cpmux.cmx_scr &= ~0xffff00ff;
+	cpm2_immr->im_cpmux.cmx_scr &= 0xffff00ff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00001200;
 	pinfo->brg = 3;
 }
@@ -167,7 +167,7 @@ void scc4_lineif(struct uart_cpm_port *p
 	io->iop_pdird &= ~0x00000200;	/* Rx */
 	io->iop_pdird |= 0x00000400;	/* Tx */
 
-	cpm2_immr->im_cpmux.cmx_scr &= ~0xffffff00;
+	cpm2_immr->im_cpmux.cmx_scr &= 0xffffff00;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x0000001b;
 	pinfo->brg = 4;
 }

--------------060505010008020009000003--

