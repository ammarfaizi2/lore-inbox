Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268312AbTBYVKh>; Tue, 25 Feb 2003 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268326AbTBYVKh>; Tue, 25 Feb 2003 16:10:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49796 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268312AbTBYVKf>; Tue, 25 Feb 2003 16:10:35 -0500
Date: Tue, 25 Feb 2003 22:47:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Michael Hayes <mike@aiinc.ca>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Spelling fixes for 2.5.63 - won't
In-Reply-To: <3E5BDADC.2040606@didntduck.org>
Message-ID: <Pine.LNX.3.95.1030225223828.21098A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Brian Gerst wrote:

> Michael Hayes wrote:
> > This fixes:
> >     wont -> won't (25 occurrences)
> > 
> > diff -ur a/arch/alpha/lib/ev6-stxcpy.S b/arch/alpha/lib/ev6-stxcpy.S
> > --- a/arch/alpha/lib/ev6-stxcpy.S	Mon Feb 24 11:05:04 2003
> > +++ b/arch/alpha/lib/ev6-stxcpy.S	Tue Feb 25 10:07:59 2003
> > @@ -128,7 +128,7 @@
> >  	ldq_u	t1, 0(a1)		# L : load first src word
> >  	and	a0, 7, t0		# E : take care not to load a word ...
> >  	addq	a1, 8, a1		# E :
> > -	beq	t0, stxcpy_aligned	# U : ... if we wont need it (stall)
> > +	beq	t0, stxcpy_aligned	# U : ... if we won't need it (stall)
> >  
> >  	ldq_u	t0, 0(a0)	# L :
> >  	br	stxcpy_aligned	# L0 : Latency=3
> 
> Be careful with apostrophes in asm files.  Some assemblers will barf on 
> them when not in C style comments.
> 
> --
> 				Brian Gerst

Actually, it's gcc that doesn't like that. The assembler works fine:

Script started on Tue Feb 25 22:32:13 2003
# cat xxx.S
foo:	xorl	%eax,%eax	# Don't do this!
	ret
# gcc -c -o xxx.o xxx.S
xxx.S:4: unterminated character constant
# as -o xxx.o xxx.S
# exit
exit
Script done on Tue Feb 25 22:35:07 2003

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


