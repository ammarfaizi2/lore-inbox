Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSFOPFE>; Sat, 15 Jun 2002 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFOPFD>; Sat, 15 Jun 2002 11:05:03 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21649 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315417AbSFOPFC>;
	Sat, 15 Jun 2002 11:05:02 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 15 Jun 2002 17:05:03 +0200 (MEST)
Message-Id: <UTC200206151505.g5FF53g26435.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [trivial PATCH] config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

% make
***
*** You have not yet configured your kernel!
*** Please run "make xconfig/menuconfig/config/oldconfig"
***
make: *** [.config] Error 1
% make xconfig/menuconfig/config/oldconfig
***
*** You have not yet configured your kernel!
*** Please run "make xconfig/menuconfig/config/oldconfig"
***
make: *** [.config] Error 1
%

Strange - I do precisely what they ask, and the error persists.

--- /linux/2.5/linux-2.5.21/linux/Makefile	Sun Jun  9 07:27:22 2002
+++ ./Makefile	Sat Jun 15 17:00:46 2002
@@ -143,7 +143,8 @@
 .config:
 	@echo '***'
 	@echo '*** You have not yet configured your kernel!'
-	@echo '*** Please run "make xconfig/menuconfig/config/oldconfig"'
+	@echo '*** Please run some configurator (do "make xconfig" or'
+	@echo '*** "make menuconfig" or "make oldconfig" or "make config").'
 	@echo '***'
 	@exit 1
 
