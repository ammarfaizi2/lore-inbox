Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUDMHkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 03:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUDMHkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 03:40:02 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:47540 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262503AbUDMHj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 03:39:56 -0400
Date: Tue, 13 Apr 2004 00:39:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Benchmarking objrmap under memory pressure
Message-ID: <1130000.1081841981@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UP Athlon 2100+ with 512Mb of RAM. Rebooted clean before each test
then did "make clean; make vmlinux; make clean". Then I timed a
"make -j 256 vmlinux" to get some testing under mem pressure. 

I was trying to test the overhead of objrmap under memory pressure,
but it seems it's actually distinctly negative overhead - rather pleasing
really ;-) 

2.6.5
225.18user 30.05system 6:33.72elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (37590major+2604444minor)pagefaults 0swaps

2.6.5-anon_mm
224.53user 26.00system 5:29.08elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (29127major+2577211minor)pagefaults 0swaps

2.6.5-aa5
224.35user 27.47system 5:35.09elapsed 75%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (28675major+2589179minor)pagefaults 0swaps

