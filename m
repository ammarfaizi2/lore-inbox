Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271843AbTGYA0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271844AbTGYA0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:26:45 -0400
Received: from web40312.mail.yahoo.com ([66.218.78.91]:5999 "HELO
	web40312.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271843AbTGYA0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:26:42 -0400
Message-ID: <20030725004151.75512.qmail@web40312.mail.yahoo.com>
Date: Thu, 24 Jul 2003 21:41:51 -0300 (ART)
From: =?iso-8859-1?q?Joilnen=20Leite?= <knl_joi@yahoo.com.br>
Subject: bep poiner 
To: linux-usb-users@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me friends if I am simpler but,
in auerbuf_setup function bep pointer is not free, I
guess
maybe it is better ?

--- /usr/src/linux/drivers/usb/misc/auerswald.c
2003-07-02 14:07:48.000000000 -0300
+++ drivers/usb/misc/auerswald.c	2003-07-24
18:27:44.000000000 -0300
@@ -802,6 +802,8 @@
 bl_fail:/* not enough memory. Free allocated elements
*/
         dbg ("auerbuf_setup: no more memory");
         auerbuf_free_buffers (bcp);
+	if(bep)
+		kfree(bep);
         return -ENOMEM;
 }
  
thanks !


_______________________________________________________________________
Conheça o novo Cadê? - Rápido, fácil e preciso.
42 milhões de páginas brasileiras, busca por imagens e muito mais!
http://www.cade.com.br
