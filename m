Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265709AbRFXCn5>; Sat, 23 Jun 2001 22:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265710AbRFXCnr>; Sat, 23 Jun 2001 22:43:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:65408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265709AbRFXCnc>; Sat, 23 Jun 2001 22:43:32 -0400
Date: Sat, 23 Jun 2001 22:43:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules 
In-Reply-To: <19093.993348744@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.95.1010623224028.22442A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Keith Owens wrote:

> On Sat, 23 Jun 2001 21:56:06 -0400 (EDT), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >FYI, structures are designed to be accessed only by their member-names.
> >Therefore, the compiler is free to put members at any offset. In fact,
> >members, other than the first, don't even have to be in the order
> >written!
> 
> Bzzt!  I don't know where people get these ideas from.  Extracts from
> the C9X draft.
> 
>   A structure type describes a sequentially allocated nonempty set of
>   member objects (and, in certain circumstances, an incomplete array),
>   each of which has an optionally specified name and possibly distinct
>   type.
> 
>   When two pointers are compared ... If the objects pointed to are
>   members of the same aggregate object, pointers to structure members
>   declared later compare greater than pointers to members declared
>   earlier in the structure.
> 
>   Two objects may be adjacent in memory because they are adjacent
>   elements of a larger array or adjacent members of a structure with no
>   padding between them,
> 
>   As discussed in 6.2.5, a structure is a type consisting of a sequence
>   of members, whose storage is allocated in an ordered sequence,
> 
>   Within  a structure object, the non-bit-field members and the units
>   in which bit-fields reside have addresses that increase in the order
>   in which they are declared
> 
> C requires that members of a structure be defined in ascending address
> order as specified by the programmer.  The compiler may not reorder
> structure fields, although bitfields are a special case.
> 

Previous to the "Draft" "Proposal" of C98, there were no such
requirements. And so-called ANSI -C specifically declined to
define any order within structures.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


