Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUERNGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUERNGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 09:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUERNGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 09:06:55 -0400
Received: from blackbox.ecweb.com ([199.72.99.40]:27911 "EHLO
	blackbox.ecweb.com") by vger.kernel.org with ESMTP id S263325AbUERNGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 09:06:32 -0400
Subject: Trivial Comment Patch: 2.6.6-mm3
From: Danny Cox <Danny.Cox@ECWeb.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-AFPGndN+nuza3AuJ7pG4"
Organization: Electronic Commerce Systems
Message-Id: <1084885737.17460.3.camel@vom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 May 2004 09:08:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AFPGndN+nuza3AuJ7pG4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	This fixes a comment in the stack overflow check that's wrong with 4K
stacks.

	Sorry to attach it, but Evolution screws up the lines if it's inline.

	Thanks!

-- 
Daniel S. Cox
Electronic Commerce Systems

--=-AFPGndN+nuza3AuJ7pG4
Content-Disposition: attachment; filename=4kstack_comment_fix.patch
Content-Type: text/plain; name=4kstack_comment_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- irq.c.orig	2004-05-18 08:53:05.363390440 -0400
+++ irq.c	2004-05-18 08:53:25.052755701 -0400
@@ -431,7 +431,7 @@
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-	/* Debugging check for stack overflow: is there less than 1KB free? */
+	/* Debugging check for stack overflow: is there less than 512B free? */
 	{
 		long esp;
 

--=-AFPGndN+nuza3AuJ7pG4--

