Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUAYOer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 09:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbUAYOer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 09:34:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53442 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264339AbUAYOep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 09:34:45 -0500
Date: Sun, 25 Jan 2004 15:34:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Message-ID: <20040125143438.GI513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401241639.23479.eric@cisu.net> <20040125010228.GH6441@fs.tum.de> <200401251452.58318.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401251452.58318.cova@ferrara.linux.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 02:52:58PM +0100, Fabio Coatti wrote:
> Alle Sunday 25 January 2004 02:02, Adrian Bunk ha scritto:
> 
> >
> > Please check exactly between which two kernel versions the problem
> > first appeared.
> >
> > Please send the .config of the last kernel that worked for you.
> 
> Confirmed here also... 
> the latest working kernel is 2.6.1-mm3; the first non working is 2.6.1-mm4
> The symptom is that the booting sequence stops right after "Uncompressing..".
> I've cofnigured -mm4 using .config and "make oldconfig", answering when 
> needed.
> The only relevant changed config options are related to CPU, but I haven't 
> looked in configure files.
> I've attached both .config (working-mm3/not working 2.6.2-rc1-mm3).
> I'm now trying to compile 2.6.2-rc1-mm3, but the problem is here from 
> 2.6.1-mm4 (not rc).
> I've also tried several choices for CPU (386->P4), without any change.
> The system is a P4/HT, chipset i875p, 1Gb ram
> If more information/test are needed, just let me know.

I sent the following to Eric:

<--  snip  -->

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

<--  snip  -->

The same is true for your .config's, so i you have some spare time these 
tests would be interesting.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

