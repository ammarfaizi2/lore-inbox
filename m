Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWDMN7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWDMN7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWDMN7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:59:12 -0400
Received: from mail.renesas.com ([202.234.163.13]:8583 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964938AbWDMN7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:59:11 -0400
Date: Thu, 13 Apr 2006 22:59:07 +0900 (JST)
Message-Id: <20060413.225907.424259393.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH-2.6.17-rc1-mm2] m32r: Remove a warning of m32r_sio.c
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org,
       rmk@dyn-67.arm.linux.org.uk
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to fix the following warning.
This patch is against 2.6.17-rc1-mm2. 
Please apply.
--
CC      drivers/serial/m32r_sio.o
  /project/m32r-linux/kernel/linux-2.6.17-rc1-mm2/linux-2.6.17-rc1-mm2/drivers/serial/m32r_sio.c: In function 'm32r_sio_console_write':
  /project/m32r-linux/kernel/linux-2.6.17-rc1-mm2/linux-2.6.17-rc1-mm2/drivers/serial/m32r_sio.c:1060: warning: unused variable 'i'

> [SERIAL] kernel console should send CRLF not LFCR
> author	Russell King <rmk@dyn-67.arm.linux.org.uk>
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=876bc5e027bb3592e38d9323c4e8c3085f642142;hp=242a04104393e1e25e5462f23110830ba587c798;hb=d358788f3f30113e49882187d794832905e42592;f=drivers/serial/m32r_sio.c

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Cc: Russell King <rmk@dyn-67.arm.linux.org.uk>
---

 drivers/serial/m32r_sio.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.17-rc1-mm2/drivers/serial/m32r_sio.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/drivers/serial/m32r_sio.c	2006-04-10 13:59:03.000000000 +0900
+++ linux-2.6.17-rc1-mm2/drivers/serial/m32r_sio.c	2006-04-10 13:59:51.802691874 +0900
@@ -1057,7 +1057,6 @@ static void m32r_sio_console_write(struc
 {
 	struct uart_sio_port *up = &m32r_sio_ports[co->index];
 	unsigned int ier;
-	int i;
 
 	/*
 	 *	First save the UER then disable the interrupts

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

