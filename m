Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319097AbSHMX1Q>; Tue, 13 Aug 2002 19:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319131AbSHMX0N>; Tue, 13 Aug 2002 19:26:13 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25880 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319097AbSHMXZn>; Tue, 13 Aug 2002 19:25:43 -0400
Date: Wed, 14 Aug 2002 01:30:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <20020813233007.GV14394@dualathlon.random>
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com> <200208131729.50127.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208131729.50127.habanero@us.ibm.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 05:29:50PM -0500, Andrew Theurer wrote:
> > 2.4.19-rc3aa3:
> > 
> > No Balance    Ingo IRQ Balance        Andrea IRQ Balance
> > 794 Mbps              787 Mbps                        792 Mbps
> > 
> > With hyperthreading:
> > 
> > No Balance    Ingo IRQ Balance        Andrea IRQ Balance
> > 773 Mbps              798 Mbps                        809 Mbps

thanks again for running the above benchmarks.

> version is a little less aggressive and has less overhead, something I'd 
> prefer in 2.5. 

Second that of course, btw, the detailed explanataion of the changes I
did while merging it can be found on lse-tech.

it is also possible HZ/50 is too high frequency still, I didn't run any
extensive test on the reprogramming frequency. I would suggest to try
with HZ/10 too (so every 100msec instead of every 20msec).

BTW, the very same algorithm should also be shared by alpha, alpha never
had hardware irq balancing support, it's like a p4, and we do static
routing distribution choosed by the kernel at boot which is been pretty
good so far (better than mainline 2.4 on a p4 smp) but the irqblanace
algorithm should be better there too.

Andrea
