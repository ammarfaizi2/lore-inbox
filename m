Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbQLXQqy>; Sun, 24 Dec 2000 11:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQLXQqp>; Sun, 24 Dec 2000 11:46:45 -0500
Received: from www.wen-online.de ([212.223.88.39]:23045 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130026AbQLXQq1>;
	Sun, 24 Dec 2000 11:46:27 -0500
Date: Sun, 24 Dec 2000 17:13:44 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andreas Franck <afranck@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
In-Reply-To: <00122320144900.00517@dg1kfa.ampr.org>
Message-ID: <Pine.Linu.4.10.10012241656500.439-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Andreas Franck wrote:

> Hi Mike, hello linux-kernel audience,
> 
> > I had the same, with the last few snapshots I tried, but 20001218 seems
> > to work ok.
> > dmesg|head -1
> > Linux version 2.4.0-test13ikd (root@el-kaboom) (gcc version gcc-2.97
> > 20001218 (experimental)) #18 Sat Dec 23 17:43:29 CET 2000
> 
> Hmm, would have been nice, but it crashes here with 20001222, nevertheless. 
> For which CPU do you have your kernel configured? It might be a CPU specific 
> issue, I'll try to compile for Pentium I and 486, now, and report my results.

Yes, hmm indeed.  Try these two things.

1. make DECLARE_MUTEX_LOCKED(sem) in bdflush_init() static.
2. compile with frame pointers.  (normal case for IKD)

My IKD tree works with either option, but not with neither.  I haven't
figured out why yet.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
