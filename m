Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbRFXQMJ>; Sun, 24 Jun 2001 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFXQMA>; Sun, 24 Jun 2001 12:12:00 -0400
Received: from brussel-ns1.xs4all.be ([195.144.67.168]:18949 "EHLO
	brussel-ns1.xs4all.be") by vger.kernel.org with ESMTP
	id <S264260AbRFXQLj>; Sun, 24 Jun 2001 12:11:39 -0400
Date: Sun, 24 Jun 2001 18:11:31 +0200 (CEST)
From: frank@gevaerts.be
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules 
In-Reply-To: <Pine.LNX.3.95.1010623224028.22442A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0106241811030.20163-100000@turing.gevaerts.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001, Richard B. Johnson wrote:

> On Sun, 24 Jun 2001, Keith Owens wrote:
> 
> > On Sat, 23 Jun 2001 21:56:06 -0400 (EDT), 
> > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > >FYI, structures are designed to be accessed only by their member-names.
> > >Therefore, the compiler is free to put members at any offset. In fact,
> > >members, other than the first, don't even have to be in the order
> > >written!
> > 
> > Bzzt!  I don't know where people get these ideas from.  Extracts from
> > the C9X draft.
> > 
> >   A structure type describes a sequentially allocated nonempty set of
> >   member objects (and, in certain circumstances, an incomplete array),
> >   each of which has an optionally specified name and possibly distinct
> >   type.
> > 
> >   When two pointers are compared ... If the objects pointed to are
> >   members of the same aggregate object, pointers to structure members
> >   declared later compare greater than pointers to members declared
> >   earlier in the structure.
> > 
> >   Two objects may be adjacent in memory because they are adjacent
> >   elements of a larger array or adjacent members of a structure with no
> >   padding between them,
> > 
> >   As discussed in 6.2.5, a structure is a type consisting of a sequence
> >   of members, whose storage is allocated in an ordered sequence,
> > 
> >   Within  a structure object, the non-bit-field members and the units
> >   in which bit-fields reside have addresses that increase in the order
> >   in which they are declared
> > 
> > C requires that members of a structure be defined in ascending address
> > order as specified by the programmer.  The compiler may not reorder
> > structure fields, although bitfields are a special case.
> > 
> 
> Previous to the "Draft" "Proposal" of C98, there were no such
> requirements. And so-called ANSI -C specifically declined to
> define any order within structures.

Maybe Ansi didn't but K&R certainly did

Frank

> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

HI! I'm a .signature virus! cp me into your .signature file to help me spread!

