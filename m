Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSJHTNn>; Tue, 8 Oct 2002 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbSJHTNf>; Tue, 8 Oct 2002 15:13:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27408 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261310AbSJHTIK>; Tue, 8 Oct 2002 15:08:10 -0400
Subject: PATCH: fix telephony for tqueue
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:05:20 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzfU-0004uy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/telephony/ixj.c linux.2.5.41-ac1/drivers/telephony/ixj.c
--- linux.2.5.41/drivers/telephony/ixj.c	2002-10-07 22:12:26.000000000 +0100
+++ linux.2.5.41-ac1/drivers/telephony/ixj.c	2002-10-08 00:54:34.000000000 +0100
@@ -260,7 +260,6 @@
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/tqueue.h>
 #include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/timer.h>
