Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTGAVRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTGAVRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:17:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:4622 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262861AbTGAVRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:17:32 -0400
Date: Tue, 1 Jul 2003 22:31:54 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Peter Cordes <peter@llama.nslug.ns.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 doesn't build without CONFIG_VT_CONSOLE
In-Reply-To: <20030701195241.GA2545@llama.nslug.ns.ca>
Message-ID: <Pine.LNX.4.44.0307012231100.12898-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try this patch.

--- vt.c	Tue Jul  1 14:19:07 2003
+++ vt.c.new	Tue Jul  1 14:03:17 2003
@@ -109,7 +109,7 @@
 
 #include "console_macros.h"
 
-
+struct tty_driver *console_driver;
 const struct consw *conswitchp;
 
 /* A bitmap for codes <32. A bit of 1 indicates that the code
@@ -2185,8 +2185,6 @@
 quit:
 	clear_bit(0, &printing);
 }
-
-struct tty_driver *console_driver;
 
 static struct tty_driver *vt_console_device(struct console *c, int *index)
 {


