Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSJaV5t>; Thu, 31 Oct 2002 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJaV5t>; Thu, 31 Oct 2002 16:57:49 -0500
Received: from ns.suse.de ([213.95.15.193]:41999 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265373AbSJaV5q>;
	Thu, 31 Oct 2002 16:57:46 -0500
Date: Thu, 31 Oct 2002 23:04:11 +0100 (CET)
From: Bernhard Kaindl <bk@suse.de>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       <lkcd-general@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <20021031160800.M18072@redhat.com>
Message-ID: <Pine.LNX.4.33.0210312221490.6945-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Benjamin LaHaise wrote:
> On Thu, Oct 31, 2002 at 12:40:28PM -0800, Linus Torvalds wrote:
> > And imnsho, debugging the kernel on a source level is the way to do it.
> >
> > Which is why it's not going to be me who merges it.
> >
> > Read my emails.
>
> That is one of the reasons that crash dumps are useful.  Quite a few
> problems that customers hit are not easy to reproduce, but when they
> provide a dump file that can be loaded into gdb with the original
> kernel debugging info and the backtrace command issued and various
> bits of internal structures examined, usually a good hypothesis can
> be made for the cause.  Feed that back into a code audit and you end
> up fixing problems that are decidedly challenging.
>
> 		-ben

I could not have said it better. I've a good real-life example for it,
one which really happened and one just as example to give an image.

[ I'm not an expert, I'm just writing about my experiance ]
[ in order to try to make linux even better than it is    ]

About debugging at source level:

Dump analysis does not say that you are not debugging on a source level,
with a vmlinux compiled with -g, (which could be stripped before making
the image) crash analysis tools could operate at source level(depending
on the compiler's reorderings of course, the assumtion that -O2 maps
source:binary 1:1 is of course not from this world)

An analogy to doctors, hospitals and patients:

dump analysis says you don't need to have a living patient
in order to cure a disease. It says you may have slept on the
other side of the world while the disease murdered your fellow
at home. But as you don't like that it happens again to another
fellow, you want to have a remote lab which gives you every info
you need to have in order to know what might have murdered him.

The dump tools are this remote lab. If you don't have it, you
may need to fly over to the site where the disease is, monitor
the patient and try to find out what's happening and you can't
find out what's up without at least one another dead patient at
the end.

But the hospital may not like to even have one single dead
patient more than neccesary(best 0) and would choose a doctor
who has the remote lab where he can quickly check what's up
and find a cure *before* the next patient gets ill.

Back to the computer world, this would mean that an OS having
the remote lab(dump tools) would be favoured over on OS that
don't has. The same goes for LTT and Dynamic Probes.

Back to crash dump: In some environments like laboratory or blood
bank information systems you need to use computers in order to
efficiently process, store and distribute data, and organize
the handling of blood. In such environments, the life of people
can change on a fast, efficiently and stably working organsation.

Of course you need to be able to recover and continue such
organisation even with the laboratory information system being
down for a reboot or maintenance.

But you simply cannot go there, halt all the distributed information
retrieval and automated job control with the laboratory apparatuses,
block all the users(maybe thousands) for debugging the kernel and
check what is going on while the whole hospital is waiting for you.

Of course you can do this, but only once or only in at a time
where every use of the system can be organized to bypass it und
use paper, in-house mail and phone to do the things the system
is normally doing. A hospital with thousands of patients cannot
wait while debugging.

> Which is why it's not going to be me who merges it.

Sure, but it would help Linux World Domination if the base
kernel would support it also.

Bernd

PS: Sorry for the extreme example but this is an example
I know from my previous work and I've just tried to describe
it as real as possible.

