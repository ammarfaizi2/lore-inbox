Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267169AbSLEAxR>; Wed, 4 Dec 2002 19:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbSLEAxR>; Wed, 4 Dec 2002 19:53:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267169AbSLEAxQ>;
	Wed, 4 Dec 2002 19:53:16 -0500
Message-ID: <3DEEA521.5080101@pobox.com>
Date: Wed, 04 Dec 2002 20:00:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix netlink compile breakage
References: <3DEEA2EF.3040004@pobox.com>
In-Reply-To: <3DEEA2EF.3040004@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------040400010001050401080802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040400010001050401080802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

More viro breakage.  I wonder if 'int i' is missing from several other 
files I did not compile...


--------------040400010001050401080802
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== net/netlink/netlink_dev.c 1.10 vs edited =====
--- 1.10/net/netlink/netlink_dev.c	Mon Dec  2 18:45:41 2002
+++ edited/net/netlink/netlink_dev.c	Wed Dec  4 19:58:43 2002
@@ -180,7 +180,7 @@
 	{"route6", 11},
 	{"ip6_fw", 13},
 	{"dnrtmsg", 13},
-}
+};
 
 static void __init make_devfs_entries (const char *name, int minor)
 {
@@ -192,6 +192,8 @@
 
 int __init init_netlink(void)
 {
+	int i;
+
 	if (register_chrdev(NETLINK_MAJOR,"netlink", &netlink_fops)) {
 		printk(KERN_ERR "netlink: unable to get major %d\n", NETLINK_MAJOR);
 		return -EIO;

--------------040400010001050401080802--

