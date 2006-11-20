Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933877AbWKTC1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933877AbWKTC1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933884AbWKTC1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:27:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45585 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933883AbWKTCYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:14 -0500
Date: Mon, 20 Nov 2006 03:24:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.or
Subject: [-mm patch] make ext2_get_blocks() static
Message-ID: <20061120022413.GN31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
> +ext2-reservations.patch
>...
>  Port the ext3 reservations code into ext2.
>...

This patch makes the needlessly global ext2_get_blocks() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/ext2/inode.c.old	2006-11-20 01:35:58.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/ext2/inode.c	2006-11-20 01:36:08.000000000 +0100
@@ -574,10 +574,10 @@
  * return = 0, if plain lookup failed.
  * return < 0, error case.
  */
-int ext2_get_blocks(struct inode *inode,
-		sector_t iblock, unsigned long maxblocks,
-		struct buffer_head *bh_result,
-		int create)
+static int ext2_get_blocks(struct inode *inode,
+			   sector_t iblock, unsigned long maxblocks,
+			   struct buffer_head *bh_result,
+			   int create)
 {
 	int err = -EIO;
 	int offsets[4];

