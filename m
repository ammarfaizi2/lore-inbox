Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSG2GPx>; Mon, 29 Jul 2002 02:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318039AbSG2GPx>; Mon, 29 Jul 2002 02:15:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:13971 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318038AbSG2GPx>;
	Mon, 29 Jul 2002 02:15:53 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.56787.18191.406577@argo.ozlabs.ibm.com>
Date: Mon, 29 Jul 2002 16:16:51 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix include/linux/timer.h compile
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/timer.h needs to include <linux/stddef.h>
to get the definition of NULL.

Paul.

diff -urN linux-2.5/include/linux/timer.h pmac-2.5/include/linux/timer.h
--- linux-2.5/include/linux/timer.h	Mon Jun 24 23:59:11 2002
+++ pmac-2.5/include/linux/timer.h	Thu Jul 25 21:58:42 2002
@@ -2,6 +2,7 @@
 #define _LINUX_TIMER_H
 
 #include <linux/config.h>
+#include <linux/stddef.h>
 #include <linux/list.h>
 
 /*
