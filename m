Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282227AbRK2AkN>; Wed, 28 Nov 2001 19:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282228AbRK2AkG>; Wed, 28 Nov 2001 19:40:06 -0500
Received: from www.transvirtual.com ([206.14.214.140]:64012 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282227AbRK2Ajy>; Wed, 28 Nov 2001 19:39:54 -0500
Date: Wed, 28 Nov 2001 16:39:31 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] vc_tty addition
In-Reply-To: <E169F1J-0006fw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10111281627190.4098-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > the printk is currently writting to the VT console. This small patch is
> > the first step toward that. Also tusing vc_tty will be needed in
> > keyboard.c when it handles more than one keyboard.
> 
> What happens when you have no tty bound to your console - and its just for
> messages (eg the printer port console) ?

What? What happens when you open /dev/console then? The tty layer
redirects the console to some tty normally.

If this is the case then I will do it the way I started out. Having the
lock in struct console and sharing it with the tty layer. I was thinking
about a tty_driver just for the struct console list anyways. Currently
accessing /dev/console only effects the first console in the list instead
of all of them. If this is true then that means /dev/consoel can exist
without /dev/tty which could be a good thing.


