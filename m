Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUG3Uty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUG3Uty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUG3Utx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:49:53 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:31669 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S267831AbUG3Uts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:49:48 -0400
Date: Fri, 30 Jul 2004 22:48:28 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kumar.gala@freescale.com, tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-Id: <20040730224828.0f06e37a.pochini@shiny.it>
In-Reply-To: <20040730190731.GQ16468@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net>
	<XFMail.20040729100549.pochini@shiny.it>
	<20040729144347.GE16468@smtp.west.cox.net>
	<20040730205901.4d4181f4.pochini@shiny.it>
	<20040730190731.GQ16468@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 12:07:31 -0700
Tom Rini <trini@kernel.crashing.org> wrote:

> 
> On Fri, Jul 30, 2004 at 08:59:01PM +0200, Giuliano Pochini wrote:
> 
> > On Thu, 29 Jul 2004 07:43:47 -0700
> > Tom Rini <trini@kernel.crashing.org> wrote:
> > > > I had no time to do a lot of testing, but it seems that binutils 2.15 +
> > > > gcc 3.3.3 is a bad one too. I didn't try to compile the kernel (which
> > > > may also break), but at least I couldn't compile gcc 3.4.1 with the
> > > > above combination. It seems that as doesn't get the -mxxx parameter
> > > > required to compile altivec stuff. Hacking the Makefile to make it
> > > > pass -Wa,-m7455 helped a little, but it eventually failed in another
> > > > weird way. I hadn't time to investigate further, sorry.
> > >
> > > Stock gcc-3.3.3 or from the hammer branch ?
> >
> > Stock.
>
> That is interesting.

Actually, I don't know what the "hammer" thing is. I downloaded gcc from one
of the gcc.gnu.org mirrors: IIRC ftp://ftp.irisa.fr/pub/mirrors/gcc.gnu.org/gcc/releases/gcc-3.4.1


> Olaf, is gcc-3.3.x + binutils-2.15 one of the
> combinations you've got in your matrix of toolchains?


gcc 3.3.3 + binutils 2.15 fails quite soon here:

  AS      arch/ppc/kernel/l2cr.o
arch/ppc/kernel/l2cr.S: Assembler messages:
arch/ppc/kernel/l2cr.S:110: Error: Unrecognized opcode: `dssall'
arch/ppc/kernel/l2cr.S:278: Error: Unrecognized opcode: `dssall'
arch/ppc/kernel/l2cr.S:387: Error: Unrecognized opcode: `dssall'
make[1]: *** [arch/ppc/kernel/l2cr.o] Error 1



--
Giuliano.
