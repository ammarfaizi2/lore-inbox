Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287429AbSAGXsh>; Mon, 7 Jan 2002 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSAGXsa>; Mon, 7 Jan 2002 18:48:30 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:40333 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S287407AbSAGXrN>;
	Mon, 7 Jan 2002 18:47:13 -0500
From: mike stump <mrs@windriver.com>
Date: Mon, 7 Jan 2002 15:46:27 -0800 (PST)
Message-Id: <200201072346.PAA12163@kankakee.wrs.com>
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: dewar@gnat.com
> To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
> Date: Sun,  6 Jan 2002 14:29:01 -0500 (EST)

> > Do you have an example where this fails?  Do you not consider it a bug?

> I don't see the obligation on the compiler here.

I think you mean that if one pedantically misreads the C standard and
its intent to the widest extent possible just within the confines of
the langauge document that the standard doesn't compell it.  If so, we
might be able to agree.

> Now if you are saying that this is a reasonable expectation, nothing
> to do with the standard, then that's another matter, but my example
> of a tradeoff with efficiency is an interesting one.

Pragmatically, not really.

Hum, where in that standard does it say that the compiler won't
scribble all over memory?  If it doesn't, does that mean that within
the confines of the language standard that the compiler can?  If you
produce an Ada compiler that did, do you think your users would feel
better when you told them you were allowed to by the language
standard?

The point can only be extreme misreading of a standard.

Just because you can invent some nonsensical mapping for C onto our
machines, doesn't mean we should.  Nor should we confuse users with
the notion that we could have a nonsensical compiler, if we wanted.

For example, it is perfectly within the rights of an implementor of C
to say that all volatile access will be 32 bus cycles that are 4 byte
aligned.  In this case, trivially we see that promoting your short
read to a 32 read is perfectly fine.  If a chip required it, it would
be reasonable (to the user).
