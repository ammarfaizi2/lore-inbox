Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbTBYMD0>; Tue, 25 Feb 2003 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267940AbTBYMD0>; Tue, 25 Feb 2003 07:03:26 -0500
Received: from pinguin13.kwc.at ([193.228.81.158]:3055 "EHLO
	mail.hello-penguin.com") by vger.kernel.org with ESMTP
	id <S267938AbTBYMDZ>; Tue, 25 Feb 2003 07:03:25 -0500
Date: Tue, 25 Feb 2003 13:13:28 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: vm issues (2)
Message-ID: <20030225131328.A8651@smp.colors.kwc>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 1 7 18 27 40 41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The new kernel 2.4.21-pre4aa3 is running now, but the box behaves
similarly.  It still swaps quite a lot and much more than the rmap
vm.  Both servers are under the same load.

One difference is the amount of free memory:

 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in cs  us  sy  id
aa:
 0  7  0 5773620 202416 118076 2069716 5330 746  5330   766 4845 5597  12  14  74
rmap:
 0  0  0 3498044  13572   4144 4754596  74   0    75     6  642 598   5   3  92

The aa kernel keeps ~200MB out of 6GB of memory unused.  I'm not
sure, but if we could reduce it perhaps there would be much less
swapping.  Is there a way to achieve this?

Another notable difference between the two vm versions is that the
rmap vm maintains about 80% of memory on the active list and the
aa vm much less: between 4% and 12%.  The rmap vm must use more
CPU, but these servers have a lot of processing power so it is not
noticeable.

Cheers,

Dejan
