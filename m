Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286662AbSABCpk>; Tue, 1 Jan 2002 21:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286650AbSABCpa>; Tue, 1 Jan 2002 21:45:30 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:55490 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S286654AbSABCpT>; Tue, 1 Jan 2002 21:45:19 -0500
Message-ID: <01a101c19337$88c1ef60$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Larry McVoy" <lm@bitmover.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.j24p57v.1d34p2v@ifi.uio.no> <fa.i865mpv.1g42885@ifi.uio.no>
Subject: Re: a great C++ book?
Date: Tue, 1 Jan 2002 21:45:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's hard to explain a love/hate relationship with C++.  I think many
> systems programmers come to a point where they can "speak" C++ and do so
> in design conversations all the time, talking about the "objects" and the
> "methods", etc.  But they program in C. [...] The reality is that you want
> tp program in a fairly object oriented way but you also want to avoid
> "the creeping horror that modern C++ has become.".

These statements resonate very strongly with my experience... A few times
already I've said to myself "today is the day I start using C++ instead of
C." But every time I've turned back.

To be fair, most of the problems I encountered were
quality-of-implementation issues rather than problems with C++ the language.
(The only serious complaint I have about C++ the language is the lack of
opaque types -- yes, I know of the famous "pimpl" idiom, and find its syntax
and inefficiency rather disgusting).

If you read Stroustrup's "The Design and Evolution of C++," [book
recommendation =)] you will gain an appreciation of the effort the language
designers spent to ensure that C++ imposed no overhead for features that
aren't used. However, I've found that G++ and the associated GNU
implementation of the C++ standard library do not really deliver on this
promise. The assembly code output by G++ is often cluttered with seemingly
unnecessary cruft (way beyond the expected overheads of e.g. virtual table
indirections for virtual function calls). And don't even get me started on
all the gunk it puts in your symbol table (run nm(1) on any C++ object and
you'll see what I mean). (yes I know about -fno-exceptions and -fno-rtti)

You might say, "who cares about crufty assembly here and there, much less
symbol table pollution?" While these issues might not concern the typical
application developer, I care very much about cleanliness of my code, and I
know the Linux kernel hackers are very aware of how their C code interacts
with GCC...

I long for the day when I will be able to declare a struct member private,
use inheritance, and declare a local variable anywhere in a basic block in
my code... But I need to have a clean C++ compiler and library
implementation with true pay-as-you-go overheads before I make the switch.

Regards,
Dan

