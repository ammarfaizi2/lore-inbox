Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSKJQUh>; Sun, 10 Nov 2002 11:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264933AbSKJQUg>; Sun, 10 Nov 2002 11:20:36 -0500
Received: from [195.223.140.107] ([195.223.140.107]:31365 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264931AbSKJQUf>;
	Sun, 10 Nov 2002 11:20:35 -0500
Date: Sun, 10 Nov 2002 17:27:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kjartan Maraas <kmaraas@online.no>
Cc: Jens Axboe <axboe@suse.de>, Con Kolivas <conman@kolivas.net>,
       Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110162706.GD1278@x30.random>
References: <200211091300.32127.conman@kolivas.net> <200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de> <200211100009.55844.conman@kolivas.net> <20021109135446.GA2551@suse.de> <1036923167.2538.7.camel@sevilla.gnome.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1036923167.2538.7.camel@sevilla.gnome.no>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 11:12:47AM +0100, Kjartan Maraas wrote:
> lør, 2002-11-09 kl. 14:54 skrev Jens Axboe:
> 
> [SNIP]
> 
> > The default is 2048. How long does the io_load test take, or rather how
> 
> The default on my RH system with the latest errata kernel is as follows:
> 
> [root@sevilla kmaraas]# elvtune /dev/hda
> 
> /dev/hda elevator ID		0
> 	read_latency:		8192
> 	write_latency:		16384
> 	max_bomb_segments:	6

that has still the bugs in 2.4.19 and all previous 2.4 that I found and
that I fixed first with an limited patch, not complete, and then Jens
fixed it competely after I showed him the bugs while explaining him why
I did the first limited patch (then Jens's patch gone in 2.4.20pre).

so a 8192 there, isn't comparable to a 8192 in 2.4.20rc, Jens was of
course aware and just lowered it to 2048 but that is probably still more
than a 8192 in previous 2.4, it would be possible to do the math to
calculate the exact value in some common case but I guess we want a sane
default, not necessairly the exact same behaviour, so I guess
benchmarking is more useful than doing the math to calculate the exact
new value to get the exact same behaviour.

Andrea
