Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSK3Xgl>; Sat, 30 Nov 2002 18:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSK3Xgl>; Sat, 30 Nov 2002 18:36:41 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:65297 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261318AbSK3Xgk>; Sat, 30 Nov 2002 18:36:40 -0500
Date: Sat, 30 Nov 2002 21:43:49 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Christer Weinigel <wingel@nano-system.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: scx200_gpio.c doesn't compile in 2.5.50
Message-ID: <20021130234349.GR30931@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Christer Weinigel <wingel@nano-system.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
References: <20021128013527.GU21307@fs.tum.de> <87of86hdvg.fsf@zoo.weinigel.se> <20021130231622.GO30931@conectiva.com.br> <87isyehbr2.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isyehbr2.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 01, 2002 at 12:35:29AM +0100, Christer Weinigel escreveu:
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> writes:
> 
> > Em Sat, Nov 30, 2002 at 11:49:39PM +0100, Christer Weinigel escreveu:
> > > Adrian Bunk <bunk@fs.tum.de> writes:
> > > 
> > > > Compilation of drivers/char/scx200_gpio.c fails in 2.5.50 with the error
> > > > messages below.
> > > 
> > > Thanks for the report.  Patch follows.
> > > 
> > > Alan, do you want small fixes like these or should I send them to
> > > someone else?
> > 
> > 	I have this one on my misc-2.5 bk tree that I'll be pushing to Linus
> > RSN. It is also required that we include kdev_t.h, as this driver uses the
> > minor() macro.
> 
> Thanks.  Is there any list of what include files one must use to use
> for example the minor macro?  I looked at fs.h and saw that it
> included kdev_t.h so I skipped including that file myself.  But
> relying on things like that is what bit me to begin with.

Well, I rather encourage to include the files that have the definition of 
symbols in the .c file, that way if, taking your example: if fs.h for some
reason removed the include kdev_t.h, scx200_gpio.c would stop compiling.

- Arnaldo
