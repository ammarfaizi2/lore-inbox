Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318374AbSGRWk0>; Thu, 18 Jul 2002 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318375AbSGRWk0>; Thu, 18 Jul 2002 18:40:26 -0400
Received: from pC19EBE1C.dip.t-dialin.net ([193.158.190.28]:47620 "EHLO
	tigra.home") by vger.kernel.org with ESMTP id <S318374AbSGRWkZ>;
	Thu, 18 Jul 2002 18:40:25 -0400
Date: Fri, 19 Jul 2002 00:44:40 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.19-rc2-ac2: init_task.c: missing braces around initializer
Message-ID: <20020718224440.GA21439@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

~/compile/steel/linux-2.4.19-rc2-ac2$ make bzImage modules -s
init_task.c:23: warning: missing braces around initializer
init_task.c:23: warning: (near initialization for `init_task_union.task.thread.io_bitmap')
init_task.c:23: warning: braces around scalar initializer
init_task.c:23: warning: (near initialization for `init_task_union.task.thread.io_bitmap[1]')


--- linux-2.4.19-rc2-ac4/include/asm-i386/processor.h   Fri Jul 19 00:37:45 2002
+++ linux-2.4.19-rc2-ac4/include/asm-i386/processor.h~  Fri Jul 19 00:38:48 2002
@@ -393,7 +393,7 @@
        { [0 ... 7] = 0 },      /* debugging registers */       \
        0, 0, 0,                                                \
        { { 0, }, },            /* 387 state */                 \
-       0,0,0,0,0,0,                                            \
+       0,0,0,0,0,                                              \
        0,{~0,}                 /* io permissions */            \
 }
 

