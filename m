Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUFYGbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUFYGbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUFYGa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:30:56 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:14758 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266257AbUFYG3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:29:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Make CONFIG_SYSVIPC depend on CONFIG_MMU
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040625062946.9A2183A2@mctpc71>
Date: Fri, 25 Jun 2004 15:29:46 +0900 (JST)
From: miles@mctpc71.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sysv-ipc code uses mm/shmem.o, which in turn uses VM stuff and is
only compiled on MMU systems.

Signed-off-by: Miles Bader <miles@gnu.org>

 init/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -ruN -X../cludes linux-2.6.7-uc0/init/Kconfig linux-2.6.7-uc0-v850-20040625/init/Kconfig
--- linux-2.6.7-uc0/init/Kconfig	2004-06-24 17:08:30.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040625/init/Kconfig	2004-06-25 14:47:26.000000000 +0900
@@ -77,6 +77,7 @@
 
 config SYSVIPC
 	bool "System V IPC"
+	depends on MMU
 	---help---
 	  Inter Process Communication is a suite of library functions and
 	  system calls which let processes (running programs) synchronize and
