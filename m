Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSK3X2G>; Sat, 30 Nov 2002 18:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSK3X2G>; Sat, 30 Nov 2002 18:28:06 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:53773 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S261302AbSK3X2F>;
	Sat, 30 Nov 2002 18:28:05 -0500
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: scx200_gpio.c doesn't compile in 2.5.50
References: <20021128013527.GU21307@fs.tum.de>
	<87of86hdvg.fsf@zoo.weinigel.se>
	<20021130231622.GO30931@conectiva.com.br>
From: Christer Weinigel <wingel@nano-system.com>
Organization: Nano Computer Systems AB
Date: 01 Dec 2002 00:35:29 +0100
In-Reply-To: <20021130231622.GO30931@conectiva.com.br>
Message-ID: <87isyehbr2.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@conectiva.com.br> writes:

> Em Sat, Nov 30, 2002 at 11:49:39PM +0100, Christer Weinigel escreveu:
> > Adrian Bunk <bunk@fs.tum.de> writes:
> > 
> > > Compilation of drivers/char/scx200_gpio.c fails in 2.5.50 with the error
> > > messages below.
> > 
> > Thanks for the report.  Patch follows.
> > 
> > Alan, do you want small fixes like these or should I send them to
> > someone else?
> 
> 	I have this one on my misc-2.5 bk tree that I'll be pushing to Linus
> RSN. It is also required that we include kdev_t.h, as this driver uses the
> minor() macro.

Thanks.  Is there any list of what include files one must use to use
for example the minor macro?  I looked at fs.h and saw that it
included kdev_t.h so I skipped including that file myself.  But
relying on things like that is what bit me to begin with.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
