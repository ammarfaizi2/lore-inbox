Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276612AbRJPSiN>; Tue, 16 Oct 2001 14:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJPSiD>; Tue, 16 Oct 2001 14:38:03 -0400
Received: from ns.ithnet.com ([217.64.64.10]:3850 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S276612AbRJPSiB>;
	Tue, 16 Oct 2001 14:38:01 -0400
Date: Tue, 16 Oct 2001 20:38:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre3aa1
Message-Id: <20011016203821.54c6a959.skraw@ithnet.com>
In-Reply-To: <E15tUgv-0000Oh-00@Princess>
In-Reply-To: <20011016110708.D2380@athlon.random>
	<E15tTMq-0000E6-00@Princess>
	<20011016152126.01d58180.skraw@ithnet.com>
	<E15tUgv-0000Oh-00@Princess>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001 15:55:27 +0200 Allan Sandfeld <linux@sneulv.dk> wrote:

> On Tuesday 16 October 2001 15:21, you wrote:
> >
> > On my system I cannot see anything the like. Look at the execution time.
> > Ok, I must admit: I do not use brain-dead K stuff (warning: this is a very
> > personal opinion, don't flame me here :-).
> >
> > What does your setup look like? Have you ever tested without K?
> >
> No, I havent tried it without K. The system is quite responsive if I only run

> updatedb, and swap around in either text-linux or a simple X setup. When 
> looking closer at the problem, it is the combination of running kmail with 
> HUGE folders (think linux-kernel archive), apt-get and anacron that thrashes 
> the system. All of these have a "relative" low impact when running alone or 
> two and two.
> It might be "what you expect" abusing the system like that. But as I said, it

> is not a problem in 2.4.11-pre1 and 2.4.12-ac3. 
> 
> Princess:/home# cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  196304896 192466944  3837952        0  1327104 33628160
> Swap: 255426560 64491520 190935040
> MemTotal:       191704 kB
> MemFree:          3748 kB
> MemShared:           0 kB
> Buffers:          1296 kB
> Cached:          28196 kB
> SwapCached:       4644 kB
> Active:          23344 kB
> Inactive:        10792 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       191704 kB
> LowFree:          3748 kB
> SwapTotal:      249440 kB
> SwapFree:       186460 kB
> 
> Princess:/proc# uname -r
> 2.4.13-pre2
> 
> Princess:/proc# df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/hda3             18975356   9843804   8167652  55% /
> /dev/hda1                 7318      7241         0 100% /boot
> 
>  15:52:56 up  1:03,  2 users,  load average: 3.44, 3.95, 3.16
> 90 processes: 86 sleeping, 2 running, 2 zombie, 0 stopped
> CPU states:  23.7% user,   3.4% system,   0.0% nice,  73.0% idle
> Mem:    191704K total,   188024K used,     3680K free,     2652K buffers
> Swap:   249440K total,    61744K used,   187696K free,    21268K cached
> 
> 
> Does all this help you?

Hm, from looking at the presented numbers I tend to believe that you are
driving this system up to the limits. Very possible that ac kernels deal a bit
better with the situation because of neat swap-management. But very much of
your mem is really used by appilcations and very few (in comparison) is used by
page cache, so there is not really much room to play with. If I were to give
advice, I'd either
a) buy mem (something like additional 256 MB)
or
b) throw away K, and replace by more resource-conscious stuff like wm, or/and
an acceptable mail-client like sylpheed.
Both would do quantum-leaps in your configuration, compared to very small
playground left for vm treatment. Whatever is swapped could be the wrong thing,
depending on your further actions.
Try it and compare the time and memory consumption for:
a) Startup
b) Exit
c) Starting your mail-client
d) updatedb
with K and with wm (just to mention a nice example)

> Notice this is not worst case, just what I could reproduce by starting 
> updatedb and checksecurity while answering your mail. Switchtime from desktop

> to desktop is 1 minute.

Sure. I would say it swaps the hell out. K tends to be the wrong choice in a
less-than-completely-oversized system. As I said, Riks vm may help you _this
time_. But possibly only up to the next K release, where everything is again
slower, bigger and more unstable. Solve the problem, do not maneuver around it.

Just my personal opinion.

Regards,
Stephan


