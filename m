Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRCXFEL>; Sat, 24 Mar 2001 00:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCXFEA>; Sat, 24 Mar 2001 00:04:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46864 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131581AbRCXFDu>; Sat, 24 Mar 2001 00:03:50 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Date: 23 Mar 2001 21:02:30 -0800
Organization: Transmeta Corporation
Message-ID: <99h9p6$2j9$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vbaelvp3bos.fsf@mozart.stat.wisc.edu> <20010322193549.D6690@unthought.net> <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>,
Kevin Buhr <buhr@stat.wisc.edu> wrote:
>
>The results speak for themselves:
>
>    CVS gcc 3.0:          Debian gcc 2.95.3:   RedHat gcc 2.96:
>                      
>    real    16m8.423s     real    8m2.417s     real    12m24.939s
>    user    15m23.710s    user    7m22.200s    user    10m14.420s
>    sys     0m48.730s     sys     0m41.040s    sys     2m13.910s 
>maps:    <250 lines           <250 lines          >3000 lines
>
>Obviously, the *real* problem is RedHat GCC 2.96.  If Linus bothers to
>write this patch (he probably already has),

Check out 2.4.3-pre7, I'd be interested to hear what the system time is
for that one.

It does seem like gcc-2.96 is kind of special, but considering how easy
it is to merge anonymous memory (most of the changes were cosmetic ones
to get nice ordering to make the merge trivial without having to
allocate a vma that never gets used etc), it's certainly worth doing.

		Linus
