Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268274AbRGWP64>; Mon, 23 Jul 2001 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268275AbRGWP6q>; Mon, 23 Jul 2001 11:58:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1106 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268274AbRGWP6k>; Mon, 23 Jul 2001 11:58:40 -0400
Date: Mon, 23 Jul 2001 17:59:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723175907.N822@athlon.random>
In-Reply-To: <200107230508.AAA04621@ccure.karaya.com> <20010723175635.L822@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010723175635.L822@athlon.random>; from andrea@suse.de on Mon, Jul 23, 2001 at 05:56:35PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 05:56:35PM +0200, Andrea Arcangeli wrote:
> BTW, Linus the _below_ patches against mainline are needed to compile
> the x86 port with gcc-3_0-branch of yesterday, it is safe to include it
> in mainline:

here another one for reiserfs:

--- 2.4.7aa1/include/linux/reiserfs_fs.h.~1~	Mon Jul 23 06:56:14 2001
+++ 2.4.7aa1/include/linux/reiserfs_fs.h	Mon Jul 23 17:57:46 2001
@@ -828,7 +828,7 @@
 
 /* compose directory item containing "." and ".." entries (entries are
    not aligned to 4 byte boundary) */
-extern inline void make_empty_dir_item_v1 (char * body, __u32 dirid, __u32 objid,
+static inline void make_empty_dir_item_v1 (char * body, __u32 dirid, __u32 objid,
 					   __u32 par_dirid, __u32 par_objid)
 {
     struct reiserfs_de_head * deh;
@@ -859,7 +859,7 @@
 }
 
 /* compose directory item containing "." and ".." entries */
-extern inline void make_empty_dir_item (char * body, __u32 dirid, __u32 objid,
+static inline void make_empty_dir_item (char * body, __u32 dirid, __u32 objid,
 					__u32 par_dirid, __u32 par_objid)
 {
     struct reiserfs_de_head * deh;

Andrea
