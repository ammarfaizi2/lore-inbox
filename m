Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTDPWbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTDPWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:31:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62480 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261773AbTDPWbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:31:46 -0400
Date: Wed, 16 Apr 2003 23:43:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2/3: Console initcalls return int, zero for success.
Message-ID: <20030416234335.C17775@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030416234227.B17775@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030416234227.B17775@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Apr 16, 2003 at 11:42:27PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Nru a/drivers/serial/68328serial.c b/drivers/serial/68328serial.c
--- a/drivers/serial/68328serial.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/68328serial.c	Wed Apr 16 23:25:53 2003
@@ -1691,9 +1691,10 @@
 };
 
 
-static void __init m68328_console_init(void)
+static int __init m68328_console_init(void)
 {
 	register_console(&m68328_driver);
+	return 0;
 }
 
 console_initcall(m68328_console_init);
diff -Nru a/drivers/serial/amba.c b/drivers/serial/amba.c
--- a/drivers/serial/amba.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/amba.c	Wed Apr 16 23:25:53 2003
@@ -705,9 +705,10 @@
 	.index		= -1,
 };
 
-static void __init ambauart_console_init(void)
+static int __init ambauart_console_init(void)
 {
 	register_console(&amba_console);
+	return 0;
 }
 console_initcall(ambauart_console_init);
 
diff -Nru a/drivers/serial/anakin.c b/drivers/serial/anakin.c
--- a/drivers/serial/anakin.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/anakin.c	Wed Apr 16 23:25:53 2003
@@ -502,10 +502,10 @@
 	.index		= -1,
 };
 
-static void __init
-anakin_console_init(void)
+static int __init anakin_console_init(void)
 {
 	register_console(&anakin_console);
+	return 0;
 }
 console_initcall(anakin_console_init);
 
diff -Nru a/drivers/serial/clps711x.c b/drivers/serial/clps711x.c
--- a/drivers/serial/clps711x.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/clps711x.c	Wed Apr 16 23:25:53 2003
@@ -567,9 +567,10 @@
 	.index		= -1,
 };
 
-static void __init clps711xuart_console_init(void)
+static int __init clps711xuart_console_init(void)
 {
 	register_console(&clps711x_console);
+	return 0;
 }
 console_initcall(clps711xuart_console_init);
 
diff -Nru a/drivers/serial/mcfserial.c b/drivers/serial/mcfserial.c
--- a/drivers/serial/mcfserial.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/mcfserial.c	Wed Apr 16 23:25:53 2003
@@ -1853,9 +1853,10 @@
 	.index		= -1,
 };
 
-static void __init mcfrs_console_init(void)
+static int __init mcfrs_console_init(void)
 {
 	register_console(&mcfrs_console);
+	return 0;
 }
 
 console_initcall(mcfrs_console_init);
diff -Nru a/drivers/serial/sa1100.c b/drivers/serial/sa1100.c
--- a/drivers/serial/sa1100.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/sa1100.c	Wed Apr 16 23:25:53 2003
@@ -836,10 +836,11 @@
 	.index		= -1,
 };
 
-static void __init sa1100_rs_console_init(void)
+static int __init sa1100_rs_console_init(void)
 {
 	sa1100_init_ports();
 	register_console(&sa1100_console);
+	return 0;
 }
 console_initcall(sa1100_rs_console_init);
 
diff -Nru a/drivers/serial/uart00.c b/drivers/serial/uart00.c
--- a/drivers/serial/uart00.c	Wed Apr 16 23:25:53 2003
+++ b/drivers/serial/uart00.c	Wed Apr 16 23:25:53 2003
@@ -645,9 +645,10 @@
 	.index		= 0,
 };
 
-static void __init uart00_console_init(void)
+static int __init uart00_console_init(void)
 {
 	register_console(&uart00_console);
+	return 0;
 }
 console_initcall(uart00_console_init);
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

