Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313414AbSDPAHp>; Mon, 15 Apr 2002 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313415AbSDPAHp>; Mon, 15 Apr 2002 20:07:45 -0400
Received: from pc132.utati.net ([216.143.22.132]:37271 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313414AbSDPAHn>; Mon, 15 Apr 2002 20:07:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Stephen Samuel <samuel@bcgreen.com>
Subject: Re: linux as a minicomputer ?
Date: Mon, 15 Apr 2002 14:09:06 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16wkJq-0004Jl-00@the-village.bc.nu> <20020415065501.3A687740@merlin.webofficenow.com> <3CBB522C.8070704@bcgreen.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020416002655.A0CC8740@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 April 2002 06:20 pm, Stephen Samuel wrote:
>
> It's stell cheaper to get 1~1.5G for 4 users than 512M for each of them,
> to avoid them spiking into swap space.  Total RAM overhead is
> likely to be a bit less (shared memory),  and memory or CPU
> usage spikes are easier to eat with a faster machine with a bit
> less ram than the total shared between 4 users.
>
> If a user  'spikes'' for  a long period of time, than THAT ammount
> of ram should be considered the baseline for that user. In any case,
> It's still likely to be cheaper to buy the RAM needed to keep 4 users
> happy in one box than to keep them all happy in separate boxes.

It also makes sense to stick a cheap three or four disk IDE RAID in the box 
and get some approximation of redundant data storage.  (If you're sharing 
everything but the user directories anyway, you can get away with devoting 
1/4 the disk space to a parity disk without really losing out in bang for the 
buck terms.  AND you get more speed out of it (especially if you're 
distributing swap space in paralell).)

You can even stick in a spare IDE controller in a PCI slot so each drive gets 
to be a master on its own cable, to double the bandwidth again...  (Sticking 
a RAID in individual workstations, on the other hand, is probably expensive 
overkill, and actually quadrupling the amount of maintenance since hard 
drives are one of the main moving parts of the box.  Distributing your swap 
space will still crash the box when a drive dies, it just means your system 
and data partitions should be easily recoverable when you reboot with a new 
drive in there.  We're not talking six nines of uptime for any box with only 
one power supply anyway (ANOTHER moving part :).  Although a UPS makes 
economic sense for a shared box as well.  (That that it could power four 
monitors, but maybe four LCDs?  Or at least save your data and shut down 
cleanly.  Swsup?)

A single 100baseT card for four users isn't going to be much of a bottleneck 
(you can stream 70 simultaneous ~DVD quality mpeg4 video streams through ONE 
of those cards), and you could save a lot of trouble on wiring too...

Sticking four users on a shared box at the intersection of four cubicles 
seems quite doable to me.  (Or one box per four four students in a university 
computer lab environment.)  If you're administering workstations for 100 
people, it might not actually cut the workload by 1/4, but it still sounds 
like a heck of an improvement.

Still needs rmap to enforce even remotely fair per-user swap behavior, 
though... :)

Rob
