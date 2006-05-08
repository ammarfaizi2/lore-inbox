Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWEHJRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWEHJRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 05:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWEHJRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 05:17:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18890 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751007AbWEHJRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 05:17:35 -0400
Date: Mon, 8 May 2006 14:45:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [RT PATCH] fix futex compilation (rt20)
Message-ID: <20060508091535.GB6081@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I needed this patch to compile and boot rt20 on x86_64. Just FYI.

Thanks
Dipankar

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>

diff -puN kernel/futex_compat.c~fix-futex-compile kernel/futex_compat.c
--- linux-2.6.16-rt20/kernel/futex_compat.c~fix-futex-compile	2006-05-08 13:59:53.000000000 +0530
+++ linux-2.6.16-rt20-dipankar/kernel/futex_compat.c	2006-05-08 14:01:02.000000000 +0530
@@ -137,5 +137,5 @@ asmlinkage long compat_sys_futex(u32 __u
 	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
 		val2 = (int) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
 }

_
