Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSDJQio>; Wed, 10 Apr 2002 12:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDJQin>; Wed, 10 Apr 2002 12:38:43 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:24332 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S313293AbSDJQim>;
	Wed, 10 Apr 2002 12:38:42 -0400
Date: Wed, 10 Apr 2002 11:43:13 -0500 (CDT)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: Oleg Drokin <green@linuxhacker.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse interrupts: the death knell of a VP6
In-Reply-To: <20020410192339.A22777@namesys.com>
Message-ID: <20020410112810.L60900-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Oleg Drokin wrote:

> Hello!
>
> On Wed, Apr 10, 2002 at 09:02:05AM -0500, Brent Cook wrote:
>
> > I have an ABIT VP6 motherboard, using the VIA Apollo chipset and 2 700Mhz
> > PIII's, but please don't hold that against me. The system is running
> > 2.4.19-pre6. I believe that I either have a system that has trouble
> > handling a sudden bursts of interrupts, or have found a fault in mouse
> > handling.
>
> Have you tried to change MPS mode to 1.1 from 1.4 (I see addres message timeouts
> in your log)?

No, I had not. I will though, and will report if this causes some change.
Everything looks fine for the first five minutes though.

> > I have already tried removing memory, adding memory, changing processors,
> > video cards. The only thing that has remained constant is the VP6
> > motherboard and the hard drive.
>
> My VP6 died on me recently with some funny symptoms:
> it hangs in X when I start netscape and move mouse, or if I do
> bk clone on kernel tree, it dies with
> kernel BUG at /usr/src/linux-2.4.18/include/asm/smplock.h:62!

Very interesting. I could do the same thing, and have a similar lock with
a PS/2 mouse. I will start looking in smplock.h if the MPS change does not
help.

> BUG in various places pretty soon.
> (this BUG is only appears if 2 CPUs are present in motherboard).
> So if your troubles began only recently, you might want to try another
> motherboard just to be sure.

I received the motherboard used, so I do not know if this is a recent
development. I have tried several other kernels which all show the same
locking behavior with PS/2 mice (2.4.17, 2.4.18, 2.5.7-dj3.) The previous
owner ran Windows XP (developer preview) on the board, and it had a
tendency to lock often, especially under high IO. I attributed this to
software issues, though now I wonder why the previous owner _really_ gave
it to me!

I have used a Tyan Tiger 100 with two processors and an Intel BX chipset,
with great success and no similar locks, so I am 50% certain that a
hardware difference is the root cause of the problem. Hopefully, someone
else will have seen similar problems.

> Bye,
>     Oleg
>

