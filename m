Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135506AbRD1XKU>; Sat, 28 Apr 2001 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135586AbRD1XKK>; Sat, 28 Apr 2001 19:10:10 -0400
Received: from ferret.phonewave.net ([208.138.51.183]:44548 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S135506AbRD1XKD>; Sat, 28 Apr 2001 19:10:03 -0400
Date: Sat, 28 Apr 2001 16:09:54 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
Message-ID: <20010428160954.A25712@ferret.phonewave.net>
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu> <20010429011604.A976@home.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010429011604.A976@home.ds9a.nl>; from ahu@ds9a.nl on Sun, Apr 29, 2001 at 01:16:04AM +0200
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 01:16:04AM +0200, bert hubert wrote:
> On Sat, Apr 28, 2001 at 02:21:29PM -0700, Ion Badulescu wrote:
> > Hi Alan,
> > 
> > Over the last week I've tried to upgrade a 4-CPU Xeon box to 2.2.19, but 
> > the it keeps locking up whenever the disks are stresses a bit, e.g. when 
> > updatedb is running. I get the following messages on the console:
> > 
> > wait_on_bh, CPU 1:
> > irq:  1 [1 0]
> > bh:   1 [1 0]
> > <[8010af71]>
> 
> Obvious question is, which compiler.

I hadn't seen any locks, but (on a dual Pmmx 200) it started crawling
right after the NIC module (tulip) was loaded. System load decided to
skyrocket.

Yadda... 2.2.19 with devfs patch.
bicycle:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.3/specs
gcc version 2.95.3 20010315 (Debian release)

Might be the same problem.

-- Ferret
