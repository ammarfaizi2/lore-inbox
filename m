Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284200AbRLPCyJ>; Sat, 15 Dec 2001 21:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbRLPCyA>; Sat, 15 Dec 2001 21:54:00 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:9355 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S284200AbRLPCxq>; Sat, 15 Dec 2001 21:53:46 -0500
Date: Sat, 15 Dec 2001 21:53:40 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Niels Kristian Bech Jensen <nkbj@image.dk>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_SOUND_DMAP: Confusing Configure.help entry.
In-Reply-To: <Pine.LNX.4.33.0112160306270.3670-100000@hafnium.nkbj.dk>
Message-ID: <Pine.A41.4.21L1.0112152149430.11590-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm assuming you have more than 16 MB of RAM, in which case it's safe to
say Y here if you have an ISA soundcard.

The final line should probably be clarified to read: "Say Y if you have
16MB or more RAM and an ISA soundcard but N if you have a PCI sound
card."

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Sun, 16 Dec 2001, Niels Kristian Bech Jensen wrote:

> The Configure.help entry for CONFIG_SOUND_DMAP (included below) leaves 
> me a bit confused.  It says there can be a problem on machines with more 
> than 16MB of RAM.  At the same time it says that CONFIG_SOUND_DMAP 
> should be enabled unless you have more the 16MB of RAM (or a PCI sound 
> card).  Is it my language skill (English is not my mother tongue) or is 
> it a contradiction?  When should CONFIG_SOUND_DMAP be enabled?
> 
> 
> Persistent DMA buffers
> CONFIG_SOUND_DMAP
>   Linux can often have problems allocating DMA buffers for ISA sound
>   cards on machines with more than 16MB of RAM. This is because ISA
>   DMA buffers must exist below the 16MB boundary and it is quite
>   possible that a large enough free block in this region cannot be
>   found after the machine has been running for a while. If you say Y
>   here the DMA buffers (64Kb) will be allocated at boot time and kept
>   until the shutdown. This option is only useful if you said Y to
>   "OSS sound modules", above. If you said M to "OSS sound modules"
>   then you can get the persistent DMA buffer functionality by passing
>   the command-line argument "dmabuf=1" to the sound.o module.
> 
>   Say Y unless you have 16MB or more RAM or a PCI sound card.
> 
> 

