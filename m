Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSDDDxM>; Wed, 3 Apr 2002 22:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSDDDxC>; Wed, 3 Apr 2002 22:53:02 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:65201 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S292130AbSDDDwx>;
	Wed, 3 Apr 2002 22:52:53 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15531.52715.356246.9467@argo.ozlabs.ibm.com>
Date: Thu, 4 Apr 2002 13:52:11 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] fix include/linux/smp.h
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch adds #include <linux/threads.h> to include/linux/smp.h,
because it (smp.h) needs the definition of NR_CPUS.  (It so happens
that include/asm-i386/smp.h includes <linux/threads.h>, but IMHO
include/linux/smp.h shouldn't rely on that).

Please apply this patch to your 2.5 tree.

Paul.

diff -urN linux-2.5/include/linux/smp.h pmac-2.5/include/linux/smp.h
--- linux-2.5/include/linux/smp.h	Sat Mar  9 22:26:16 2002
+++ pmac-2.5/include/linux/smp.h	Sat Mar 16 11:08:49 2002
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/compiler.h>
+#include <linux/threads.h>
 #include <asm/smp.h>
 
 /*
