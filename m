Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263573AbUDZVEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUDZVEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUDZVEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:04:08 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:16293 "EHLO
	mwinf1003.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263573AbUDZVED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:04:03 -0400
From: Fabrice =?iso-8859-1?q?M=E9nard?= <menard.fabrice@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: fbcon and unimap
Date: Mon, 26 Apr 2004 23:07:54 +0200
User-Agent: KMail/1.5.2
Cc: jsimmons@infradead.org, geert@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404262307.54767.menard.fabrice@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to solve my latin1 char problems with the framebuffer console, I found 
that fbcon doesn't set a unicode map (2.6.5 kernel).

Here is the patch:

--- linux-2.6.5.original/drivers/video/console/fbcon.c	2004-04-26 
21:05:57.000000000 +0200
+++ linux-2.6.5/drivers/video/console/fbcon.c	2004-04-26 22:06:04.000000000 
+0200
@@ -609,6 +609,7 @@
 		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
 	else
 		fb_display[unit].scrollmode = SCROLL_YREDRAW;
+	con_set_default_unimap(unit);
 	fbcon_set_display(vc, init, !init);
 }
 
Don't know if it helps; I cc this message to the mainainer for an eventual 
inclusion in the next release.


ps: if my english is too bad, please send me a note !
-- 
Fabrice Ménard
menard.fabrice@wanadoo.fr


