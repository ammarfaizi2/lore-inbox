Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSFCRbC>; Mon, 3 Jun 2002 13:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSFCRbB>; Mon, 3 Jun 2002 13:31:01 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:3081 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S317434AbSFCRbA>; Mon, 3 Jun 2002 13:31:00 -0400
Message-Id: <200206031729.g53HTwTo002828@pincoya.inf.utfsm.cl>
To: jt@hpl.hp.com
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, Dan Aloni <da-x@gmx.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Link order madness :-( 
In-Reply-To: Message from Jean Tourrilhes <jt@bougret.hpl.hp.com> 
   of "Mon, 03 Jun 2002 10:14:47 MST." <20020603101447.A6067@bougret.hpl.hp.com> 
Date: Mon, 03 Jun 2002 13:29:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> said:

[...]

> 	The problem is *not* the networking initialisation (I wish
> people were *reading* my e-mails). The basic networking is initialised
> early enough. The various networking stacks could be initialised
> earlier, but I don't depend on them. Note that there might be a reason
> to initialise networking after the file system, so to do that we might
> need to insert a level between fs_initcall() and device_initcall().

If you insert enough levels, you are in another form of madness.

There should be a way of saying "This must be initialized after this, and
before that" (the "before that" might perhaps be taken care of by the
"that" itself). Spiced with a few "barriers": "Networking inited", etc.
>From there the build system should figure it out by itself. tsort(1) on an
appropiate bunch of descriptive one-liners (extracted from the sources?)
should give the right initialization order, or error out.

Yes, I know this has been proposed before and been thrown out (for no good
reason, AFAICS)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
