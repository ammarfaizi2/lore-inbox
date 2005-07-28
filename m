Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVG1Qjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVG1Qjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVG1Qh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:37:29 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:48397 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261674AbVG1Qes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:34:48 -0400
Message-Id: <200507281626.j6SGQoWs009492@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 5/7] UML - Fix typo
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 12:26:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Fix a typo in wait_stub_done.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/kernel/skas/process.c	2005-07-28 11:06:35.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/kernel/skas/process.c	2005-07-28 11:44:07.000000000 -0400
@@ -64,7 +64,7 @@
                 (WSTOPSIG(status) == SIGVTALRM));
 
         if((n < 0) || !WIFSTOPPED(status) ||
-           (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status != SIGTRAP))){
+           (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
                       "pid = %d, n = %d, errno = %d, status = 0x%x\n",
                       fname, pid, n, errno, status);

