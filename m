Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWEBFMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWEBFMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWEBFMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:12:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10756 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932366AbWEBFMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:12:41 -0400
Date: Tue, 2 May 2006 07:12:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <20060502051238.GB11191@w.ods.org>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 04:53:47PM -0700, David Schwartz wrote:
> 
> > > The cost in developer time is borne once. The cost of performance
> > > is borne every time you run the application.
> 
> > The cost in developer time is borne every time someone needs to
> > modify the code.
> 
> 	Or understand the code. Or debug the code. Or verify that the code operates
> correctly. Or reuse the code for another purpose.
> 
> 	In the bad old days, performance was the number one priority because
> computers were slow and resources were scarce -- if you didn't your code
> wasn't usable. There is still a small amount of code where performance is
> truly the most important priority. Certainly, very low-level kernel code
> falls in this category.
> 
> 	We aren't in the bad old days anymore. And there are quite a few things
> that are important other than performance. Clear, simple code is easier to
> understand and maintain and more likely to be correct.

Sorry , but all the examples that have been given in C++ are clearly
unreadable and impossible to understand. I'd also like to note that
people were arguing about what the code was really doing, this means
that this language is absolutely not suited to such usages where you
want to know the exact behaviour. At least in C, this sort of thing
has never happened. People argue about what must be locked and important
things like this you'd never want the compiler to decide for you.

> Modifications are
> less likely to break hidden dependencies. Code that isn't heavily optimized
> is more likely to be secure.

To be secure, you first have to understand what the code precisely does,
not what it should do depending on how the compiler might optimise it.

> 	And the supreme irony is that the code often performs better anyway! There
> are a lot of reasons why this is often the case. For example, clearer more
> modular code is easier to optimize algorithmically. Hand optimizations may
> remain in code long past the point where they made sense and to the point
> where they become pessimizations because of new CPU architectures or smarter
> compilers. Poor code organization mixes performance-critical code with code
> that's not performance-critical so that the critical code is harder to
> identify and optimize.
> 
> 	I am not saying that the use of C++ over C is likely to improve
> performance. I'm saying that there's a lot of code where performance is not
> the most important priority, and that this type of code accounts for the
> majority of code in a monolithic kernel.

I'm still thinking that people who have problems understanding what the
code does want a level of abstraction between them and the CPU so that
the compiler thinks for them. I still don't see the *current* problem
you are trying to fix. Linux is written in C, as many other kernels and
it works. Nobody knows what it would become if rewritten in C++. Maybe
it will be better, maybe it would not run anymore on embedded systems,
maybe it would become fully buggy because nobody except a little bunch
of C++ coders would understand it... At least, I'm sure it will not be
the smart people who currently work on it.

Best of all, I'm even sure that people who are trying to push C++ in
the kernel would never ever write a line of code once it would be
accepted, because they don't seem to know what they're talking about
when it applies to kernel code.

> 	DS

Regards,
Willy

