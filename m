Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265520AbUFID6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbUFID6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 23:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUFID6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 23:58:42 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:46861 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265520AbUFID6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 23:58:40 -0400
Message-ID: <1086744927.40c6695f9c361@vds.kolivas.org>
Date: Wed,  9 Jun 2004 11:35:27 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slow down in 2.6 vs 2.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Phy

You said:
Over the last two days I have been struggling with
understanding why 2.6.x kernel is slower than
2.4.21/23 kernels.  I think I have a test case which
demostrates this issue.
make times:

2.4.21:
323.68user 56.07system 6:35.77elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (3138783major+3818347minor)pagefaults
0swaps

2.6.7-rc3-s63 (SPA scheduler):
334.01user 69.86system 7:01.47elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (13301major+6931745minor)pagefaults
0swaps

2.6.7-rc3:
336.17user 68.41system 7:02.47elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (13301major+6931745minor)pagefaults
0swaps


----
Your 2.4 compile is showing a massive number of major page faults. Just how big
is this compile you do? Can you try running the 2.6 compile with 

echo 100 > /proc/sys/vm/swappiness

Con

