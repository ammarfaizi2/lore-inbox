Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbUAJWse (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUAJWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:48:33 -0500
Received: from [193.138.115.2] ([193.138.115.2]:50188 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265413AbUAJWs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:48:27 -0500
Date: Sat, 10 Jan 2004 23:45:28 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Maciej Zenczykowski <maze@cela.pl>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking 
In-Reply-To: <Pine.LNX.4.44.0401102336380.1739-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.56.0401102342290.13633@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401102336380.1739-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Jan 2004, Maciej Zenczykowski wrote:

> > Do you need smaller than this?  :
> ...
> > That's a 100% valid ELF executable, and the entire program is 91 bytes..
> > Sure, it doesn't do much useful, and the ELF header and program header
> > table is huge overhead compared to the actual program, but that overhead
> > is minimal in any program that does any actual work.
> >
> > Also, I'm not planning to add anything that disallows anything the ELF
> > spec allows, so you can still pull funny tricks like have sections overlap
> > and in the above program put _start inside the unused padding bytes in
> > e_ident[EI_PAD] if you want.. still a valid program, and not something
> > that the checks I'm adding will prevent.
> >
> ...
>
> OK, if that 91 is OK, then no problem, I was thinking the minimum would be
> around 1-2 KB (now that I think about it, not really sure why I assumed
> that).  I'm not mad enough to require/want shrinking from 90 to 45
> bytes :) especially since most useful programs have a little more meat to
> them than the 80 bytes worth of header :)
>

If you have any small programs that you worry about and/or some programs
that try to pull unusual (but valid) stunts, then I'd appreciate it if
you'd help test out the patches I'm creating and verify that they don't
cause any trouble - I already posted the first version of the patch to the
list today and more will follow.


-- Jesper Juhl


