Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSKJSaz>; Sun, 10 Nov 2002 13:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSKJSaz>; Sun, 10 Nov 2002 13:30:55 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18180 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265037AbSKJSay>;
	Sun, 10 Nov 2002 13:30:54 -0500
Date: Sun, 10 Nov 2002 17:30:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>, vojtech@ucw.cz
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021110163012.GB1564@elf.ucw.cz>
References: <1036599549.9803.49.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211060758440.2545-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211060758440.2545-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  - when the next gettimeofday happens, we can check the sequence number 
>    and the old gettimeofday, and verify that we get monotonic behaviour in 
>    the absense of explicit date setting. This allows us to handle small 
>    problems gracefully ("return the old time + 1 ns" to make it 
>    monotonic even when we screw up), _and_ it will also act as a big clue
>    for us that we should try to synchronize - so that we basically never 
>    need to worry about "should I check the clocks" (where "basically 
>    never" may be "we check the clocks every minute or so if nothing else 
>    happens")

Unfortunately, this means "bye bye vsyscalls for gettimeofday".

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
