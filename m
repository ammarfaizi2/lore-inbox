Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVAGDKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVAGDKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAGDKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:10:53 -0500
Received: from mail.renesas.com ([202.234.163.13]:56967 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261277AbVAGDK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:10:29 -0500
Date: Fri, 07 Jan 2005 12:10:15 +0900 (JST)
Message-Id: <20050107.121015.1025216812.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>,
       Greg Banks <gnb@melbourne.sgi.com>, takata@linux-m32r.org
Subject: Re: [PATCH 2.6.10-mm2] oprofile: update m32r for api changes
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050107.115052.957827809.takata.hirokazu@renesas.com>
References: <20050107.115052.957827809.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry.
Please replace the previous patch with the following new one.

Thank you.

From: Hirokazu Takata <takata@linux-m32r.org>
Subject: [PATCH 2.6.10-mm2] oprofile: update m32r for api changes
Date: Fri, 07 Jan 2005 11:50:52 +0900 (JST)
> oprofile m32r arch updates, including some API changes.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> ---
> 
> diff -x CVS -ruNp b/arch/m32r/oprofile/init.c /work/kernel/linux-2.6_edge/source/arch/m32r/oprofile/init.c
> --- b/arch/m32r/oprofile/init.c	2004-12-25 06:33:50.000000000 +0900
> +++ /work/kernel/linux-2.6_edge/source/arch/m32r/oprofile/init.c	2004-11-15 11:56:19.000000000 +0900
> @@ -12,11 +12,8 @@
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  
> -extern void timer_init(struct oprofile_operations ** ops);
> -
> -int __init oprofile_arch_init(struct oprofile_operations ** ops)
> +void __init oprofile_arch_init(struct oprofile_operations * ops)
>  {
> -	return -ENODEV;
>  }
>  
-----------

oprofile m32r arch updates, including some API changes.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/arch/m32r/oprofile/init.c b/arch/m32r/oprofile/init.c
--- a/arch/m32r/oprofile/init.c	2004-12-25 06:33:50.000000000 +0900
+++ b/arch/m32r/oprofile/init.c	2005-01-07 12:02:15.000000000 +0900
@@ -12,14 +12,10 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 
-extern void timer_init(struct oprofile_operations ** ops);
-
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
+void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
-	return -ENODEV;
 }
 
-
 void oprofile_arch_exit(void)
 {
 }

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
