Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276737AbRJBWN3>; Tue, 2 Oct 2001 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276738AbRJBWNU>; Tue, 2 Oct 2001 18:13:20 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:3852 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276737AbRJBWNF>;
	Tue, 2 Oct 2001 18:13:05 -0400
Message-ID: <3BBA3C4E.6020604@si.rr.com>
Date: Tue, 02 Oct 2001 18:14:38 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.10-ac3: fs/cramfs/Makefile
Content-Type: multipart/mixed;
 boundary="------------080505090700010300000206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505090700010300000206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
    The attached patch against 2.4.10-ac3 addresses the following issue 
since 2.4.9-ac17:

depmod: *** Unresolved symbols in 
/lib/modules/2.4.9-ac17/kernel/fs/cramfs/cramfs/cramfs.o
depmod:  zlib_fs_inflateInit_
depmod:  zlib_fs_inflateEnd
depmod:  zlib_fs_inflate_workspacesize
depmod:  zlib_fs_inflate
depmod:  zlib_fs_inflateReset

Regards,
Frank

--------------080505090700010300000206
Content-Type: text/plain;
 name="CRAMFS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CRAMFS"

--- fs/cramfs/Makefile.old	Tue Oct  2 17:44:56 2001
+++ fs/cramfs/Makefile	Tue Oct  2 17:46:51 2001
@@ -4,7 +4,7 @@
 
 O_TARGET := cramfs.o
 
-obj-y  := inode.o uncompress.o
+obj-y  := inode.o uncompress.o ../inflate_fs/inflate_fs.o
 
 obj-m := $(O_TARGET)
 

--------------080505090700010300000206--

