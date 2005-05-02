Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVEBByK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVEBByK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVEBBx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:53:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41744 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261678AbVEBBrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:19 -0400
Date: Mon, 2 May 2005 03:47:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/mcdx.c: make code static
Message-ID: <20050502014717.GD3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

 drivers/cdrom/mcdx.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

--- linux-2.6.12-rc2-mm2-full/drivers/cdrom/mcdx.c.old	2005-04-10 02:16:00.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/cdrom/mcdx.c	2005-04-10 02:18:28.000000000 +0200
@@ -107,20 +107,20 @@
    The _direct_ size is the number of sectors we're allowed to skip
    directly (performing a read instead of requesting the new sector
    needed */
-const int REQUEST_SIZE = 800;	/* should be less then 255 * 4 */
-const int DIRECT_SIZE = 400;	/* should be less then REQUEST_SIZE */
+static const int REQUEST_SIZE = 800;	/* should be less then 255 * 4 */
+static const int DIRECT_SIZE = 400;	/* should be less then REQUEST_SIZE */
 
 enum drivemodes { TOC, DATA, RAW, COOKED };
 enum datamodes { MODE0, MODE1, MODE2 };
 enum resetmodes { SOFT, HARD };
 
-const int SINGLE = 0x01;	/* single speed drive (FX001S, LU) */
-const int DOUBLE = 0x02;	/* double speed drive (FX001D, ..? */
-const int DOOR = 0x04;		/* door locking capability */
-const int MULTI = 0x08;		/* multi session capability */
+static const int SINGLE = 0x01;		/* single speed drive (FX001S, LU) */
+static const int DOUBLE = 0x02;		/* double speed drive (FX001D, ..? */
+static const int DOOR = 0x04;		/* door locking capability */
+static const int MULTI = 0x08;		/* multi session capability */
 
-const unsigned char READ1X = 0xc0;
-const unsigned char READ2X = 0xc1;
+static const unsigned char READ1X = 0xc0;
+static const unsigned char READ2X = 0xc1;
 
 
 /* DECLARATIONS ****************************************************/
@@ -210,9 +210,7 @@
  	repeated here to show what's going on.  And to sense, if they're
 	changed elsewhere. */
 
-/* declared in blk.h */
-int mcdx_init(void);
-void do_mcdx_request(request_queue_t * q);
+static int mcdx_init(void);
 
 static int mcdx_block_open(struct inode *inode, struct file *file)
 {
@@ -569,7 +567,7 @@
 	}
 }
 
-void do_mcdx_request(request_queue_t * q)
+static void do_mcdx_request(request_queue_t * q)
 {
 	struct s_drive_stuff *stuffp;
 	struct request *req;
@@ -1028,7 +1026,7 @@
 	return 0;
 }
 
-void __exit mcdx_exit(void)
+static void __exit mcdx_exit(void)
 {
 	int i;
 
@@ -1075,7 +1073,7 @@
 
 /* Support functions ************************************************/
 
-int __init mcdx_init_drive(int drive)
+static int __init mcdx_init_drive(int drive)
 {
 	struct s_version version;
 	struct gendisk *disk;
@@ -1261,7 +1259,7 @@
 	return 0;
 }
 
-int __init mcdx_init(void)
+static int __init mcdx_init(void)
 {
 	int drive;
 	xwarn("Version 2.14(hs) \n");

