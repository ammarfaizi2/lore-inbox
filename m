Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbRFQWeA>; Sun, 17 Jun 2001 18:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbRFQWdu>; Sun, 17 Jun 2001 18:33:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34186 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263070AbRFQWdr>;
	Sun, 17 Jun 2001 18:33:47 -0400
Date: Sun, 17 Jun 2001 18:33:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Flynn <Dave@keston.u-net.com>, rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <0106172328340U.00879@starship>
Message-ID: <Pine.GSO.4.21.0106171821430.15952-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Jun 2001, Daniel Phillips wrote:

> typeof?  It's rather popular in the kernel already.  Besides, who is going to 

Really? 5 instances in PPC arch-specific code, 1 (absolutely gratitious)
in drivers/mtd, 2 - in m68k (also useless), 4 - in drivers/video, 2 -
in AFFS and 1 - in netfilter.

I wouldn't call it "rather popular".

> compile this with anything other than gcc?

> 
> I don't see your point about greppability.

You are making the types it is applied to harder to deal with wrt. global
search.

	But the real issue here is that preprocessor is not a way to get
polymorphism. And that would be the only context where typeof might
have any use. Trying to turn C into the things it isn't is always a bad
idea - had been proven many times. starting at least with Bourne shel
(check the v7 sh source if you don't know what I'm refering to).

