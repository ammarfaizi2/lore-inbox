Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbRE3TXh>; Wed, 30 May 2001 15:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbRE3TX1>; Wed, 30 May 2001 15:23:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5125 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261892AbRE3TXU>;
	Wed, 30 May 2001 15:23:20 -0400
Date: Wed, 30 May 2001 16:23:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Yoann Vandoorselaere <yoann@mandrakesoft.com>, andrea@e-mind.com,
        Mark Hemment <markhe@veritas.com>, Jens Axboe <axboe@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010530211801.A27129@athlon.random>
Message-ID: <Pine.LNX.4.21.0105301621000.13062-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Andrea Arcangeli wrote:
> On Wed, May 30, 2001 at 08:57:50PM +0200, Yoann Vandoorselaere wrote:
> > I remember the 2.3.51 kernel as the most usable kernel I ever used 
> > talking about VM.
> 
> I also don't remeber anything strange in that kernel about the VM (I
> instead remeber well the VM breakage introduced in 2.3.99-pre).
> 
> Regardless of what 2.3.51 was doing, the falling back into the lower
> zones before starting the balancing is fine.

The problem with 2.3.51 was that it started balancing
the HIGHMEM zone before falling back.

On a 1GB system this lead not only to the system starting
to swap as soon as the 128MB highmem zone was filled up,
it also resulted in the other 900MB being essentially
unused.

Having your 1GB system running as if it had 128MB definately
can be classified as Not Fun.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

