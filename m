Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWEZTlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWEZTlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWEZTlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:41:24 -0400
Received: from silver.veritas.com ([143.127.12.111]:46456 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751341AbWEZTlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:41:02 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,177,1146466800"; 
   d="scan'208"; a="38565041:sNHT23521000"
Date: Fri, 26 May 2006 19:31:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused o_flags from do_shmat
Message-ID: <Pine.LNX.4.64.0605261929580.24818@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 May 2006 19:41:01.0056 (UTC) FILETIME=[514A1000:01C680FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused variable o_flags from do_shmat.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 ipc/shm.c |    3 ---
 1 file changed, 3 deletions(-)

--- 2.6.17-rc5/ipc/shm.c	2006-05-25 03:43:36.000000000 +0100
+++ linux/ipc/shm.c	2006-05-26 17:55:29.000000000 +0100
@@ -698,7 +698,6 @@ long do_shmat(int shmid, char __user *sh
 	int    err;
 	unsigned long flags;
 	unsigned long prot;
-	unsigned long o_flags;
 	int acc_mode;
 	void *user_addr;
 
@@ -725,11 +724,9 @@ long do_shmat(int shmid, char __user *sh
 
 	if (shmflg & SHM_RDONLY) {
 		prot = PROT_READ;
-		o_flags = O_RDONLY;
 		acc_mode = S_IRUGO;
 	} else {
 		prot = PROT_READ | PROT_WRITE;
-		o_flags = O_RDWR;
 		acc_mode = S_IRUGO | S_IWUGO;
 	}
 	if (shmflg & SHM_EXEC) {
