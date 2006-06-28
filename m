Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWF1OPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWF1OPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWF1OPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:15:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59596 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423343AbWF1OPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:15:00 -0400
Message-ID: <44A28EDE.5070707@fr.ibm.com>
Date: Wed, 28 Jun 2006 16:14:54 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-mm3
References: <20060627015211.ce480da6.akpm@osdl.org>
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: [s390] fix compile issue when stacktrace is not configured

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 arch/s390/kernel/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6.17-mm3/arch/s390/kernel/Makefile
===================================================================
--- 2.6.17-mm3.orig/arch/s390/kernel/Makefile
+++ 2.6.17-mm3/arch/s390/kernel/Makefile
@@ -4,7 +4,7 @@

 EXTRA_AFLAGS	:= -traditional

-obj-y	:=  bitmap.o traps.o time.o process.o stacktrace.o \
+obj-y	:=  bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
             semaphore.o s390_ext.o debug.o profile.o irq.o reipl_diag.o

@@ -21,6 +21,7 @@ obj-$(CONFIG_COMPAT)		+= compat_linux.o
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o

 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
+obj-$(CONFIG_STACKTRACE)	+= stacktrace.o

 # Kexec part
 S390_KEXEC_OBJS := machine_kexec.o crash.o
