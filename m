Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVDXTBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVDXTBA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 15:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVDXTA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 15:00:59 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:46256 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262366AbVDXTAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 15:00:53 -0400
Subject: [patch 6/7] uml: commentary about forking flag
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:19:22 +0200
Message-Id: <20050424181922.631D255D03@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some commentary about UML internals, for a strange trick.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/include/asm-um/processor-generic.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN include/asm-um/processor-generic.h~uml-commentary-about-forking-flag include/asm-um/processor-generic.h
--- linux-2.6.12/include/asm-um/processor-generic.h~uml-commentary-about-forking-flag	2005-04-24 20:17:06.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/processor-generic.h	2005-04-24 20:17:06.000000000 +0200
@@ -17,6 +17,10 @@ struct task_struct;
 struct mm_struct;
 
 struct thread_struct {
+	/* This flag is set to 1 before calling do_fork (and analyzed in
+	 * copy_thread) to mark that we are begin called from userspace (fork /
+	 * vfork / clone), and reset to 0 after. It is left to 0 when called
+	 * from kernelspace (i.e. kernel_thread() or fork_idle(), as of 2.6.11). */
 	int forking;
 	int nsyscalls;
 	struct pt_regs regs;
_
