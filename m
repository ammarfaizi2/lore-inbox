Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUCVXvH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUCVXvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:51:07 -0500
Received: from ozlabs.org ([203.10.76.45]:19887 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261619AbUCVXvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:51:03 -0500
Subject: [TRIVIAL] Fw: Remove warning in ftape
From: Rusty Russell <rusty@rustcorp.com.au>
To: Claus-Justus Heine <claus@momo.math.rwth-aachen.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079999384.6591.105.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 10:49:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From:  Chris Heath <chris@heathens.co.nz>

---
  I sent this to the list a few months ago.  Hopefully it won't get lost
  if I send it via trivial.  :-)
  
  Chris
  
  
  Forwarded by Chris Heath <chris@heathens.co.nz>
  ----------------------- Original Message -----------------------
   From:    Chris Heath <chris@heathens.co.nz>
   To:      linux-kernel@vger.kernel.org
   Date:    Wed, 31 Dec 2003 18:43:35 -0500
   Subject: [PATCH][2.6] Remove warning in ftape
  ----
  
  Here's a trivial patch that removes an unused-variable warning in ftape.
  
  Chris
  
  

--- trivial-2.6.5-rc2-bk2/drivers/char/ftape/lowlevel/ftape-init.c.orig	2004-03-23 10:10:38.000000000 +1100
+++ trivial-2.6.5-rc2-bk2/drivers/char/ftape/lowlevel/ftape-init.c	2004-03-23 10:10:38.000000000 +1100
@@ -55,7 +55,7 @@
 char ft_dat[] __initdata = "$Date: 1997/11/06 00:38:08 $";
 

-#ifndef CONFIG_FT_NO_TRACE_AT_ALL
+#if defined(MODULE) && !defined(CONFIG_FT_NO_TRACE_AT_ALL)
 static int ft_tracing = -1;
 #endif
 
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Chris Heath <chris@heathens.co.nz>: Fw: [PATCH][2.6] Remove warning in ftape

