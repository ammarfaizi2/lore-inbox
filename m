Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbQJaI0t>; Tue, 31 Oct 2000 03:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQJaI0j>; Tue, 31 Oct 2000 03:26:39 -0500
Received: from oe8.law11.hotmail.com ([64.4.16.112]:38666 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129068AbQJaI02>;
	Tue, 31 Oct 2000 03:26:28 -0500
X-Originating-IP: [24.164.154.68]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <OE58erOc0Ne0PaLI9mK000004a6@hotmail.com> <20001030130006.B1555@werewolf.cps.unizar.es>
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
Date: Tue, 31 Oct 2000 03:13:21 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE8NY1SWoBDyseVwrbl00001203@hotmail.com>
X-OriginalArrivalTime: 31 Oct 2000 08:26:22.0404 (UTC) FILETIME=[40543040:01C04314]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > files in the kernel will all be happy in Linuxland.  Can any external
>
> Why do you need to touch any existing kernel .c source file ? If you make
> that patch, this breaks "situation 1" above.

    It doesn't break situation 1 as the minor changes I've made to those 2 C
files should not have changed any outputted code.  The change was only in
the offending parameter names.

> AFAIK, ANSI C does not require that prototype (declaration) parameter
names and
> definition parameter names match, only types. So, this snippet is correct:
>
> int f(int onename);
>
> int f(int othername)
> {
> }

    I think good style requires that the parameter names match in the
function prototype and its declaration.  Besides which if I remember
correctly the latest C++ standard does require that the parameter names
match and the next C standard might follow suit.  But I think that is a
minor issue, I only updated the C files (minimally at that) to keep
consistency.

> The "klass" example is directly taken from XFree header files, look at
> vi +239 /usr/X11R6/include/X11/Xlib.h
> vi +898 /usr/X11R6/include/X11/Xlib.h
>
> So the core X internals, written in C, use the "class" field, but anyone
using
> X in C++ programs has to use the field as "klass" or "c_class".

    I bought up a solution like this before and it was mostly argued
against.

>
> I think X is a good example to provide C++ friendlyness with the minimal
> internal
> change. Perhaps this is a way to make kernel programmers-mantainers to
accept
> the
> headers patch, they can continue working the same...

    The kernel gods will have to give their opinion on this.  Should a
"proper" fix be implemented for the offending variable names or should a
workaround be implemented.  Or perhaps a combination depending on whether
the change breaks any external utilities and how bad a break that is (I say
external utilities as I can update all the files in the kernel itself).  I
am inclined to think that the proper fix should be done unless something
important break in which case the ugly workaround can be used in those
limited cases.  However my mind is open to be changed.  After all the ugly
workaround would actually be easier for me, one Perl script.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
