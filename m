Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWEEQpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWEEQpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWEEQoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:55 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:35460 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751652AbWEEQow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:52 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, tnt@246tNt.com
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <11.420169009@selenic.com>
Subject: [PATCH 10/14] random: Remove bogus SA_SAMPLE_RANDOM from mpc52xx serial driver
Date: Fri, 05 May 2006 11:42:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus SA_SAMPLE_RANDOM from mpc52xx serial driver

Serial lines are not a good a priori source of entropy.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/serial/mpc52xx_uart.c
===================================================================
--- 2.6.orig/drivers/serial/mpc52xx_uart.c	2006-05-02 17:29:27.000000000 -0500
+++ 2.6/drivers/serial/mpc52xx_uart.c	2006-05-03 13:32:10.000000000 -0500
@@ -191,7 +191,7 @@ mpc52xx_uart_startup(struct uart_port *p
 
 	/* Request IRQ */
 	ret = request_irq(port->irq, mpc52xx_uart_int,
-		SA_INTERRUPT | SA_SAMPLE_RANDOM, "mpc52xx_psc_uart", port);
+		SA_INTERRUPT, "mpc52xx_psc_uart", port);
 	if (ret)
 		return ret;
 
