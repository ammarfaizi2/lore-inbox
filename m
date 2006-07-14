Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWGNUFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWGNUFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbWGNUFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:05:17 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:16068 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422743AbWGNUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:05:15 -0400
Subject: [PATCH 01/02] remove set_wmb - doc update
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060714105841.4490c0e2.akpm@osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
	 <1152898699.27135.20.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
	 <20060714105841.4490c0e2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 16:05:01 -0400
Message-Id: <1152907501.27135.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to set_wmb from memory-barriers.txt
since it shouldn't be used.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/Documentation/memory-barriers.txt
===================================================================
--- linux-2.6.18-rc1.orig/Documentation/memory-barriers.txt	2006-07-14 15:33:44.000000000 -0400
+++ linux-2.6.18-rc1/Documentation/memory-barriers.txt	2006-07-14 15:38:05.000000000 -0400
@@ -1015,10 +1015,9 @@ CPU from reordering them.
 There are some more advanced barrier functions:
 
  (*) set_mb(var, value)
- (*) set_wmb(var, value)
 
-     These assign the value to the variable and then insert at least a write
-     barrier after it, depending on the function.  They aren't guaranteed to
+     This assigns the value to the variable and then inserts at least a write
+     barrier after it, depending on the function.  It isn't guaranteed to
      insert anything more than a compiler barrier in a UP compilation.
 
 


