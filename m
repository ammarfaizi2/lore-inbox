Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSKEPgA>; Tue, 5 Nov 2002 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbSKEPgA>; Tue, 5 Nov 2002 10:36:00 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:50884 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263986AbSKEPf7>; Tue, 5 Nov 2002 10:35:59 -0500
Cc: linux-kernel@vger.kernel.org
References: <3DC7AACD.2060909@bigpond.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Allan Duncan <allan.d@bigpond.com>
Subject: Re: 2.5.46 - missing symbol from binfmt_aout built as a module
Date: Tue, 05 Nov 2002 16:42:19 +0100
Message-ID: <87fzugauqs.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Duncan <allan.d@bigpond.com> writes:

> A new glitch since 2.5.45.
>
>  From the "make modules_install":
>
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.46/kernel/fs/binfmt_aout.o
> depmod: 	ptrace_notify
> make: *** [_modinst_post] Error 1

Regards, Olaf.

--- a/kernel/ksyms.c	Tue Nov  5 16:33:06 2002
+++ b/kernel/ksyms.c	Tue Nov  5 16:36:40 2002
@@ -53,6 +53,7 @@
 #include <linux/percpu.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/ptrace.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -492,6 +493,7 @@
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
+EXPORT_SYMBOL(ptrace_notify);
 
 
 /* misc */
