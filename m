Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131063AbQKZLYB>; Sun, 26 Nov 2000 06:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131220AbQKZLXv>; Sun, 26 Nov 2000 06:23:51 -0500
Received: from 13dyn186.delft.casema.net ([212.64.76.186]:1299 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S131063AbQKZLXn>; Sun, 26 Nov 2000 06:23:43 -0500
Message-Id: <200011261052.LAA03592@cave.bitwizard.nl>
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <3a219890.57346310@mail.mbay.net> from John Alvord at "Nov 26, 2000
 05:01:03 am"
To: John Alvord <jalvo@mbay.net>
Date: Sun, 26 Nov 2000 11:52:37 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:
> On Sun, 26 Nov 2000 04:25:05 +0000 (GMT), Alan Cox
> <alan@lxorguk.ukuu.org.uk> wrote:
> 
> >>  AB> of changes that yield a negligable advantage and reduce stability
> >>  AB> a tiny little bit. That is pushing Linux in the direction of this
> >>  AB> abyss. You notice that the view gets better, and I get nervous.
> >> 
> >> Can somebody stop this train load of bunk?
> >> 
> >> Uninitialized global variables always have a initial value of
> >> zero.  Static or otherwise.  Period.
> >
> >That isnt what Andries is arguing about. Read harder. Its semantic differences
> >rather than code differences.
> >
> >	static int a=0;
> >
> >says 'I thought about this. I want it to start at zero. I've written it this
> >way to remind of the fact'
> >
> >Sure it generates the same code
> 
> It also says "I do not know much about the details of the kernel C
> environment. In particular I do not know that all static variables are
> initialized to 0 in the kernel startup. I have not read setup.S."

Nope. It doesn't say that. Maybe if you wrote the code. But if Andries
or I had written that line, it just says that when written the
programmer thought about the initial value, and that the initial value
matters on this variable. 

It is a concise form of documentation. As Andries explained, this can
also be done with comments or with 

	static int a /* = 0 */; 

However, I like the "=0" variant much better. 

If you're worried about the inefficiency of the compiler, take it up
with the compiler guys. Or write an extra preprocessor step or
something like that.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
