Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSK0Xgd>; Wed, 27 Nov 2002 18:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSK0Xgd>; Wed, 27 Nov 2002 18:36:33 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:16549 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S264940AbSK0Xgd>; Wed, 27 Nov 2002 18:36:33 -0500
Date: Wed, 27 Nov 2002 18:36:39 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.50 : arch/i386/mm/hugetlbpage.c
Message-ID: <Pine.LNX.4.44.0211271833310.2856-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patches addresses a prototype parse error. 
Please review for inclusion.

Regards,
Frank

--- linux/arch/i386/mm/hugetlbpage.c.old	Wed Nov 27 18:31:44 2002
+++ linux/arch/i386/mm/hugetlbpage.c	Wed Nov 27 18:31:38 2002
@@ -607,7 +607,7 @@
 	return (int) htlbzone_pages;
 }
 
-int hugetlb_sysctl_handler(ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
+int hugetlb_sysctl_handler(struct ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
 {
 	proc_dointvec(table, write, file, buffer, length);
 	htlbpage_max = set_hugetlb_mem_size(htlbpage_max);

