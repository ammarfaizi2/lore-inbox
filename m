Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSL0HN1>; Fri, 27 Dec 2002 02:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSL0HN0>; Fri, 27 Dec 2002 02:13:26 -0500
Received: from web13208.mail.yahoo.com ([216.136.174.193]:13835 "HELO
	web13208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264814AbSL0HNZ>; Fri, 27 Dec 2002 02:13:25 -0500
Message-ID: <20021227072142.26177.qmail@web13208.mail.yahoo.com>
Date: Thu, 26 Dec 2002 23:21:42 -0800 (PST)
From: Anomalous Force <anomalous_force@yahoo.com>
Subject: Re: holy grail
To: wa@almesberger.net
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021227010338.A1406@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Werner Almesberger <wa@almesberger.net> wrote:

[snip]

> An older or newer kernel would have different data structures, and
> possibly even data structures which are arranged in a different way
> (e.g. a hash becomes some kind of tree, etc.). So you'd need some
> translation mechanism that "upgrades" or "downgrades" all kernel
> data, including all pointers and offsets that may be sitting
> around somewhere. Good luck :-)

what if the new kernel asked the old kernel to hand over the data in
a form that was understood universally beginning at some kernel
version X (earliest supported kernel in other words). the data
would not have to remain in the optimized form that it would reside
in while under normal operations. it could be serialized as such into
a form that simply contains its content and context. im thinking of
something along the lines of a data packet (tcp/ip comes to mind)
that contains data about its data. a structure similar to that, which
conveys information describing the data its contains. any mechanisms
the newer kernel may institute would get set to a default state
similar to booting just that portion of the kernel.

> 
> Your best bet would be to use a system that already implements some
> form of checkpointing or process migration, and use this to
> preserve user space state across kexec reboots. openMosix may be

[snip]

preserving user state would not be so much the problem as would
the various internal kernel data structures (vm stuff, dcache, etc.)
the issue here is to freeze the system state, sys calls, irqs, and
all, and restart the same state where it left off after the switch.
the kernel would not need to boot, as an initial boot has already
been done by the previous kernel.

yes, it would be extremely difficult. but, as with all fields of
endevour, a holy grail is only such because it is. the question
remains, is this do-able? perhaps not now, or in two years, but
what about five? say, kernel 3.x.x or even 4.x.x?


=====
Main Entry: anom·a·lous 
1 : inconsistent with or deviating from what is usual, normal, or expected: IRREGULAR, UNUSUAL
2 (a) : of uncertain nature or classification (b) : marked by incongruity or contradiction : PARADOXICAL
synonym see IRREGULAR

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
