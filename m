Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264996AbUETHI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264996AbUETHI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbUETHIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:08:25 -0400
Received: from ozlabs.org ([203.10.76.45]:49292 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265023AbUETHIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:08:06 -0400
Subject: [TRIVIAL] fix counter in build_zonelists()
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085034171.24931.98.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 17:07:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From:  Stephen Leonard <stephen@phynp6.phy-astr.gsu.edu>

---
  Hi Rusty
  
  This trivial patch fixes a counter that is unnecessarily incremented
  in build_zonelists().  It applies against 2.6.5.
  
  stephen
  
  

--- trivial-2.6.6-bk6/mm/page_alloc.c.orig	2004-05-20 15:59:22.000000000 +1000
+++ trivial-2.6.6-bk6/mm/page_alloc.c	2004-05-20 15:59:22.000000000 +1000
@@ -1284,7 +1284,7 @@
  		for (node = 0; node < local_node; node++)
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  
-		zonelist->zones[j++] = NULL;
+		zonelist->zones[j] = NULL;
 	}
 }
 
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Stephen Leonard <stephen@phynp6.phy-astr.gsu.edu>: [PATCH] fix counter in build_zonelists()

