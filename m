Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJAIWC>; Tue, 1 Oct 2002 04:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJAIWC>; Tue, 1 Oct 2002 04:22:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46286 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261525AbSJAIWB>;
	Tue, 1 Oct 2002 04:22:01 -0400
Date: Tue, 1 Oct 2002 10:27:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20021001082718.GA20878@suse.de>
References: <20020929091229.GA1014@suse.de> <Pine.LNX.3.96.1020930151754.20863I-100000@gatekeeper.tmr.com> <20021001062630.GM3867@suse.de> <15769.21706.618421.684462@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15769.21706.618421.684462@kim.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Mikael Pettersson wrote:
> Jens Axboe writes:
>  > On Mon, Sep 30 2002, Bill Davidsen wrote:
>  > > On Sun, 29 Sep 2002, Jens Axboe wrote:
>  > > > 2.5 IDE stability should be just as good as 2.4-ac.
>  > > 
>  > > A laudable goal.
>  > 
>  > If you know of any points where this is currently not true, I'd like to
>  > hear about it. I'm considering this goal reached. Whether 2.4-ac is at
>  > the level we want is a different story.
> 
> 2.5.39 IDE is nowhere near as stable as 2.4.20-pre8:

Common misconception. I wrote 2.4-ac, not 2.4 vanilla tre. 2.4-ac is in
flux, 2.5 is too. There are some quirks, most of the 'doesnt work'
nature and not the 'corrupting data' kind.

> - I have several boxes with decent PCI chipsets (BX, HX) but old disks.
>   With 2.5.39, they tend to spew a couple of ..._intr errors on boot.
>   (Sorry, can't be more specific right now. I won't be near those
>   boxes until Saturday.)

But they come up?

> - Same ..._intr errors on my 486 with a qd6580 VLB controller.
>   It also has, in post-2.5.36 kernels, an instant-reboot problem which
>   occurs whenever I pass the ide0=qd65xx kernel option required to
>   activate its chipset support. (I _believe_ this is because the code
>   does something, like a kmalloc, which is illegal at the early
>   point IDE's __setup runs.) With 2.5.3x kernels, this box also sees
>   a steady stream of spurious interrupts while doing a kernel recompile,
>   something it doesn't see in older kernels.

Ok this is a new one, at least to me

> - My Intel AL440LX box (440LX chipset, 20G Quantum Fireball) worked
>   brilliantly up to 2.5.36, but hangs *hard* with 2.5.39 as soon
>   as I tar zxf the kernel source tarball.
>   (May or may not be IDE. I'll try a minimal 2.5.39 tonight.)

Probably not ide, no important changes in there in between 2.6.36 and
present.

> All of these work perfectly with 2.4.20-pre8, indeed all previous 2.4
> standard kernels, 2.2 + Andre's ide-patch, and with the exception of
> the ..._intr errors, 2.5.36.

If you (or anyone else for that matter) come across ide oddities in 2.5,
please try 2.4.20-pre-ac kernels and see if you can reproduce.

-- 
Jens Axboe

