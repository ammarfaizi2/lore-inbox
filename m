Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSKKL7B>; Mon, 11 Nov 2002 06:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbSKKL7A>; Mon, 11 Nov 2002 06:59:00 -0500
Received: from mta05bw.bigpond.com ([139.134.6.95]:32762 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S266682AbSKKL67>; Mon, 11 Nov 2002 06:58:59 -0500
Message-ID: <3DCF9D32.8070006@bigpond.com>
Date: Mon, 11 Nov 2002 23:06:10 +1100
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.47
References: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two failures to build a kernel for me - 1 new, one old:

New - undefined refs if CONFIG_CRYPTO is not set.

Old - undefined refs if aout is a module - use a patch from 2.5.46
(ignore the dates, I just hacked the previous one for an offset of 495):

--- a/kernel/ksyms.c	Tue Nov  5 16:33:06 2002
+++ b/kernel/ksyms.c	Tue Nov  5 16:36:40 2002
@@ -53,6 +53,7 @@
  #include <linux/percpu.h>
  #include <linux/smp_lock.h>
  #include <linux/dnotify.h>
+#include <linux/ptrace.h>
  #include <asm/checksum.h>

  #if defined(CONFIG_PROC_FS)
@@ -492,6 +495,7 @@
  #if !defined(__ia64__)
  EXPORT_SYMBOL(loops_per_jiffy);
  #endif
+EXPORT_SYMBOL(ptrace_notify);


  /* misc */

