Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVARK52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVARK52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVARK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:57:28 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:14035 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261255AbVARK4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:56:55 -0500
Date: Tue, 18 Jan 2005 12:57:16 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: [PATCH 4/5] reminder comment about register_ioctl32_conversion
Message-ID: <20050118105716.GD23127@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118072133.GB76018@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a split off from Andi's patch, so I didnt add my SOB here.

Signed-off-by: Andi Kleen <ak@muc.de>

Since its too early to deprecate (un)register_ioctl32_conversion,
add a comment for that time when we do.

diff -rup linux-2.6.10-orig/fs/compat.c linux-2.6.10-ioctl-sym/fs/compat.c
--- linux-2.6.10-orig/fs/compat.c	2005-01-18 10:58:33.609880024 +0200
+++ linux-2.6.10-ioctl-sym/fs/compat.c	2005-01-18 10:54:26.289478440 +0200
@@ -447,6 +452,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 	    (!filp->f_op->ioctl && !filp->f_op->unlocked_ioctl))
 		goto do_ioctl;
 
+	/* When register_ioctl32_conversion is gone remove this lock! -AK */
 	down_read(&ioctl32_sem);
 	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
 		if (t->cmd == cmd)
