Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSFUEkA>; Fri, 21 Jun 2002 00:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316232AbSFUEj7>; Fri, 21 Jun 2002 00:39:59 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9417 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316223AbSFUEj7>;
	Fri, 21 Jun 2002 00:39:59 -0400
Date: Fri, 21 Jun 2002 14:39:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipc/ statics
Message-Id: <20020621143913.6df40097.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch just makes some stuff in ipc/ static.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
 diff -ruN 2.5.24/ipc/msg.c 2.5.24-sfr.2/ipc/msg.c
--- 2.5.24/ipc/msg.c	Sat Sep 15 07:17:00 2001
+++ 2.5.24-sfr.2/ipc/msg.c	Fri Jun 21 14:31:10 2002
@@ -597,7 +597,7 @@
 	return 0;
 }
 
-int inline pipelined_send(struct msg_queue* msq, struct msg_msg* msg)
+static int inline pipelined_send(struct msg_queue* msq, struct msg_msg* msg)
 {
 	struct list_head* tmp;
 
@@ -706,7 +706,7 @@
 	return err;
 }
 
-int inline convert_mode(long* msgtyp, int msgflg)
+static int inline convert_mode(long* msgtyp, int msgflg)
 {
 	/* 
 	 *  find message of correct type.
diff -ruN 2.5.24/ipc/sem.c 2.5.24-sfr.2/ipc/sem.c
--- 2.5.24/ipc/sem.c	Thu May 30 05:12:31 2002
+++ 2.5.24-sfr.2/ipc/sem.c	Fri Jun 21 14:33:20 2002
@@ -441,7 +441,7 @@
 	}
 }
 
-int semctl_nolock(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_nolock(int semid, int semnum, int cmd, int version, union semun arg)
 {
 	int err = -EINVAL;
 
@@ -513,7 +513,7 @@
 	return err;
 }
 
-int semctl_main(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_main(int semid, int semnum, int cmd, int version, union semun arg)
 {
 	struct sem_array *sma;
 	struct sem* curr;
@@ -700,7 +700,7 @@
 	}
 }
 
-int semctl_down(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_down(int semid, int semnum, int cmd, int version, union semun arg)
 {
 	struct sem_array *sma;
 	int err;

