Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264407AbRFXTUv>; Sun, 24 Jun 2001 15:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264413AbRFXTUm>; Sun, 24 Jun 2001 15:20:42 -0400
Received: from uu212-190-158-41.unknown.uunet.be ([212.190.158.41]:32004 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S264407AbRFXTUf>; Sun, 24 Jun 2001 15:20:35 -0400
From: "Lieven Marchand" <mal@wyrd.be>
To: root@chaos.analogic.com
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <Pine.LNX.3.95.1010623224028.22442A-100000@chaos.analogic.com>
Date: 24 Jun 2001 18:07:39 +0200
In-Reply-To: "Richard B. Johnson"'s message of "Sat, 23 Jun 2001 22:43:14 -0400 (EDT)"
Message-ID: <m3ae2xn9o4.fsf@localhost.localdomain>
X-Mailer: Gnus v5.5/XEmacs 20.4 - "Emerald"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

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

It would be nice it you would occasionally check the stuff you
pontificate about.

The last sentence of the quoted paragraph appears verbatim in the ANSI
X3.159-1989 specification in 3.5.2.1.

-- 
Lieven Marchand <mal@wyrd.be>
You can drag any rat out of the sewer and teach it to get some work done in
Perl, but you cannot teach it serious programming.              Erik Naggum
