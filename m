Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbQJ3SBY>; Mon, 30 Oct 2000 13:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQJ3SBO>; Mon, 30 Oct 2000 13:01:14 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:14087 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129480AbQJ3SA7>; Mon, 30 Oct 2000 13:00:59 -0500
Message-ID: <39FDB623.74C200A7@timpanogas.org>
Date: Mon, 30 Oct 2000 10:55:47 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qEVX-0006ql-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

I've been studying Linux for the past two years the same way a diamond
cutter studies a 
prized and immensely valuable raw stone.   I think I am nearing the
point I know where to
strike and I can cleave it  into something Novell's installed base would
like and could move
forward with.  The easiest path I see for me to create a Linux NetWare
hybrid is for you 
guys to get a 2.2.X (not 2.4.X -- not just yet) tree that runs in a flat
memory space,
then I can slip in our optimizations and we will be able to run all
existing code in kernel
that's trusted.  The changes needed to do this involve more than just
the /arch area and 
the asm macro includes, though this will cover about 80% of it, but the
loader would need to 
be able to create address domains around aps that choose to run
protected.  

If I attempt these changes without proper guidance, two things will
happen.  1).  people who
own some of this code will not be aware of all the aspects of the
changes, and may not 
longer be able to support it, and 2).  it will fork away from the tree
and become 
unsupportable and diverge over time.  This is the reason I have resisted
making any 
kernel changes myself other than code I write for Linux I own, and I
have always 
solicitied other folks to make the patches.  This is about to change
relative to this
project.

The first step I need is to be able to load Linux as a ring 0 OS in
linear address space 
with all protection disabled.  Paging can still go on, just no separate
CR3 reloads between
context switches.   profiling Ring 0 Linux vs. NetWare will give me an
excellent idea of where 
the optimizations will need to be inserted.  A straight MARS-NWE port to
kernel would just
happen, since we would be able to just load in kernel space and run it
with no code 
changes.  

:-)

Jeff

Alan Cox wrote:
> 
> > one -- I've got extra licensed copies), install it, put a load of 5000
> > connections on it, with 4 adapters.  Dual boot Linux on it, and attempt
> > the same with SAMBA or MARS-NWE, and watch it oink.
> 
> SAMBA and Mars-nwe are running user space thats why. They have flexibility,
> protection and can run unpriviledged. If you want to put mars-nwe in the kernel
> then it will certainly be interesting
> 
> > back and tell me how TUX is going to solve the File and Print performance
> > issues in Linux.
> 
> There's an http file system around 8)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
