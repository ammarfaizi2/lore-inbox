Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265706AbRFXCMw>; Sat, 23 Jun 2001 22:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265707AbRFXCMm>; Sat, 23 Jun 2001 22:12:42 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:7941 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265706AbRFXCMc>;
	Sat, 23 Jun 2001 22:12:32 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules 
In-Reply-To: Your message of "Sat, 23 Jun 2001 21:56:06 -0400."
             <Pine.LNX.3.95.1010623214533.21862B-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jun 2001 12:12:24 +1000
Message-ID: <19093.993348744@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001 21:56:06 -0400 (EDT), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>FYI, structures are designed to be accessed only by their member-names.
>Therefore, the compiler is free to put members at any offset. In fact,
>members, other than the first, don't even have to be in the order
>written!

Bzzt!  I don't know where people get these ideas from.  Extracts from
the C9X draft.

  A structure type describes a sequentially allocated nonempty set of
  member objects (and, in certain circumstances, an incomplete array),
  each of which has an optionally specified name and possibly distinct
  type.

  When two pointers are compared ... If the objects pointed to are
  members of the same aggregate object, pointers to structure members
  declared later compare greater than pointers to members declared
  earlier in the structure.

  Two objects may be adjacent in memory because they are adjacent
  elements of a larger array or adjacent members of a structure with no
  padding between them,

  As discussed in 6.2.5, a structure is a type consisting of a sequence
  of members, whose storage is allocated in an ordered sequence,

  Within  a structure object, the non-bit-field members and the units
  in which bit-fields reside have addresses that increase in the order
  in which they are declared

C requires that members of a structure be defined in ascending address
order as specified by the programmer.  The compiler may not reorder
structure fields, although bitfields are a special case.

