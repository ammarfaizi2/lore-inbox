Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVAaMRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVAaMRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVAaMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:17:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7942 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261164AbVAaMRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:17:25 -0500
Date: Mon, 31 Jan 2005 13:17:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] generic_serial.h: kill incorrect gs_debug reference
Message-ID: <20050131121723.GB18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

generic_serial.h contained an incorrect extern reference to the static 
variable gs_debug (Benoit Boissinot reported that gcc 4.0 rejects this).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Jan 2005

--- linux-2.6.11-rc1-mm2-full/include/linux/generic_serial.h.old	2005-01-20 23:26:07.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/include/linux/generic_serial.h	2005-01-20 23:26:20.000000000 +0100
@@ -93,6 +93,4 @@
 int  gs_getserial(struct gs_port *port, struct serial_struct __user *sp);
 void gs_got_break(struct gs_port *port);
 
-extern int gs_debug;
-
 #endif


