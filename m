Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbUKPS1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUKPS1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUKPS1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:27:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:13216 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262072AbUKPS1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:27:13 -0500
Message-ID: <419A4382.6000800@osdl.org>
Date: Tue, 16 Nov 2004 10:14:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: printk arg. type warning
References: <419906C6.9020709@osdl.org> <1100627479.8191.6985.camel@hades.cambridge.redhat.com>
In-Reply-To: <1100627479.8191.6985.camel@hades.cambridge.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060005040003050401070604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060005040003050401070604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> '%ud'?

ergh.  Here it is, corrected.

fix printk argument type warning:
fs/jffs2/gc.c:832: warning: signed size_t format, different type arg 
(arg 3)

diffstat:=
  fs/jffs2/gc.c |    2 +-
  1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

--------------060005040003050401070604
Content-Type: text/x-patch;
 name="jffs2_gc_printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jffs2_gc_printk.patch"

diff -Naurp ./fs/jffs2/gc.c~jffs2_gc_printk ./fs/jffs2/gc.c
--- ./fs/jffs2/gc.c~jffs2_gc_printk	2004-11-15 10:02:00.966820400 -0800
+++ ./fs/jffs2/gc.c	2004-11-15 11:00:29.375461216 -0800
@@ -828,7 +828,7 @@ static int jffs2_garbage_collect_deletio
 				continue;
 			}
 			if (retlen != rawlen) {
-				printk(KERN_WARNING "jffs2_g_c_deletion_dirent(): Short read (%zd not %zd) reading header from obsolete node at %08x\n",
+				printk(KERN_WARNING "jffs2_g_c_deletion_dirent(): Short read (%zd not %u) reading header from obsolete node at %08x\n",
 				       retlen, rawlen, ref_offset(raw));
 				continue;
 			}

--------------060005040003050401070604--
