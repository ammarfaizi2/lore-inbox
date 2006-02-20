Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWBTGdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWBTGdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWBTGdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:33:04 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:42625 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932667AbWBTGdC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:33:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lnViGomZfxfvOrBqlZXA0sxSL5cf/77hU/bIWXzIXcV92Ev5ffLwMRcWEEHbFErw4BPg3fSKUVzxpc6GEL8bBIi/el6lKjYFfnGrzA2IJmcB0a3Mgg+rEUjSUc/drvSIu1vRWf6WgCBv9f6cqVcLU9siHATh+I/GKjcxeSwVy/k=
Message-ID: <489ecd0c0602192233y1cbd7d27s47755a14db115a79@mail.gmail.com>
Date: Mon, 20 Feb 2006 14:33:01 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] Fix undefined symbols for nommu architecture --improved version
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 This is the improved version of my last email patch.  Thanks for
Andrew's advice. The "randomize_va_space" is defined as a macro
instead of an variable. I saw the previous patch is accepted, is it OK
to resend a modified patch?

 To add or export some undefined symbols in nommu
architectures (mm/nommu.c).  Based on latest mm-tree.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

Index: git/linux-2.6/mm/nommu.c
===================================================================
--- git.orig/linux-2.6/mm/nommu.c       2006-02-17 17:40:34.000000000 +0800
+++ git/linux-2.6/mm/nommu.c    2006-02-20 12:09:32.000000000 +0800
@@ -57,7 +57,10 @@
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(vmalloc_32);
+EXPORT_SYMBOL(vmap);
+EXPORT_SYMBOL(vunmap);

+#define randomize_va_space 0
 /*
 * Handle all mappings that got truncated by a "truncate()"
 * system call.
--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
