Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSINXL7>; Sat, 14 Sep 2002 19:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSINXL7>; Sat, 14 Sep 2002 19:11:59 -0400
Received: from pD9E2308E.dip.t-dialin.net ([217.226.48.142]:33675 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317611AbSINXL6>; Sat, 14 Sep 2002 19:11:58 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] Get modules_install correct
X-Mailer: Lightweight Patch Manager
Message-ID: <20020914231717.2E1BC4@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Sat, 14 Sep 2002 23:17:17 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Makefile.orig	Sat Sep 14 17:12:22 2002
+++ Makefile	Sat Sep 14 17:16:15 2002
@@ -67,7 +67,7 @@
 
 #	If we have only "make modules", don't compile built-in objects.
 
-ifeq ($(MAKECMDGOALS),modules)
+ifeq ($(subst modules_install,,$(MAKECMDGOALS)),modules)
   KBUILD_BUILTIN :=
 endif
 

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me

