Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUAYNPp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 08:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUAYNPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 08:15:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44486 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264233AbUAYNPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 08:15:42 -0500
Date: Sun, 25 Jan 2004 14:15:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Eric <eric@cisu.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Message-ID: <20040125131536.GG513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401241639.23479.eric@cisu.net> <20040125010228.GH6441@fs.tum.de> <200401242203.44850.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401242203.44850.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 10:03:44PM -0600, Eric wrote:
>...
> 	I have a strange suspicion that the new cpu options are to blame. I am by no 
> means a kernel hacker, but I've never had a problem like this where I am 
> locked out of a whole series of kernels, or where they would stop booting. 
> 	Possibly the new CPU selection options are generating bad code with my gcc?
>...

After diffing two of your .config's, I don't see how the CPU selection 
options might have caused this.

I'm sorry that I don't have a real idea where to search for the 
problems, only a few thoughts how to get nearer to finding it:

Please try 2.6.2-rc1 (without any -mm patch).

If this kernel works, please try -mm4 with disabled SMP support and
support for the Athlon (and no other CPUs).
If you compile with
  make V=1
the kernel build is more verbose. If this kernel doesn't boot, please 
send the complete gcc call for the compilation of a file (it doesn't 
matter which file, e.g. one under fs/).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

