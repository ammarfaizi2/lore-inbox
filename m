Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRKHQrn>; Thu, 8 Nov 2001 11:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRKHQrf>; Thu, 8 Nov 2001 11:47:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59662 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276132AbRKHQr2>; Thu, 8 Nov 2001 11:47:28 -0500
Date: Thu, 8 Nov 2001 13:28:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
 (fwd)
In-Reply-To: <Pine.LNX.4.33L.0111081433120.27028-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0111081319280.1689-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Nov 2001, Rik van Riel wrote:

> On Thu, 8 Nov 2001, Linus Torvalds wrote:
> > On Thu, 8 Nov 2001, Marcelo Tosatti wrote:
> > >
> > > I guess you forgot to apply the following patch on 2.4.15-pre1, right ?
> >
> > The thing is, I _really_ think it is broken.
> >
> > The way to make it fail is to have many large SHARED mappings
> 
> ISTR that you wanted swap_out() changed into something which
> only scans a portion of the ptes and doesn't have any return
> value for a related reason in early 2.4 ... ;)

Rik,

I remember Linus had a reasoning for the "scan _ALL_ ptes until success"
behaviour.

Linus, was that due to zone-specific (eg DMA shortage on bigmem machine)
shortages or ?

That _is_ one good argument (I'm still seeing the network driver not being
able to allocate memory from the DMA zone on the 16GB boxen), I think.

However, the current code breaks badly as I've tested on the 16GB boxen. 

