Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279005AbRKFJlE>; Tue, 6 Nov 2001 04:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKFJkz>; Tue, 6 Nov 2001 04:40:55 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:52379 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S278985AbRKFJkh>;
	Tue, 6 Nov 2001 04:40:37 -0500
Date: Tue, 6 Nov 2001 18:40:33 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.14: invalidate: busy buffer and BUG
Message-ID: <Pine.LNX.4.30.0111061832510.1178-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha DP264, gcc 3.0.1 compiled.

After some testing and some work, got:

kernel: invalidate: busy buffer

Right after dismounting an ext2 diskette.

Attempting to remount the diskette resulted in:

kernel: kernel BUG at ll_rw_blk.c:660!
kernel: mount(1238): Kernel Bug 1
kernel: pc = [__make_request+2352/2368]  ra = [__make_request+2340/2368]  ps = 0000    Not tainted

Note that I got this once under 2.4.12 also.

I don't have time to run ksymoops right now.

The one from 2.4.12 was:

kernel: kernel BUG at buffer.c:664!
kernel: mdir(27124): Kernel Bug 1
kernel: pc = [invalidate_bdev+448/464]  ra = [invalidate_bdev+436/464]  ps = 0000    Not tainted


