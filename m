Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVKZSD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKZSD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 13:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKZSD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 13:03:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42491 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750706AbVKZSD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 13:03:28 -0500
Subject: patch 2.6.14-rt19
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Date: Sat, 26 Nov 2005 10:03:10 -0800
Message-Id: <1133028191.26995.31.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

INgo,

FYI, this latest patch forces Makefile to default to x86-64:


Index: linux/Makefile
===================================================================
--- linux.orig/Makefile
+++ linux/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION =
+EXTRAVERSION = -rt19
 NAME=Affluent Albatross

 # *DOCUMENTATION*
@@ -189,8 +189,8 @@ SUBARCH := $(shell uname -m | sed -e s/i
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their
arch/*/Makefile

-ARCH           ?= $(SUBARCH)
-CROSS_COMPILE  ?=
+ARCH = x86_64
+CROSS_COMPILE = x86_64-linux-



-- 
***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
1237 East Arques Ave.
Sunnyvale, CA 94085

Phone: 408.992.4515
Fax: 408.328.9204

http://www.mvista.com
Platform To Innovate
*********************************** 

