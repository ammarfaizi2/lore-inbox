Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279233AbRKGLJK>; Wed, 7 Nov 2001 06:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279917AbRKGLJA>; Wed, 7 Nov 2001 06:09:00 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:54761 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S279233AbRKGLIv>; Wed, 7 Nov 2001 06:08:51 -0500
Date: Wed, 7 Nov 2001 12:08:34 +0100 (CET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Mike Kasick <ic382@apk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: EMU10K1 and High Memory conflict in 2.4.13/2.4.14
In-Reply-To: <20011106235430.1e0df1d4.ic382@apk.net>
Message-ID: <Pine.LNX.4.33.0111071206240.1005-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Mike Kasick wrote:

Edit linux/drivers/sound/emu10k1/main.c and change:

/* FIXME: is this right? */
/* does the card support 32 bit bus master?*/
#define EMU10K1_DMA_MASK                0xffffffff      /* DMA buffer mask for pci_alloc_consist */

to

/* FIXME: is this right? */
/* does the card support 32 bit bus master?*/
#define EMU10K1_DMA_MASK                0x7fffffff      /* DMA buffer mask for pci_alloc_consist */

I believe the comments say it all...

Rui Sousa


> I've been having problems with the EMU10K1 Sound Blaster Live! driver since the release of 2.4.13.  Though I get no errors, all the sounds play garbled and distorted, or not at all.  I didn't have this problem with 2.4.12 and below.  After not hearing anything on the issue I checked over my entire configuration tonight and found that with 4GB or 64GB High Memory Support enabled in my otherwise stock kernel I get these distortions, however with High Memory Support off, everything seems ok.
> 
> Among other things, my hardware includes:
> Abit KT7 Motherboard (KT-133 chipset)
> AMD Athlon Thunderbird 800 MHz processor
> 1.0 GB PC133 SD-RAM (I think its all Micron, but I'm not sure)
> Soundblaster Live! Value
> 
> This is my first time posting to the mailing list so forgive me for not being very familiar with the formalities, particularly I have no idea who to mail this to so I'm just posting it to the list in hopes someone reads it.  Also, my primary email address isn't subscribed, so I would appreciate it if all replies were CC'ed to ic382@apk.net -- Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

