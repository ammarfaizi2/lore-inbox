Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316977AbSFGRhn>; Fri, 7 Jun 2002 13:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFGRhm>; Fri, 7 Jun 2002 13:37:42 -0400
Received: from watsol.cc.columbia.edu ([128.59.39.139]:23526 "EHLO
	watsol.cc.columbia.edu") by vger.kernel.org with ESMTP
	id <S316977AbSFGRhk>; Fri, 7 Jun 2002 13:37:40 -0400
Date: Fri, 7 Jun 2002 13:37:38 -0400 (EDT)
From: Adam Trilling <agt10@columbia.edu>
To: Chris Fuller <cfuller@broadjump.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan S2464 (K7 SMP) + EMU10K1 hardlocks
In-Reply-To: <97B71B827DFB2B448A73EC00E5DA0EE605E04A@logos.inhouse.broadjump.com>
Message-ID: <Pine.GSO.4.44.0206071321350.502-100000@watsol.cc.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't even find info on this mobo.  Every hit Google returned was a link
to a thread on lkml :)  Does it have a VIA chipset by any chance?

There is a known lonstanding incompatibility between the SoundBlaster
Live! series and the VIA VT82C686B southbridge.  You can fix it by messing
with your BIOS, but I wasn't brave enough to try that.  You can get more
info from www.viahardware.com I think (it won't load properly on this
computer so I can't give an exact link).

adam

On Fri, 7 Jun 2002, Chris Fuller wrote:

>
> I've established by now that the problem is definitely not with the
> Linux kernel, but there was a discussion here about this very issue last
> August, and I haven't found a reference to it anywhere else, so please
> help if you can. :)
>
> I'm seeing hardlocks in various 2.4 kernels (10, 18, 19-pre8, all SMP):
>   mobo=Tyan S2464 (K7 Thunderbird) SMP
>   NVidia GeForce4 AGP
>   SBLive! Platinum 5.1
>   Two 40G IDE hard drives
>
> I can reproduce at will (Unreal Tournament aggrivates it), but it can
> happen at any time.  It even locked up in the BIOS Setup(!) at one
> point.  Last August, Eric S. Raymond started these threads which seem to
> be the same problem:
>   Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
>   S2464 (K7 Thunder) hangs -- some lessons learned
>
> First trying the things I usually try to regain system stability, then
> based on what I learned from the above threads, I have found that even
> doing *all* of the following does not correct the issue for me:
>   nosmp or pulled 2nd CPU
>   ide=nodma
>   disableapic or noapic
>   apm=off
>   additional cooling
>   memory swap
>   video card swap, both pci and agp, both 3dfx and nvidia
>   "Use PCI Interrupt Entries in MP Table" -> "yes"
>   No emu10k1 driver at all
>
> Yanking the sound card completely out of the machine makes the hardlock
> go away, but the card works flawlessly in my Abit K7 system.
>
> Am I forgetting to try something?
>
> Does anybody have any further advice on this?
>
> Does anyone know if it's the motherboard or the card that's actually
> doing something wrong, so I can know whom to yell at and/or avoid in the
> future?
>
> crf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


Adam Trilling
agt10@columbia.edu


char m[9999],*n[99],*r=m,*p=m+5000,**s=n,d,c;main(){for(read(0,r,4000);c=*r;
r++)c-']'||(d>1||(r=*p?*s:(--s,r)),!d||d--),c-'['||d++||(*++s=r),d||(*p+=c==
'+',*p-=c=='-',p+=c=='>',p-=c=='<',c-'.'||write(2,p,1),c-','||read(2,p,1));}



