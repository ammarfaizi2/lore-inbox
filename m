Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136676AbREARfa>; Tue, 1 May 2001 13:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136677AbREARfS>; Tue, 1 May 2001 13:35:18 -0400
Received: from hood.tvd.be ([195.162.196.21]:177 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S136676AbREARe1>;
	Tue, 1 May 2001 13:34:27 -0400
Date: Tue, 1 May 2001 19:33:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: mike_phillips@urscorp.com
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <OFED368CB7.D5C74726-ON85256A3F.004547C6@urscorp.com>
Message-ID: <Pine.LNX.4.05.10105011932050.411-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001 mike_phillips@urscorp.com wrote:
> To get the pcmcia ibmtr driver (ibmtr/ibmtr_cs) working on ppc, all the 
> isa_read/write's have to be changed to regular read/write due to the lack 
> of the isa_read/write functions for ppc.
> 
> So, the question is should I simply:
> 
> a) change everything to read/write and friends (the way the driver used to 
> be before the isa_read/write function were introduced)
> b) Put ugly macros in the driver to use the different functions depending 
> upon architecture.
> c) Implement the isa_read/write functions for ppc ? 
> or d) something completely different I haven't thought of. 

Please go for option c.

Also note that ISA memory space is not available on all PPC platforms.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

