Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSLUWZT>; Sat, 21 Dec 2002 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSLUWZT>; Sat, 21 Dec 2002 17:25:19 -0500
Received: from [81.2.122.30] ([81.2.122.30]:58885 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265065AbSLUWZS>;
	Sat, 21 Dec 2002 17:25:18 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212212244.gBLMixLR002262@darkstar.example.net>
Subject: Re: Kernel GCC Optimizations
To: folkert@vanheusden.com
Date: Sat, 21 Dec 2002 22:44:59 +0000 (GMT)
Cc: lkml@ro0tsiege.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0212212307460.24398-100000@muur.intranet.vanheusden.com> from "folkert@vanheusden.com" at Dec 21, 2002 11:10:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Is there any risk using -O3 instead of -O2 to compile the
> > > kernel, and why?

> > * It might uncover subtle bugs that would otherwise not occur.

> I wonder: for the sake of performance and good use of the precious clock-
> cycles, shouldn't there be made a start of fixing those bugs? Assuming
> that the bugs you're talking about are not compiler-bugs, they *are* bugs
> in the code that should be fixed, shouldn't they?

There obviously are bugs in GCC, and the kernel team work around the
known ones.  This is part of the reason that there is a recommended
compiler version.  The Linux kernel also uses GCC compiler extensions,
and those can change between GCC versions.

The kernel has bugs too, but if they are not triggered by the
recommended version of GCC, then they might not get fixed immediately,
especially if the fix is non-trivial.

> > * Compiling with unusual options means that less people will know about
> > any problems it causes you.
> 
> So, let's make it -O6 per default for 2.7.x/3.1.x?

A higher -O setting does not necessarily mean better performance -
loop unrolling is one compiler optimisation that I *think* is
performed by GCC at high -O settings, and that *often* causes code to
be slower.

John.
