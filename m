Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVHWUdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVHWUdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVHWUdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:33:45 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:2834 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932382AbVHWUdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:33:44 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:30:31 +0200)
Subject: [PATCH 4/8] fix enum pid_directory_inos in proc/base.c
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:33:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes wrongly placed elements in the pid_directory_inos
enum.  Also add comment so this mistake is not repeated.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/proc/base.c
===================================================================
--- linux.orig/fs/proc/base.c	2005-08-19 14:47:35.000000000 +0200
+++ linux/fs/proc/base.c	2005-08-19 14:47:36.000000000 +0200
@@ -120,7 +120,6 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
 #endif
-	PROC_TGID_FD_DIR,
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
 	PROC_TID_INO,
@@ -159,9 +158,11 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
 #endif
-	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+
+	/* Add new entries before this */
+	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
 struct pid_entry {
