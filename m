Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbRGRCG7>; Tue, 17 Jul 2001 22:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267751AbRGRCGj>; Tue, 17 Jul 2001 22:06:39 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267743AbRGRCGh>; Tue, 17 Jul 2001 22:06:37 -0400
Date: Tue, 17 Jul 2001 19:05:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107172118200.7772-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107171904250.1181-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
>
> This fixes most of the highmem problems (I'm not able to deadlock a 4GB
> machine running memory-intensive programs with the patch anymore. I've
> also received one success report from Dirk Wetter running two 2GB
> simulations on a 4GB machine).

Do you have any really compelling reasons for adding the zone parameter to
swap-out?

At worst, we get a few more page-faults (not IO). At best, NOT doing this
should generate a more complete picture of the VM state. I'd really prefer
the VM scanning to not be zone-aware..

		Linus

