Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288339AbSACWSX>; Thu, 3 Jan 2002 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288334AbSACWSP>; Thu, 3 Jan 2002 17:18:15 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:61914 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S288336AbSACWSF>;
	Thu, 3 Jan 2002 17:18:05 -0500
Date: Thu, 3 Jan 2002 23:17:23 +0100
From: David Weinehall <tao@acc.umu.se>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, BALBIR SINGH <balbir.singh@wipro.com>,
        esr@thyrsus.com, David Woodhouse <dwmw2@infradead.org>,
        Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103231723.Z5235@khan.acc.umu.se>
In-Reply-To: <E16M7Ab-0008DP-00@the-village.bc.nu> <3C34D0D9.6010008@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C34D0D9.6010008@free.fr>; from Lionel.Bouton@free.fr on Thu, Jan 03, 2002 at 10:44:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 10:44:57PM +0100, Lionel Bouton wrote:
> Alan Cox wrote:
> 
> >>This would break things like cross-compilation. Not sure how many people
> >>use it though. You will have to be on the machine for which you intend
> >>to compile the kernel. If you are compiling the kernel for the same machine
> >>then it is the best thing to happen, provided the software doing the
> >>configuration for u is not broken
> >>
> > 
> > I'm really not too worried about Grandma cross compiling kernels
> 
> 
> ROTFL at the mental image of my Grandma configuring a cross-compiling 
> environment.
> 
> Eric, you said somewhere else in this thread that eventually we should 
> be able to make kernel configuration as easy as MAC configuration.
> 
> In short we can't.
> 
> MAC configuration is a dream we can't touch. The core hardware and most 
> importantly the mainboard firmware is done by the very same company that 
> develops the OS. I guess they didn't shout themselves in the feet and 
> made firmware and hardware with clean enough interfaces that they could 
> make hardware detection trivial.
> Even if they did mistakes, had bugs, they have the exhaustive list of 
> them and most probably can easily use workarounds.
> 
> Contrast this with the PC world : numerous mainboard manufacturers, bios 
> developpers, extension card manufacturers, Operating Systems, each with 
> their own bugs others desesperately try to work around...
> 
> The general case where all works ok (no bugs in dmi, pnp, ...) is the 
> exception and the land here is full of workarounds and dead ends if you 
> want to do hardware detection.
> 
> The worst case : the plain old ISA bus where you can't try to detect a 
> specific extansion card without risking to lock the system hard by 
> screwing some other type that is listening on ports you probed.
> 
> What I think we should try is to identify the most stable interfaces 
> (lspci works ok for most systems and would be of great help), use them 
> and let the user fill the gap (ISA/MCA/VLB/AGP bus switches for the 
> *user* is a great idea indeed).
> 
> We are quite PC centric here. But other archs are certainly far more 
> friendly to what you're up to.

At least MCA and NuBus can be autodetected, and I'm fairly confident
the people behind the VME-bus and TurboChannel weren't stupid either,
so those can probably be autodetected and probed too.

Dunno about VLB, but AGP is sort of a special-case of PCI (if I'm
not all wrong) and can be autodtected too.

ISA, on the other hand, is always a gamble. I bet there are other
exceptions as well.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
