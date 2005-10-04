Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVJDTBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVJDTBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVJDTBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:01:46 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:13837 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964922AbVJDTBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:01:45 -0400
Message-Id: <200510041853.j94IrnqX008942@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/2] UML - Fix Al's build tidying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Oct 2005 14:53:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al's build tidying missed one bit from me - without this UML doesn't boot.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Index: linux-2.6.13/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-i386/user-offsets.c	2005-10-04 13:33:39.000000000 -0400
+++ linux-2.6.13/arch/um/sys-i386/user-offsets.c	2005-10-04 14:57:24.000000000 -0400
@@ -46,7 +46,7 @@
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
 	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
 	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
 


