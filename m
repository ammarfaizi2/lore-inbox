Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTFNWJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTFNWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:09:14 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:17140 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261323AbTFNWJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:09:07 -0400
Date: Sat, 14 Jun 2003 15:23:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 fails compile (net/built-in.o)
Message-Id: <20030614152310.34613f68.akpm@digeo.com>
In-Reply-To: <200306142203.SAA24912@clem.clem-digital.net>
References: <200306142203.SAA24912@clem.clem-digital.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2003 22:22:56.0543 (UTC) FILETIME=[8146FAF0:01C332C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements <clem@clem.clem-digital.net> wrote:
>
> FYI:
> 
> 
>   CPP     arch/i386/vmlinux.lds.s
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `flow_cache_init':
> net/built-in.o(.init.text+0x282): undefined reference to `register_cpu_notifier'


--- 25/net/core/flow.c~flow-warning-fix	2003-06-14 15:13:37.000000000 -0700
+++ 25-akpm/net/core/flow.c	2003-06-14 15:14:04.000000000 -0700
@@ -18,6 +18,7 @@
 #include <linux/percpu.h>
 #include <linux/bitops.h>
 #include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <net/flow.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>

