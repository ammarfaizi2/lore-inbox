Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSINOvO>; Sat, 14 Sep 2002 10:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSINOvN>; Sat, 14 Sep 2002 10:51:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:896 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317261AbSINOvN>;
	Sat, 14 Sep 2002 10:51:13 -0400
Date: Sat, 14 Sep 2002 00:46:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <20020913224559.GA25487@elf.ucw.cz>
References: <Pine.LNX.4.44L.0209071553020.1857-100000@imladris.surriel.com> <1031435070.14390.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031435070.14390.14.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Comments?
> > >
> > > Yeah:  "ouch" because I don't see a single category that's faster.
> > 
> > HZ went to 1000, which should help multimedia latencies a lot.
> 
> It shouldn't materially damage performance unless we have other things
> extremely wrong. Its easy enough to verify by putting HZ back to 100 and
> rebenching 

1000 times per second, enter timer interrupt, acknowledge it, exit
interrupt. Few i/o accessess, few tlb entries kicked out, some L1
cache consumed?

Is 10usec per timer interrupt reasonable on modern system? That's 10
msec per second spend in timer with HZ=1000, thats 1% overall. So it
seems to me it is possible for HZ=1000 to have performance impact...

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
