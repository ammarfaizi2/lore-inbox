Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVIEWFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVIEWFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 18:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVIEWFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 18:05:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:17798 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964855AbVIEWFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 18:05:10 -0400
X-Authenticated: #1226656
Date: Tue, 6 Sep 2005 00:05:07 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050906000507.5c0a1c9f@vaio.gigerstyle.ch>
In-Reply-To: <20050830030959.GC8515@g5.random>
References: <20050830030959.GC8515@g5.random>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea

Two little details:

The following line does not print what you expect on
alpha's:

MHZ = int(re.search(r' (\d+)\.?\d?',
                    os.popen("grep -i mhz /proc/cpuinfo | head -n
1").read()).group(1))

My /proc/cpuinfo:

cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : EB164
system variation        : LX164
system revision         : 0
system serial number    :
cycle frequency [Hz]    : 533171392 est.
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 1059.80
kernel unaligned acc    : 61926
(pc=fffffc00005f7ccc,va=fffffc003feee60e) user unaligned acc      : 0
(pc=0,va=0) platform string         : Digital AlphaPC 164LX 533 MHz
cpus detected           : 1
L1 Icache               : 8K, 1-way, 32b line
L1 Dcache               : 8K, 1-way, 32b line
L2 cache                : 96K, 3-way, 64b line
L3 cache                : 2048K, 1-way, 64b line

Second, you should mention somewhere that it needs at minimum twisted
1.3.0 to work correctly, did you?

Oh, another point:
Some of my machines have long uptimes, and I won't it reboot
to just match the klive runtime. So the reported uptime
is (in my cases) far away from true.


It is very interesting to see how often a vanilla/-git/-mm etc kernel is
tested. Perhaps klive could be extended to automatically report oopses
and/or other troubles if possible. What abut reporting core features
which are used on the machine like fs, scheduler, raid, lvm etc, so that
the devs can see which subsystem got a lot testing and what is not used
much?

Thanks

Marc


On Tue, 30 Aug 2005 05:09:59 +0200
Andrea Arcangeli <andrea@cpushare.com> wrote:

> Hello,
> 
> During the Kernel Summit somebody raised the point that it's not clear
> how much testing each rc/pre/git kernel gets before the final release.
> 
> So I setup a server to track automatically the amount of testing that
> each kernel gets. Clearly this will be a very rough approximation and
it
> can't be reliable, but perhaps it'll be useful. If this won't be
useful,
> the time I spent on it is very minor so no problem ;).
> 
> All the details can be found in the project website:
> 
> 	http://klive.cpushare.com/
> 
> Full source (server included) is here:
> 
> 	http://klive.cpushare.com/downloads/klive-0.0.tar.bz2
> 
> To run the client:
> 
> 	wget http://klive.cpushare.com/klive.tac
> 
> Then at every boot (like in /etc/init.d/boot.local):
> 
> 	twistd -oy klive.tac
> 
> In theory we could get rid of the client entirely and make it a kernel
> config option, but I've no idea if this project is useful, so I don't
> want to spend too much time on it at this point.
> 
> Thank you.
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
