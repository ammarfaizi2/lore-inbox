Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbSLaHOv>; Tue, 31 Dec 2002 02:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSLaHOv>; Tue, 31 Dec 2002 02:14:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267189AbSLaHOt>; Tue, 31 Dec 2002 02:14:49 -0500
Date: Mon, 30 Dec 2002 23:17:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Overzealous permenant mark removed 
In-Reply-To: <20021231065637.7FFC02C09E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0212302313370.2043-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Dec 2002, Rusty Russell wrote:
> 
> The banner, well, you know Linus' position on printing banners 8)

Well, I don't much enjoy banners, but on the other hand I enjoy nasty
little made-up rules that make people jump through hoops to do what they
really want to do even less. 

I don't really think that having no exit function should mean that you
can't unload it ("unless you have no init function, in which case it's ok,
unless it's the third thursday in a month that starts with the letter
'M', in which case you can only unload it if you walk widdershins around 
the computer thrice").

In other words, the rule really should be: "if the usage count > 1, you
can't unload it".

And if somebody wants to create an un-unloadable driver, he should just 
increment the module count and be done with it. No magic rules (maybe you 
can make /proc/modules print out "<permanent>" if the count is over some 
number, and then people who want permanent modules just initialize the 
count past that).

		Linus

