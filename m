Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLaSgu>; Sun, 31 Dec 2000 13:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLaSgk>; Sun, 31 Dec 2000 13:36:40 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28422 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129370AbQLaSgi>;
	Sun, 31 Dec 2000 13:36:38 -0500
Date: Sun, 31 Dec 2000 19:06:10 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001231190610.A24594@gruyere.muc.suse.de>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 09:27:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 09:27:23AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 31 Dec 2000, Andi Kleen wrote:
> > 
> > Sounds good. It could also be controlled by a CONFIG_SPACE_EFFICIENT for
> > embedded systems, where you could trade a bit of CPU for less memory overhead 
> > even on systems where u8 is slow and atomicity doesn't come into play
> > because it's UP anyways. 
> 
> UP has nothing to do with it.
> 
> The alpha systems I remember this problem on were all SMP.
[...]

I just checked all architecture manuals I could lay my hands on
(sparcv9, ppc32, mips r4400, parisc 1.1, alpha, sh is somewhere in
storage but as I remember it has it too) 
and they all seem to have at least store byte and mostly store
half words instructions. 

> 
> Imagine an architecture where you need to do a
> 
> 	load_32() 
> 	mask-and-insert-byte
> 	store_32()

iirc the Alpha guys found out that they couldn't drive half of the
available devices without byte store, and since then nobody has 
repeated that mistake @)


> 
> I don't think it's a good diea.

I don't see it. Just define x8 to u32 on old alpha and let most other architectures
be happy. 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
