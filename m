Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUKNBj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUKNBj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKNBj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:39:58 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34533 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261233AbUKNBjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:39:49 -0500
Date: Sun, 14 Nov 2004 02:39:44 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] no __init in serial/8250.c?
Message-ID: <20041114013943.GA4903@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Referenced in non-init context.

diff -uprN -X /linux/dontdiff a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2004-10-30 21:44:01.000000000 +0200
+++ b/drivers/serial/8250.c	2004-11-14 01:43:56.000000000 +0100
@@ -1965,7 +1965,7 @@ serial8250_console_write(struct console 
 	serial_out(up, UART_IER, ier);
 }
 
-static int __init serial8250_console_setup(struct console *co, char *options)
+static int serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
