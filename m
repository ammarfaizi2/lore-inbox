Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273448AbRIRTl4>; Tue, 18 Sep 2001 15:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273449AbRIRTlr>; Tue, 18 Sep 2001 15:41:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:284 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273448AbRIRTlc>; Tue, 18 Sep 2001 15:41:32 -0400
Date: Tue, 18 Sep 2001 21:41:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: jogi@planetzork.ping.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
Message-ID: <20010918214152.A720@athlon.random>
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random> <20010918175104.D6698@planetzork.spacenet> <20010918212856.50cd5b87.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918212856.50cd5b87.skraw@ithnet.com>; from skraw@ithnet.com on Tue, Sep 18, 2001 at 09:28:56PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 09:28:56PM +0200, Stephan von Krawczynski wrote:
> On 18 Sep 2001 17:51:04 +0200 jogi@planetzork.ping.de wrote:
> 
> > > You can try to back it out and see if helps just in case.
> > 
> > Ok Andrea,
> > 
> > I will test and let you know about the findings but I am afraid I can not
> > test this today. But I will let you know. Btw. xmms is skipping like mad
> > too.
> 
> Hello,
> 
> just my experience in this topic:
> I worked on -pre11 for one complete day after massive nfs server usage, no
> problems so far.
> current meminfo looks like:
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  923574272 865853440 57720832        0 66609152 629137408
> Swap: 271392768   434176 270958592
> MemTotal:       901928 kB
> MemFree:         56368 kB
> MemShared:           0 kB
> Buffers:         65048 kB
> Cached:         614240 kB
> SwapCached:        152 kB
> Active:         671956 kB
> Inactive:         7484 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       901928 kB
> LowFree:         56368 kB
> SwapTotal:      265032 kB
> SwapFree:       264608 kB
> 
> I currently compile kernel with -j 5 while playing mp3s via xmms without the
> slightest problem (xosview load is now 8). I tried xmms run as root and user,
> makes no difference. I tried starting applications (like mozilla or
> applixware), no problem. No mouse hangs or anything else negative. I am _not_
> using alsa, but emu10k1 from kernel.
> I couldn't even make it crash or skip in xmms while singing Torn together with
> Natalie - and listening to that _is_ real stress :-))
> 
> You only have to find some strategy to come around these formerly noticed alloc
> failures, perhaps by an idea to free up pages instantly if an alloc would fail
> otherwise (now). I like the overall performance very much, Andrea.

I'm very happy to hear this ;).

I now have an update ready for Linus to merge that should fix the few
leftovers I had in the very first release of the vm rewrite but of
course I will be interested to hear about any regression/progression
about those changes, I'll post them in a few minutes in CC to l-k.

They're still untested on the >1G boxes but the oom problems weren't
specific to highmem so it should fix the highmem troubles too.

Andrea
