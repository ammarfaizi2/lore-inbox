Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313224AbSDJPFQ>; Wed, 10 Apr 2002 11:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313200AbSDJPDq>; Wed, 10 Apr 2002 11:03:46 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:17156 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313207AbSDJPDR>; Wed, 10 Apr 2002 11:03:17 -0400
Message-ID: <3CB45304.10707@namesys.com>
Date: Wed, 10 Apr 2002 18:58:12 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bugfixes 11 of 13, please apply
Content-Type: multipart/mixed;
 boundary="------------050601040609000906020000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050601040609000906020000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050601040609000906020000
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 11 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 11 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13280 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 248664D1B33; Wed, 10 Apr 2002 15:21:51 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:51 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 11 of 13
Message-ID: <20020410152151.A20911@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch removes one tail_conversion object out of build list,
because it was specified twice. (noticed by Jeff Garzik)

===== fs/reiserfs/Makefile 1.5 vs 1.6 =====
--- 1.5/fs/reiserfs/Makefile	Tue Feb  5 18:28:32 2002
+++ 1.6/fs/reiserfs/Makefile	Thu Mar 28 15:50:18 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := reiserfs.o
 obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
-lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o item_ops.o ioctl.o procfs.o
+lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o item_ops.o ioctl.o procfs.o
 
 obj-m   := $(O_TARGET)
 



--------------050601040609000906020000--

