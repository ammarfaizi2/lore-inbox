Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316995AbSFKKnv>; Tue, 11 Jun 2002 06:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSFKKnu>; Tue, 11 Jun 2002 06:43:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29967 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316995AbSFKKnu>; Tue, 11 Jun 2002 06:43:50 -0400
Date: Tue, 11 Jun 2002 11:43:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Double quote patches part one: drivers 1/2
Message-ID: <20020611114344.B3081@flint.arm.linux.org.uk>
In-Reply-To: <20020611084758.B1346@flint.arm.linux.org.uk> <Pine.LNX.4.44.0206110422110.24261-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 04:24:01AM -0600, Thunder from the hill wrote:
> On Tue, 11 Jun 2002, Russell King wrote:
> > 1. Spaces -> source bloat.
> 
> No spaces -> looks unsatisfying, someone mentioned.

Authors taste.

> > 2. No tab at the start of the file -> yuck when reading the ASM.
> 
> What do you mean by that?

Ever tried:

make kernel/fork.s

and then read kernel/fork.s ?  Yes, some people who care about getting
the best out of the kernel do convert C to assembly and then read the
result.  If there's something really yucky in there, then you go back
and fix it in the C source.

> > My preferred way of fixing these in ARM stuff is to add <tab><tab><tab>\n\
> > to each line (with the appropriate number of tabs.  See
> > arch/arm/kernel/semaphore.c for an example.
> 
> Hmm... Wasn't that the behavior we wanted to fix with the concatenated 
> strings?

"behaviour" or "style".  I prefer my style for the code I maintain, which
is close to Linus' style.  There is no current style for fixing gcc 3.x
stuff, so its up to the authors of the code to set the style.  I've
decided on one which matches the style of my multi-line macros for
consistency sake.  I'd rather not invent another style for multi-line
asm.

Sure, both "fix" the underlying problem.  But how readable is it in the
end?

BTW, your sig is being messed up by the mixture of spaces and tabs:

> German attitude becoming        |	Thunder from the hill at ngforever
> rightaway popular:		|
>        "Get outa my way,  	|	free inhabitant not directly
>     for I got a mobile phone!"	|	belonging anywhere

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

