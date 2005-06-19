Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFSBul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFSBul (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 21:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFSBuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 21:50:40 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:33734 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261246AbVFSBu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 21:50:26 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 19 Jun 2005 11:50:03 +1000
Message-ID: <20663.1119145803@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
to suppress them.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.12/Makefile
===================================================================
--- 2.6.12.orig/Makefile	2005-06-18 15:21:18.000000000 +1000
+++ 2.6.12/Makefile	2005-06-19 11:43:15.876218980 +1000
@@ -204,6 +204,8 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
 HOSTCC  	= gcc
 HOSTCXX  	= g++
 HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+# disable pointer signedness warnings in gcc 4.0
+HOSTCFLAGS += $(call cc-option,-Wno-pointer-sign,)
 HOSTCXXFLAGS	= -O2
 
 # 	Decide whether to build built-in, modular, or both.

