Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130937AbRBTXOp>; Tue, 20 Feb 2001 18:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbRBTXOf>; Tue, 20 Feb 2001 18:14:35 -0500
Received: from jalon.able.es ([212.97.163.2]:31472 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130937AbRBTXOa>;
	Tue, 20 Feb 2001 18:14:30 -0500
Date: Wed, 21 Feb 2001 00:14:06 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: swap still stuck
Message-ID: <20010221001406.A1035@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

I seem to have again a problem that was talked about on the list, but I thought
it was yet corrected with some VM constants balancing.

I run 2.4.1-ac19-SMP. System works fine, but after a couple kernel untars
and an open netscape, starts to swap. Read buffers are still there. Do the
untars, launch netscape and instead of trashing buffers takes a bite on
swap.

Then you let netscape (what a mem hog example...) forgotten and start to do
some terminal work, config kernel, build, etc. Return to netscape and it is
much less responsible and disk starts to crawl to un-swap netscape. And
my 200 Mb of read buffers are still in main memory...

Is there any utility to say to kernel TROW AWAY YOUR READ BUFFERS ?. It looks
like it does not know how to do it.

I have finished some work session with just the last rxvt on screen, a mem like:

werewolf:~/soft/snd/alsa/alsa-utils# free
             total       used       free     shared    buffers     cached
Mem:        255524     244888      10636          0      94816      97052
-/+ buffers/cache:      53020     202504
Swap:       152576       9024     143552

but swap being 50Mb.

Why system does not try to drop read buffer pages before swapping ?


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac19 #1 SMP Mon Feb 19 21:52:31 CET 2001 i686

