Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268790AbRG0G4y>; Fri, 27 Jul 2001 02:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268789AbRG0G4d>; Fri, 27 Jul 2001 02:56:33 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:777 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S268677AbRG0G4Y>; Fri, 27 Jul 2001 02:56:24 -0400
Date: Fri, 27 Jul 2001 08:55:52 +0200 (CEST)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
In-Reply-To: <9jptj1$155$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107270852430.731-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Linus Torvalds wrote:

>  - "static inline" means "we have to have this function, if you use it
>    but don't inline it, then make a static version of it in this
>    compilation unit"
>
>  - "extern inline" means "I actually _have_ an extern for this function,
>    but if you want to inline it, here's the inline-version"
>
[SNIP]
> ... we should just convert
> all current users of "extern inline" to "static inline".
>
Doesn't work for the ones in include/linux/parport_pc.h, which have
extern versions in drivers/parport/parport_pc.c. Gives build errors.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

