Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSJUR0j>; Mon, 21 Oct 2002 13:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJUR0j>; Mon, 21 Oct 2002 13:26:39 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:22992 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261514AbSJUR0h>;
	Mon, 21 Oct 2002 13:26:37 -0400
Date: Mon, 21 Oct 2002 10:32:33 -0700
To: Adrian Bunk <bunk@fs.tum.de>
Cc: James McKenzie <james@fishsoup.dhs.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] allow only one Toshiba Type-O IR Port driver in the kernel
Message-ID: <20021021173233.GA20616@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.NEB.4.44.0210201640090.28761-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210201640090.28761-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 04:44:11PM +0200, Adrian Bunk wrote:
> 
> Trying to compile both Toshiba Type-O IR Port drivers into the kernel
> fails with the following error:
> 
> <--  snip  -->
> 
> ...
>    ld -m elf_i386  -r -o drivers/net/irda/built-in.o ...
> drivers/net/irda/donauboe.o: In function `toshoboe_init':
> drivers/net/irda/donauboe.o(.init.text+0x0): multiple definition of
> `toshoboe_init'
> drivers/net/irda/toshoboe.o(.init.text+0x0): first defined here
> make[3]: *** [drivers/net/irda/built-in.o] Error 1
> 
> <--  snip  -->
> 
> The following patch allows the builing of the old driver only when the new
> one isn't compiled into the kernel.
> 
> Additionally it indents three lines inside an if ... fi that weren't
> indented.

	Adrian,

	Thanks very much for the report. I personally uses modules,
and I would prefer the ability to compile both modules, so that people
can try both without having to recompile their kernel.
	I think a much better patch (and simpler in the long term)
would be to just rename 'toshoboe_init' to 'donauboe_init' (plus the
few other offending function). This is a case where the name doesn't
really matter.
	What do you think ?

	Jean
