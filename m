Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTBXLf3>; Mon, 24 Feb 2003 06:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTBXLf3>; Mon, 24 Feb 2003 06:35:29 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:58045 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S266805AbTBXLf2>; Mon, 24 Feb 2003 06:35:28 -0500
Date: Mon, 24 Feb 2003 12:45:35 +0100 (CET)
From: fcorneli@elis.rug.ac.be
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: [PATCH] entry.S ALIGNs, kernel 2.5.62
Message-ID: <Pine.LNX.4.44.0302241239450.1016-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the ENTRY macro offers an ALIGN directive we can remove some 
obsolete ALIGNs from entry.S.

BTW: arch/i386/kernel/ptrace.c:do_syscall_trace has regparm(3). Shouldn't 
that be 2?

Frank.

--- entry.S.orig	2003-02-24 12:34:34.000000000 +0100
+++ entry.S	2003-02-24 12:35:07.000000000 +0100
@@ -228,7 +228,6 @@
 #define SYSENTER_RETURN 0xffffe010
 
 	# sysenter call handler stub
-	ALIGN
 ENTRY(sysenter_entry)
 	sti
 	pushl $(__USER_DS)
@@ -271,7 +270,6 @@
 
 
 	# system call handler stub
-	ALIGN
 ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL

