Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbUKOWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUKOWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKOWI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:08:58 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:64207 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261473AbUKOWIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:08:05 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc2: strange behavior on dual Opteron w/ NUMA
Date: Mon, 15 Nov 2004 23:06:15 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411152306.15606.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am observing a strange behavior of the 2.6.10-rc1-mm5 and 2.6.10-rc2 kernels 
on a dual-Opteron box with NUMA (Tyan Thunder K8W).  It occurs in specific 
conditions, but seems to be 100% reproducible.

The situation is the following: I run X with KDE 3.3.1 (SuSE binaries) on SuSE 
9.1 (x86-64), I run gkrellm in the background, I edit a text file using Kate, 
there's a Konqueror window open and at the same time I play OGG files using 
Noatun (not so unusual, I'd guess).  Then, after some time (variable), Kate 
suddenly starts to repeat the most recently typed character (I have to leave 
its window to stop this), Noatun stops playing and arts reports CPU overload.  
gkrellm also shows the sudden increase of CPU load (apparently, only one CPU 
is almost 100% loaded and the load sometimes "flows" from one CPU to the 
other).  It all takes about 10 seconds.  Then it calms down, and I can start 
playing music and typing again.  Sometimes Kate behaves normally, but every 
time it happens a CPU gets overloaded which causes Noatun to stop playing and 
CPU overload is reported (in such cases, the CPU is overloaded with _system_ 
load).  So far, it's happened every time I ran the box with one of the said 
kernels, and it can happen several times in a row (at random times).

It doesn't occur on the 2.6.10-rc1 kernel (for sure) and, AFAICT, it doesn't 
occur on the previous -mm kernels (I must admit I haven't tested them 
thoroughly on the dual box, though).  I also do not observe this kind of 
problems on a single-CPU box with a similar setup, but I usually don't use 
Noatun on it.

I suspect that this has been intorduced in 2.6.10-rc1-mm5, so if you have any 
ideas, please let me know.  If you need more information, please let me know 
too.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
