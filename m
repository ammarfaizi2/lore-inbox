Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVEZWiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVEZWiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVEZWiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:38:03 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26897 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261841AbVEZWgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:36:05 -0400
Message-Id: <200505262230.j4QMUGVh014671@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/7] UML - set_tsk_need_resched
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the UML resched patch.  Please stick it in with the other arch resched
fixes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/process_kern.c	2005-05-26 14:01:28.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/process_kern.c	2005-05-26 14:31:46.000000000 -0400
@@ -188,6 +188,8 @@ void default_idle(void)
 	current->mm = &init_mm;
 	current->active_mm = &init_mm;
 
+        set_tsk_need_resched(current);
+
 	while(1){
 		/* endless idle loop with no priority at all */
 		SET_PRI(current);

