Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSF3PQW>; Sun, 30 Jun 2002 11:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSF3PQV>; Sun, 30 Jun 2002 11:16:21 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:64960 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315245AbSF3PQU>;
	Sun, 30 Jun 2002 11:16:20 -0400
Date: Sun, 30 Jun 2002 17:18:40 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 0/10
Message-ID: <20020630171840.B19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- missing include and #error removal in order to compile.

--- linux-2.5.24/drivers/net/tlan.h	Sun Jun  9 07:28:44 2002
+++ linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 21:59:54 2002
@@ -25,7 +25,7 @@
 #include <asm/io.h>
 #include <asm/types.h>
 #include <linux/netdevice.h>
-
+#include <linux/tqueue.h>
 
 
 	/*****************************************************************
--- linux-2.5.24/drivers/net/tlan.c	Sun Jun  9 07:27:29 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 21:59:16 2002
@@ -166,8 +166,6 @@
  *	                       Thanks to Gunnar Eikman
  *******************************************************************************/
 
-#error Please convert me to Documentation/DMA-mapping.txt
-                                                                                
 #include <linux/module.h>
 
 #include "tlan.h"
