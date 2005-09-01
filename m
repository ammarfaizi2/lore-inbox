Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVIAPB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVIAPB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVIAPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:01:28 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:56801 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S965176AbVIAPB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:01:27 -0400
Date: Fri, 2 Sep 2005 00:01:19 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: remove typedef from struct flock
Message-Id: <20050902000119.7ee3db1a.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
References: <20050901035542.1c621af6.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed the following warning about MIPS.
Please apply.

Yoichi

  CC      arch/mips/kernel/offset.s
In file included from include/linux/fcntl.h:4,
                 from include/linux/fs.h:689,
                 from include/linux/mm.h:15,
                 from arch/mips/kernel/offset.c:15:
include/asm/fcntl.h:53: warning: useless keyword or type name in empty declaration

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/include/asm-mips/fcntl.h mm1/include/asm-mips/fcntl.h
--- mm1-orig/include/asm-mips/fcntl.h	2005-09-01 21:58:47.000000000 +0900
+++ mm1/include/asm-mips/fcntl.h	2005-09-01 23:38:18.000000000 +0900
@@ -42,7 +42,7 @@
 
 #ifndef __mips64
 
-typedef struct flock {
+struct flock {
 	short	l_type;
 	short	l_whence;
 	__kernel_off_t l_start;
