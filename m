Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSHLIEr>; Mon, 12 Aug 2002 04:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSHLIEr>; Mon, 12 Aug 2002 04:04:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26757 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317473AbSHLIEp>;
	Mon, 12 Aug 2002 04:04:45 -0400
Date: Mon, 12 Aug 2002 12:07:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>,
       <julliard@winehq.com>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <20020812173404.39d3abab.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, Stephen Rothwell wrote:

> > -	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
> > -	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
> > -	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
> > -	.quad 0x0040920000000000	/* 0x58 APM DS    data */
> > +	.quad 0x0040920000000000	/* 0x80 APM set up for bad BIOS's */
> > +	.quad 0x00409a0000000000	/* 0x88 APM CS    code */
> > +	.quad 0x00009a0000000000	/* 0x90 APM CS 16 code (16 bit) */
> > +	.quad 0x0040920000000000	/* 0x98 APM DS    data */
> 
> I just lost 0x40 which needs to be exactly 0x40 if it is do its job
> (i.e. cope with brain dead BIOS writers using 0x40 as a segment offset
> in protected mode ...

you can save/restore 0x40 in kernel-space if you need to no problem.

> The idea is that segment 0x40 maps from physical address 0x400 to the
> end of the first physical page.  As a real mode program would (more or
> less) expect it to.

so you are using the kernel's GDT in real mode as well?

	Ingo

