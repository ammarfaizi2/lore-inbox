Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbTF1UiF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTF1Uhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:37:47 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:60178 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S265405AbTF1UhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:37:17 -0400
Subject: Patch 2.4.21 use propper type for pid -III
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jun 2003 22:51:31 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19WMfT-000Cqd-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- 
Hi liste,
this is a small patch to fix functions that do not use the 
correct type for pid. daniele bellucci and i have worked this 
out. 

walter


--- include/linux/fs.h.org	2003-06-28 21:50:30.000000000 +0200
+++ include/linux/fs.h	2003-06-28 21:48:53.000000000 +0200
@@ -516,7 +516,7 @@
 };
 
 struct fown_struct {
-	int pid;		/* pid or -pgrp where SIGIO should be sent */
+	pid_t pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
