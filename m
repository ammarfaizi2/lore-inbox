Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264012AbRFSIOL>; Tue, 19 Jun 2001 04:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264011AbRFSIOB>; Tue, 19 Jun 2001 04:14:01 -0400
Received: from www.wen-online.de ([212.223.88.39]:62472 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264008AbRFSINr>;
	Tue, 19 Jun 2001 04:13:47 -0400
Date: Tue, 19 Jun 2001 10:13:07 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Steve Kieu <haiquy@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 VM & swap question
In-Reply-To: <20010619073627.14718.qmail@web10407.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0106190948160.322-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Steve Kieu wrote:

> Just an information for you to compare, now I am
> running the kernel compile from mandrake 80; version
> 2.4.3-20mdk on a
> machine Intel celeron 400Mhz 128M RAM, i810 graphic
> card (it will use some memory) ; runing together
> Star Office 5.2, Netscape 4.77, Mozilla (shiped with
> LM80), compiling alsa driver and you may guess how
> much swap it used?
>
> [sk@steve sk]$ free
>              total       used       free     shared
> buffers     cached
> Mem:        126108     124416       1692          0
>     604      51820
> -/+ buffers/cache:      71992      54116
> Swap:        72288          0      72288

Just a general note about swap preallocation:  I've done truckloads of
experimentation over the last year or so, and it is generally true that
kernels which have an active swapcache prior to need perform much better
than those which don't at crunch time.

It's also generally true that kernels which actually page very lightly
before crunchtime react sooner/better to crunch.  I hate to see swap
totally untouched because I then know full well that I have a bunch
of totally inactive but plugged up ram pages.  (If you have too much
ram, that doesn't matter :)

	-Mike

