Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbTLaXnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbTLaXnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:43:52 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:42400 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265289AbTLaXnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:43:51 -0500
Date: Wed, 31 Dec 2003 18:43:35 -0500
From: Chris Heath <chris@heathens.co.nz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6] Remove warning in ftape
Message-Id: <20031231183856.0A65.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [en]
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a trivial patch that removes an unused-variable warning in ftape.

Chris


--- a/drivers/char/ftape/lowlevel/ftape-init.c	2003-10-23 23:19:03.000000000 -0400
+++ b/drivers/char/ftape/lowlevel/ftape-init.c	2003-10-23 23:20:18.000000000 -0400
@@ -55,7 +55,7 @@
 char ft_dat[] __initdata = "$Date: 1997/11/06 00:38:08 $";
 
 
-#ifndef CONFIG_FT_NO_TRACE_AT_ALL
+#if defined(MODULE) && !defined(CONFIG_FT_NO_TRACE_AT_ALL)
 static int ft_tracing = -1;
 #endif
 

