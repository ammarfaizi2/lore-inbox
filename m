Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVJ1MyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVJ1MyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 08:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVJ1MyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 08:54:19 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:706 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965221AbVJ1MyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 08:54:19 -0400
Subject: [ketchup] patch to allow for moving of .gitignore in 2.6.14
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20051018072927.GU26160@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
	 <20051017213915.GN26160@waste.org>
	 <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
	 <20051018063031.GR26160@waste.org>
	 <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
	 <20051018072927.GU26160@waste.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 08:54:02 -0400
Message-Id: <1130504043.9574.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Here's a small patch to ketchup to make it move the .gitignore that is
now included in 2.6.14.

-- Steve

Index: Ketchup-d9503020b3c1/ketchup
===================================================================
--- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 08:38:50.000000000 -0400
+++ Ketchup-d9503020b3c1/ketchup	2005-10-28 08:48:37.000000000 -0400
@@ -482,7 +482,7 @@
         error("Unpacking failed: ", err)
         sys.exit(-1)
 
-    err = os.system("mv linux*/* . ; rmdir linux*")
+    err = os.system("mv linux*/* linux*/.git* . ; rmdir linux*")
     if err:
         error("Unpacking failed: ", err)
         sys.exit(-1)


