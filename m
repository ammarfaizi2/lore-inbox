Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTFHTul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 15:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTFHTul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 15:50:41 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:31784 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S263737AbTFHTuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 15:50:39 -0400
From: Jos Hulzink <josh@stack.nl>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: What are .s files in arch/i386/boot
Date: Sun, 8 Jun 2003 22:04:15 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org> <6un0gty981.fsf@zork.zork.net> <bbtlc6$qtd$1@cesium.transmeta.com>
In-Reply-To: <bbtlc6$qtd$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306082204.16079.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 Jun 2003 23:27, H. Peter Anvin wrote:
> Followup to:  <6un0gty981.fsf@zork.zork.net>
> By author:    Sean Neakums <sneakums@zork.net>
> In newsgroup: linux.dev.kernel
>
> > James Stevenson <james@stev.org> writes:
> > >> > > What are .s files in arch/i386/boot, are they c sources of some
> > >> > > sort? Where can I find the specifications documents they were made
> > >> > > from?
> > >> >
> > >> > There are not c files.
> > >> > They are assembler files
> > >> >
> > >> Where can I find the .c files they were made from,
> > >> and the spec sheets the .c files were made from?
> > >
> > > You would have to find the original author of the person
> > > who tweaks the assembler in the .s file chances are the .c
> > > file is long gone though.
> >
> > If there were ever C files to begin with.  It's not unheard-of for
> > people to write assembler code from scratch.
>
> The ones in the Linux kernel were all written from scratch.

And for a very good reason. A few things really need asm, for example getting 
a CPU in protected mode, setting up the MMU and stuff. Once they are set up, 
you can use C, though sometimes you must be really sure what your compiler 
will make from the C.

So, why assembly ? Cause it is needed. Why in arch/i386/boot ? for if it is 
well done there, it isn't needed at many other locations. A few things will 
still require asm though, therefore you'll find more .s files in arch/i386. 

Jos
