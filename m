Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132954AbQL2AOe>; Thu, 28 Dec 2000 19:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132956AbQL2AOY>; Thu, 28 Dec 2000 19:14:24 -0500
Received: from Cantor.suse.de ([194.112.123.193]:42500 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132954AbQL2AOP>;
	Thu, 28 Dec 2000 19:14:15 -0500
Date: Fri, 29 Dec 2000 00:43:47 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001229004347.B28063@gruyere.muc.suse.de>
In-Reply-To: <20001229002527.C25388@gruyere.muc.suse.de> <Pine.LNX.4.10.10012281536510.1123-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012281536510.1123-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 03:37:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 03:37:51PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Dec 2000, Andi Kleen wrote:
> > 
> > Hopefully all the "goto out" micro optimizations can be taken out then too,
> 
> "goto out" often generates much more readable code, so the optimization is
> secondary.

I was more thinking of cases like the scheduler's gotos, which has gotten
rather spagetti recently. Admittedly classic goto out is often more readable
than many nested if()s with error handling.

> 
> > I recently found out that gcc 2.97's block moving pass has the tendency
> > to move the outlined blocks inline again ;) 
> 
> Too bad. Maybe somebody should tell gcc maintainers about programmers that
> know more than the compiler again.

In x86-64 which relies on 2.97 I'm using __builtin_expect, defined to 
likely() and unlikely(), which seems to generate good code.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
