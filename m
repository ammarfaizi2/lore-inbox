Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWBTEYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWBTEYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 23:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWBTEYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 23:24:35 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:41402 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932608AbWBTEYe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 23:24:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I9/qsop3WZYcJZvTK8WqfMBbViy5efoo75vB2S41bzN8dbOTHqdttbu41n3BmcdkHULhJi4DgGH7h1rYxRSK2VU30pVM1PgsIXQdILR2W0CmK6mhj2E9Ok0MD/7uVCUduVKTjGZwS+rPAK6/c60Y1dk/qxasW7zRYVceb/HspkY=
Message-ID: <489ecd0c0602192024o2a136ddera294876ea8fd44a5@mail.gmail.com>
Date: Mon, 20 Feb 2006 12:24:34 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] Fix undefined symbols for nommu architecture
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  This is a patch to add or export some undefined symbols in nommu
architectures (mm/nommu.c).  Based on latest mm-tree. Following
symbols are added: vmap, vunmap, randomize_va_space.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

Index: git/linux-2.6/mm/nommu.c
===================================================================
--- git.orig/linux-2.6/mm/nommu.c	2006-02-17 17:40:34.000000000 +0800
+++ git/linux-2.6/mm/nommu.c	2006-02-20 12:09:32.000000000 +0800
@@ -57,7 +57,10 @@
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(vmalloc_32);
+EXPORT_SYMBOL(vmap);
+EXPORT_SYMBOL(vunmap);

+int randomize_va_space = 0;
 /*
  * Handle all mappings that got truncated by a "truncate()"
  * system call.

--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
