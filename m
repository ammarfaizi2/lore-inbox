Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRKSJ5o>; Mon, 19 Nov 2001 04:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKSJ5Y>; Mon, 19 Nov 2001 04:57:24 -0500
Received: from Expansa.sns.it ([192.167.206.189]:31240 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276761AbRKSJ5M>;
	Mon, 19 Nov 2001 04:57:12 -0500
Date: Mon, 19 Nov 2001 10:57:12 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.15-pre6 warnings compiling reiserfs
Message-ID: <Pine.LNX.4.33.0111191054370.28426-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,

I am just compiling 2.4.15-pre6 with aa1 patch, to make some
etsts on a ultrasparc64 system used as proxy server.
compiling reiserfs support i get those warnings:

ct-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow
-ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs    -c -o item_ops.o item_ops.c
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h: In function
`le_key_k_offset':
In file included from item_ops.c:6:
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:526: warning:
passing arg 1 of `offset_v2_k_offset' discards `const' from pointer target
type
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h: In function
`le_key_k_type':
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:538: warning:
passing arg 1 of `offset_v2_k_type' discards `const' from pointer target
type
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h: In function
`make_empty_dir_item_v1':
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:971: warning: value
computed is not used
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:981: warning: value
computed is not used
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h: In function
`make_empty_dir_item':
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:1005: warning:
value computed is not used
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:1015: warning:
value computed is not used
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h: In function
`le_key_version':
/usr/src/linux-2.4.15-pre6/include/linux/reiserfs_fs.h:1763: warning:
passing arg 1 of `offset_v2_k_type' discards `const' from pointer target
type


In my configuration I enabled /proc/fs/reiserfs report. (still to try a
compilation with this option turned off)

Hope this helps

Luigi



