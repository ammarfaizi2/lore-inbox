Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273054AbRI3IBl>; Sun, 30 Sep 2001 04:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRI3IBb>; Sun, 30 Sep 2001 04:01:31 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:62336 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S273054AbRI3IBU>; Sun, 30 Sep 2001 04:01:20 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200109300801.JAA10353@mauve.demon.co.uk>
Subject: Mad OOM killer on the loose...
To: linux-kernel@vger.kernel.org
Date: Sun, 30 Sep 2001 09:01:44 +0100 (BST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to resolve a deeply bizarre oops (happened when dialing one
ISP but not another) on my athlon 550/200M ram:

I downloaded and compiled 2.4.10.
After compiling, my first impression was that it wasn't as snappy as
2.4.0-test7 that I'd been using before.
Second impression was that as I started running edonkey (p2p file
sharing program) root-owned processes were getting killed, in order to 
cache the data being read by edonkey, while hashig it's temporary files.
(these files have lots of holes, if that might be important)

There were about 40M worth of real programs running, and 150Mb available
for cache.
9 times out of 10, edonkey will now crash on startup (it's RSS is only
perhaps 4M), often taking other processes some owned by root with it.
When this first manifested, I saw 
 __alloc_pages: 0-order allocation failed (gfp=0x1d 2/0) from c012a718
(seems to be the address of _alloc_pages)
Sep 30 07:55:25 mauve last message repeated 4 times

While trying to see if I could fix this somewhat, I found someone had
absconded with /proc/sys/vm/freepages.
Is there any documentation on the new way?
(I was reading Documentation/sysctl/vm.txt)

P
(I was reading Documentation/sys/vm.txt
