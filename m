Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSHLR3Y>; Mon, 12 Aug 2002 13:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSHLR21>; Mon, 12 Aug 2002 13:28:27 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:11025 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S318758AbSHLR1q>; Mon, 12 Aug 2002 13:27:46 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add sendfile() support to fatfs (3/3)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 13 Aug 2002 02:31:24 +0900
Message-ID: <87znvs7zmb.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds sendfile() support to fatfs.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5/fs/fat/file.c.orig	2002-08-11 17:16:26.000000000 +0900
+++ linux-2.5/fs/fat/file.c	2002-08-11 16:53:49.000000000 +0900
@@ -23,6 +23,7 @@
 	write:		fat_file_write,
 	mmap:		generic_file_mmap,
 	fsync:		file_fsync,
+	sendfile:	generic_file_sendfile,
 };
 
 struct inode_operations fat_file_inode_operations = {
