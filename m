Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265948AbRGERUQ>; Thu, 5 Jul 2001 13:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265934AbRGERUG>; Thu, 5 Jul 2001 13:20:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26497 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265933AbRGERTt>; Thu, 5 Jul 2001 13:19:49 -0400
Date: Thu, 5 Jul 2001 13:19:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christophe Beaumont <christophe@paracel.com>
cc: kernel Linux <linux-kernel@vger.kernel.org>
Subject: RE: DMA memory limitation?
In-Reply-To: <NFBBINOGHMOOBMPNBAHKCEPECEAA.christophe@paracel.com>
Message-ID: <Pine.LNX.3.95.1010705131043.24908A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, Christophe Beaumont wrote:

> 
> 
> > On Thu, 5 Jul 2001, Vasu Varma P V wrote:
> > 
> > > Hi,
> > > 
> > > Is there any limitation on DMA memory we can allocate using
> > > kmalloc(size, GFP_DMA)? I am not able to acquire more than
> > > 14MB of the mem using this on my PCI SMP box with 256MB ram.
> > > I think there is restriction on ISA boards of 16MB.
> > > Can we increase it ?
> > > 
> > > thx,
> > > Vasu
> > 
> > 14MB of DMA(able) memory?  Err. I think you are trying to
> > do something you would never need to do.
> > 
> And what is that supposed to be????
> 

Did you READ the rest of the carefully-worded paragraphs,
carefully, explaining that it ** ISN'T DMA ** memory that you need?

> I have a piece of pretty well designed hardware here... and my
> application requires me to have the PCI board to random access
> in master mode a whole lot of memory (anywhere from 128MEGS to
     ^^^^^^^^^^^
You JUST give it the address of any RAM you want to read/write...
as explained before. As explained, in a documentation file I
specified, you convert the virtual address using a macro that
the kernel headers provide.

You can even give it user-mode buffers as long as they are non-paged
during the access.

> 1GIG... and possibly more...) so I really do need BIG DMA buffers
> (I don't say huge anymore as one can get 1/2 Gig of RAM for just
> over 120 bucks???)... 
> 
> There is no way I can have the piece of hardware behave in 
> another fashion... and NO it is NOT broken (when you do BOTH 
> hardware & software, you know about BOTH limitations... there
> are just some cases where you have to face some unique issues).
> the mem=1024M works pretty fine once you have figured out how 
> to handle in a fairly simple way this "reserved" memory...
> 

This is wrong! Good luck sucker.

> So please software people...
                     ^^^^^^^

I am a Software Engineer, with a long history of hardware design.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


