Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbSKSXv7>; Tue, 19 Nov 2002 18:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbSKSXv7>; Tue, 19 Nov 2002 18:51:59 -0500
Received: from guru.webcon.net ([66.11.168.140]:62400 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S267582AbSKSXv6>;
	Tue, 19 Nov 2002 18:51:58 -0500
Date: Tue, 19 Nov 2002 18:58:54 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20-rc2-ac1 io_apic.c
Message-ID: <Pine.LNX.4.44.0211191847240.2942-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A previous email did not clearly mark this as a patch for submission, so you
probably missed it.

This patch fixes a linking error in kernel.o due to a missed change in
io_apic.c (you and Marcelo seem to be stepping on each other's toes):

--- io_apic.c~	Tue Nov 19 18:46:36 2002
+++ io_apic.c	Tue Nov 19 18:46:36 2002
@@ -1894,7 +1894,7 @@
 
 	entry.delivery_mode = dest_LowestPrio;
 	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = target_cpus();
+	entry.dest.logical.logical_dest = TARGET_CPUS;
 	entry.mask = 1;					 /* Disabled (masked) */
 	entry.trigger = 1;				   /* Level sensitive */
 	entry.polarity = 1;					/* Low active */


Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------

