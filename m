Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTADWGp>; Sat, 4 Jan 2003 17:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTADWGp>; Sat, 4 Jan 2003 17:06:45 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:15367 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S261599AbTADWGn>;
	Sat, 4 Jan 2003 17:06:43 -0500
Date: Sat, 4 Jan 2003 23:15:11 +0200
X-Mailer: i.Scribe v1.84 (Win32 v5.00, Release)
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Linux-Kernel " <linux-kernel@vger.kernel.org>
From: "Daniel Ritz" <daniel.ritz@gmx.ch>
Subject: [PATCH 2.5] Stop APM as module from oopsing
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <20030104221527.8E5E67C99@ritz.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trivial fix to stop APM from oopsing when compiled as module.
against 2.5.54bk1. please apply.

beep
-daniel

--- 2554-clean/arch/i386/kernel/apm.c	2003-01-03 17:00:54.000000000 +0100
+++ 2554/arch/i386/kernel/apm.c	2003-01-04 21:31:50.000000000 +0100
@@ -718,7 +718,7 @@
  *	same format.
  */
 
-static int __init apm_driver_version(u_short *val)
+static int apm_driver_version(u_short *val)
 {
 	u32	eax;
 
 
 

