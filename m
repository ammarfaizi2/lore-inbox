Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266599AbRGEBll>; Wed, 4 Jul 2001 21:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266600AbRGEBlb>; Wed, 4 Jul 2001 21:41:31 -0400
Received: from smarty.smart.net ([207.176.80.102]:63759 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S266599AbRGEBlW>;
	Wed, 4 Jul 2001 21:41:22 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107050154.VAA21513@smarty.smart.net>
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: meissner@spectacle-pond.org (Michael Meissner)
Date: Wed, 4 Jul 2001 21:54:05 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010704210227.A19675@munchkin.spectacle-pond.org> from "Michael Meissner" at Jul 04, 2001 09:02:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Jul 03, 2001 at 11:37:28PM -0400, Rick Hohensee wrote:
> > That's with the GNU tools, without asm(), and without proper declaration
> > of printf, as is my tendency. I don't actually return an int either, do I?
> > LAAETTR.
> 
> Under ISO C rules, this is illegal, since you must have a proper prototype in
> scope when calling variable argument functions.  In fact, I have worked on
> several GCC ports, where the compiler uses a different calling sequence for
> variable argument functions than it does for normal functions.  For example, on
> the Mips, if the first argument is floating point and the number of arguments
> is not variable, it is passed in a FP register, instead of an integer
> register.  For variable argument functions, everything is passed in the integer
> registers.
> 

I didn't know that, but...

You seem to be saying the use of assumptions about args passing is
non-standard. I know. It's more standard than GNU extensions to C though,
C_labels_in_asms in particular, and even in your examples it appears that
the particular function abusing these tenets will know what it can expect
from a particular compiler, since it knows what it's arguments are. It
can't know what it can expect from any compiler. This perhaps is where
#ifdef comes in, or similar. Well, it's not more standard than GNU, but
the differences would be less detailed in the case of just dealing with
various args passing schemes, and there may be some compiler-to-compiler
overlap, where there won't be any with stuff like C_labels_in_asms.

It's illegal to not declare main() as int. I don't know of a unix that
actually passes anything but a byte to the calling process. I got flamed
mightily for this in comp.unix.programmer until people ran some checks on
thier big Real Unix(TM) boxes of various types. Linux won't pass void
either, you have to get a 0 at least. Compliance is subjective. It's
easier when things make sense.

Rick Hohensee
www.clienux.com


> -- 
> Michael Meissner, Red Hat, Inc.  (GCC group)
> PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
> Work:	  meissner@redhat.com		phone: +1 978-486-9304
> Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
> 

