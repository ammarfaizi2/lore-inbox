Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbTGCKYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbTGCKYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:24:52 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:49298 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S265797AbTGCKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:24:49 -0400
Message-ID: <3F0407D1.8060506@freemail.hu>
Date: Thu, 03 Jul 2003 12:39:13 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
Content-Type: multipart/mixed;
 boundary="------------050200080000050701060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200080000050701060906
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

fs/jfs/xattr.c does not compile after applying your .74-mm1
because of a simple typo. Fix is attached.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.


--------------050200080000050701060906
Content-Type: text/plain;
 name="jfs-xattr-typo-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jfs-xattr-typo-fix.patch"

--- fs/jfs/xattr.c~	2003-07-03 12:35:32.000000000 +0200
+++ fs/jfs/xattr.c	2003-07-03 12:35:32.000000000 +0200
@@ -1028,7 +1028,7 @@
 	err = __jfs_listxattr(dentry->d_inode, data, buf_size);
 	up(&dentry->d_inode->i_sem);
 
-	rerturn err;
+	return err;
 }
 
 int jfs_removexattr(struct dentry *dentry, const char *name)

--------------050200080000050701060906--

