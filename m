Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTKQREf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKQREf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:04:35 -0500
Received: from calisto.ae.poznan.pl ([150.254.37.3]:44983 "EHLO
	calisto.ae.poznan.pl") by vger.kernel.org with ESMTP
	id S263527AbTKQREe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:04:34 -0500
Date: Mon, 17 Nov 2003 18:04:10 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Lars Ehrhardt <1103@ng.h42.de>
Cc: Ricky Beam <jfbeam@bluetronic.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.6.0-test9-bk22 does not compile on sparc64: undefined
 reference to `vga_writeb'
In-Reply-To: <3FB8FCA6.7010804@ng.h42.de>
Message-ID: <Pine.LNX.4.51.0311171802350.14956@dns.toxicfilms.tv>
References: <Pine.GSO.4.33.0311171131070.26356-100000@sweetums.bluetronic.net>
 <3FB8FCA6.7010804@ng.h42.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe the help text for VGA_CONSOLE should be adjusted accordingly?
> By reading "Virtually everyone wants that." in the help text I did not
> assume that this option does not make sense on Sparcs.
Maybe :) How about this:

--- linux/drivers/video/console/Kconfig~	2003-11-17 17:59:23.000000000 +0100
+++ linux/drivers/video/console/Kconfig	2003-11-17 17:59:12.000000000 +0100
@@ -11,7 +11,8 @@
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
 	  display that complies with the generic VGA standard. Virtually
-	  everyone wants that.
+	  everyone wants that, except sparc users. Sparc does not have
+	  VGA, use fb mode or serial console instead.

 	  The program SVGATextMode can be used to utilize SVGA video cards to
 	  their full potential in text mode. Download it from



> Lars Ehrhardt
Maciej

