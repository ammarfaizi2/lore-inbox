Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRBYO7y>; Sun, 25 Feb 2001 09:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129357AbRBYO7o>; Sun, 25 Feb 2001 09:59:44 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:14760 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S129346AbRBYO7d>;
	Sun, 25 Feb 2001 09:59:33 -0500
Date: Sun, 25 Feb 2001 15:59:29 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: linux swap freeze STILL in 2.4.x
Message-ID: <20010225155929.A371@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.2-ac3 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems linux-2.4 still freezes on out-of-memory situations:

I was using 2.4.2-ac3 SMP and had a fairly large background job that takes
hundreds of megabytes of memory, much more than I have:

Mem:        255296      81836     173460          0      10324      30608
Swap:        99992          0      99992

Usually I swapon ./swap some 512MB swapfile, but today I forgot it. When the
machine started to get sluggish I sent the process a -STOP signal.

Swap:        99992      99992          0

O.k, (I had about 12MB of main memory free (in the +/- buffers line of
free) and the machine was sluggish but workable for about five minutes. At
the instant I did a swapon ./swap the machine froze hard (no sysrq, no
ping etc...)

I thought these complete freezes on OOM-situations had been fixed in
2.4.x? Do I have to watch out for andrea's fix-2.4-oom patches?

;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
