Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273450AbRIQCAc>; Sun, 16 Sep 2001 22:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273454AbRIQCAX>; Sun, 16 Sep 2001 22:00:23 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:61195 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S273453AbRIQCAG>;
	Sun, 16 Sep 2001 22:00:06 -0400
Message-ID: <3BA55985.8070708@si.rr.com>
Date: Sun, 16 Sep 2001 22:01:41 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.9-ac11: fs/jffs/inode-v23.c
Content-Type: multipart/mixed;
 boundary="------------070808080706020309090301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808080706020309090301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
     The following patch fixes the following compile error with 
2.4.9-ac11 . Please test. Thanks.

depmod: *** Unresolved symbols in 
/lib/modules/2.4.9-ac11/kernel/fs/jffs/jffs.o
depmod: jffs_min

Regards,
Frank

--------------070808080706020309090301
Content-Type: text/plain;
 name="INODEV23"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="INODEV23"

--- fs/jffs/inode-v23.c.old	Sun Sep 16 17:50:01 2001
+++ fs/jffs/inode-v23.c	Sun Sep 16 21:20:58 2001
@@ -1375,7 +1375,7 @@
 	 * -- prumpf
 	 */
 	
-	thiscount = jffs_min(c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
+	thiscount = min(c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
 
 	D3(printk (KERN_NOTICE "file_write(): down biglock\n"));
 	down(&c->fmc->biglock);
@@ -1466,7 +1466,7 @@
 
 		D3(printk("jffs_file_write(): new f_pos %ld.\n", (long)pos));
 
-		thiscount = jffs_min(c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
+		thiscount = min(c->fmc->max_chunk_size - sizeof(struct jffs_raw_inode), count);
 	}
  out:
 	D3(printk (KERN_NOTICE "file_write(): up biglock\n"));

--------------070808080706020309090301--

