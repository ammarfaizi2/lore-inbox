Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRE1WwS>; Mon, 28 May 2001 18:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261500AbRE1Wv6>; Mon, 28 May 2001 18:51:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50438 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261488AbRE1Wvy> convert rfc822-to-8bit; Mon, 28 May 2001 18:51:54 -0400
Date: Mon, 28 May 2001 18:15:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <anedah-9@sm.luth.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
In-Reply-To: <20010529001003.A320@sm.luth.se>
Message-ID: <Pine.LNX.4.21.0105281802290.1261-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 May 2001, André Dahlqvist wrote:

> André Dahlqvist <anedah-9@sm.luth.se> wrote:
> 
> > I agree. Kernels after 2.4.4 uses a *lot* more swap for me, which I guess
> > might be part of the reason for the slowdown.
> 
> Following up on myself, here are some numbers:
> 
> Freshly booted 2.4.4 with X and Mozilla running, 'free' outputs this:
> 
>              total       used       free     shared    buffers     cached
> Mem:         62716      61280       1436          0       1820      28704
> -/+ buffers/cache:      30756      31960
> Swap:       160608          0     160608
> 
> Freshly booted 2.4.5-ac2 with X and Mozilla running, 'free' outputs this:
> 
>              total       used       free     shared    buffers     cached
> Mem:         62784      61784       1000        380       1824      35748
> -/+ buffers/cache:      24212      38572
> Swap:       160608       7128     153480
> 
> After running 2.4.5-ac2 (and other kernels after vanilla 2.4.4) for a while
> the swap usage grows a lot, to around 60 MB. Older kernels didn't swap out
> this aggressively in my experience.

Well, they probably did. Its just that the kernel released unused swap
cache pages (thus releasing swap space) "more often".

Just to confirm this is what happening in your case:  Can you please try
2.4.4-ac5 and see if the _swap usage_ is still as badly?

This kernel contains a workaround to make the VM release unused swap cache
pages more often. (note: newer 2.4.4-ac do not contain the patch because
it could cause locks under some cases. Specially swap to files)

Back to the interactivity issue, I suppose you've "felt" bad interactivity
with 2.4.* kernels, right ?

I am asking that because I do not believe this swap usage issue is the
main reason for the problem.

