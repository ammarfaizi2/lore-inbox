Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTIYN2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTIYN2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:28:23 -0400
Received: from smtp3.vol.cz ([195.250.128.83]:31498 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id S261223AbTIYN2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:28:21 -0400
MIME-Version: 1.0
Subject: Data writting over the quota chage inote time
From: "Youza Youzovic" <youza@post.cz>
To: linux-kernel@vger.kernel.org
Date: Thu, 25 Sep 2003 15:28:19 +0200 (CEST)
Message-ID: <fc5f185ffdd49f6f4444747a24368d79@www4.mail.post.cz>
X-Mailer: Volny.cz Webmail2 1.36
X-Originating-Ip: 193.165.254.10
X-Originating-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98; T312461)
X-Priority: 3
X-MSMail-Priority: Normal
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find this "small" problem:

I set quota fo user "test" to 204 blocks.
and store one big file "test" with full size ( 204 blocks).
quota -v test
Disk quotas for user test (uid 1010): 
Filesystem blocks quota limit grace files quota limit grace
/dev/sdb1 204* 204 204 1 0 0 

and run command "stat test":
File: "test"
Size: 204800 Blocks: 408 IO Block: 
121234234 Regular File
Device: 811h/2065d Inode: 6300 Links: 1 
Access: (0644/-rw-r--r--) Uid:(1010/test) Gid:(0/root)
Access: Wed Aug 13 16:10:21 2003
Modify: Wed Aug 13 16:12:43 2003
Change: Wed Aug 13 16:12:43 2003

next I run command

echo "s" >> test; stat test 
File: "test"
Size: 204800 Blocks: 408 IO Block: 
121234234 Regular File
Device: 811h/2065d Inode: 6300 Links: 1 
Access: (0644/-rw-r--r--) Uid: (1010/test) Gid:(0/root)
Access: Wed Aug 13 16:10:21 2003
Modify: Wed Aug 13 16:14:38 2003
Change: Wed Aug 13 16:14:38 2003

the size is not change - this is OK !!
But Modify, and Change time is modified !!!

My system:
Linux kernel 2.4.21 from www.kernel.org

Thanx
youza

-- 
Potrebujete vice prostoru pro vase stranky?
Ptejte se na http://sluzby.volny.cz/cs/product/ftp_paid


