Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWCHLeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWCHLeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWCHLeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:34:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14344 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932471AbWCHLep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:34:45 -0500
Date: Wed, 8 Mar 2006 12:34:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org, ericvh@ericvh.myip.org
Subject: [-mm patch] fs/9p/fcprint.c: make 2 functions static
Message-ID: <20060308113443.GG4006@stusta.de>
References: <20060307021929.754329c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc3-mm2:
>...
> +v9fs-print-9p-messages.patch
>...
>  Misc updates and fixes
>...


This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/9p/fcprint.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc5-mm3-full/fs/9p/fcprint.c.old	2006-03-08 12:31:26.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/fs/9p/fcprint.c	2006-03-08 12:31:49.000000000 +0100
@@ -88,7 +88,7 @@
 	return snprintf(buf, buflen, "%s%03o", b, perm&077);
 }
 
-int
+static int
 v9fs_printstat(char *buf, int buflen, struct v9fs_stat *st, int extended)
 {
 	int n;
@@ -120,7 +120,7 @@
 	return n;
 }
 
-int
+static int
 v9fs_dumpdata(char *buf, int buflen, u8 *data, int datalen)
 {
 	int i, n;

