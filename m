Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318427AbSGSCMr>; Thu, 18 Jul 2002 22:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318429AbSGSCMr>; Thu, 18 Jul 2002 22:12:47 -0400
Received: from jalon.able.es ([212.97.163.2]:56788 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318427AbSGSCMq>;
	Thu, 18 Jul 2002 22:12:46 -0400
Date: Fri, 19 Jul 2002 04:15:38 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>, rwhron@earthlink.net
Subject: [PATCHSET] Linux 2.4.19-rc1-jam1
Message-ID: <20020719021538.GA1734@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI al...

BEWARE: this kernel probably will eat your disk and your dog, but anyways...
Problems:
- I could not merge the Promise part of ide-convert-10 (due to a big update
  of in-kernel code), so I just dropped it. So Promise users are out of the
  marketshare. If things go this way, perhaps I will have to drop ide-10.
- I have added again the scalable-timers and irqrate-limiting patches.
  My box hangs on rmmod'ing modules with irqrate applied (SMP box, perhaps is
  a locking problem and UP is safe...), even without bproc. It also happened
  in previous releases, but I did not notice till recently. So irqrate
  improves latency, but kills the box ;).

The idea is to easy the way for Randy Hron to compare:
- rc2
- rc2-aa1
- rc2-jam1 minus irqrate == rc2-aa1 plus smptimers (that I think will not
  make a big difference)
- rc2-jam1 full == rc2-aa1 + smptimers + irqrate (if you don't rmmod anything...)

I hope this is usefull.

Get it at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-rc2-jam1.tar.bz2

TIA

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.8mdk)
