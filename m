Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129426AbQKZFlC>; Sun, 26 Nov 2000 00:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129415AbQKZFkm>; Sun, 26 Nov 2000 00:40:42 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9745
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129345AbQKZFke>; Sun, 26 Nov 2000 00:40:34 -0500
Date: Sat, 25 Nov 2000 21:10:19 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <3a219890.57346310@mail.mbay.net>
Message-ID: <Pine.LNX.4.10.10011252106330.10651-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, John Alvord wrote:

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

Are you positive for modules too...

Regardless of the fact you have displayed, some of us prefer to clobber it
to insure that it stays zero until access.  Last thing you want is an
unstatic static when we go to spin a disk for data.

Just how warm and fuzzy do you fell if your block drivers do not insure
this point?

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
