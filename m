Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSHDING>; Sun, 4 Aug 2002 04:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318129AbSHDINF>; Sun, 4 Aug 2002 04:13:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42504 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S318122AbSHDINF>;
	Sun, 4 Aug 2002 04:13:05 -0400
Date: Sun, 4 Aug 2002 10:16:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christian Neumair <christian-neumair@web.de>
Cc: Hell.Surfers@cwctv.net, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: RE:2.4.19 warnings with allnoconfig
Message-ID: <20020804081620.GA13316@alpha.home.local>
References: <0ab2d4837030482DTVMAIL12@smtp.cwctv.net> <1028447908.4339.3.camel@kellerbar.lan.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028447908.4339.3.camel@kellerbar.lan.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 09:58:25AM +0200, Christian Neumair wrote:
> > 2.4.19 with make allnoconfig produces these warnings.
> 
> Just a hint:
> There is almost no software with completely clean code.
> Whenever you see one compiling and it produces no warnings it's most
> likely that the build script just suppresses warnings.

I completely disagree with you. I try hard to make my programs
compile without a warning with -Wall, even if it sometimes makes
the code a bit more difficult to read (mainly because of
parenthesis and casts). This way, I have fairly reduced portability
issues with 32/64 bits, LE/BE machines.

Just a hint :-)
It is always bad to ignore the compiler's complaints, because it tells
you that it may do things wrong when it's not sure about what you want.

Spending hours fixing a few warnings in the kernel has already led me
to fix some bugs that only a compiler or an attentive human would have
detected, specially when indentation fools you. Eg, this common mistake :

	if (something1)
		if (something 2)
			do_2();
	else
		do_not_1();

Cheers,
Willy

