Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSIAGqj>; Sun, 1 Sep 2002 02:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSIAGqi>; Sun, 1 Sep 2002 02:46:38 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:28352 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S316213AbSIAGqi>; Sun, 1 Sep 2002 02:46:38 -0400
Subject: 2.5.33 OSS compile fix
From: Nicholas Miell <nmiell@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Aug 2002 23:51:00 -0700
Message-Id: <1030863061.21053.18.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/ptrace.h now needs task_struct from sched.h, which is
breaking things that include ptrace.h before sched.h.

As far as I can tell, OSS doesn't need ptrace.h anyway, so this patch
removes the #include altogether. Somebody else can deal with ptrace.h
itself.

--- linux-2.5-build/sound/oss/os.h.~1~	Sun Feb 10 18:50:17 2002
+++ linux-2.5-build/sound/oss/os.h	Sat Aug 31 23:33:07 2002
@@ -18,7 +18,6 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/param.h>
-#include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>



