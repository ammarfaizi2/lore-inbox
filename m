Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTLJRnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLJRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:43:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:24448 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263777AbTLJRnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:43:50 -0500
Date: Wed, 10 Dec 2003 09:42:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
Message-ID: <Pine.LNX.4.58.0312100923370.29676@home.osdl.org>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Hua Zhong wrote:
>
> > What has meaning for "derived work" is whether it stands on its own or
> > not, and how tightly integrated it is. If something works
> > with just one particular version of the kernel - or depends on things like
> > whether the kernel was compiled with certain options etc - then it pretty
> > clearly is very tightly integrated.
>
> Many userspace programs fall into this category too.

Absolutely.

Trust me, REAL LAWYERS WERE WORRIED about this. It wasn't just random tech
people discussing issues on a technical (or, right now, not-so-technical)
mailing list.

There's a reason for those lines at the top of the COPYING file saying
that user space is not covered, and there are literally lawyers who say it
would hold up in a court of law.

Exactly because you _can_ argue that user-space might be covered. It's an
argument that almost certainly would fail very quickly due to "documented
interfaces" and ABI issues, but it is an argument that lawyers have made,
and it's that argument that makes the disclaimer in COPYING be worth it.

In other words: even without that disclaimer of derivation, user space
would almost certainly (with a very high probability indeed) be safe from
a copyright infringement suit. Such a suit would most likely be thrown out
very early, exactly because the UNIX system call interface is clearly
extensively documented, and the Linux implementation of it has strived to
be a stable ABI for a long time.

In fact, a user program written in 1991 is actually still likely to run,
if it doesn't do a lot of special things. So user programs really are a
hell of a lot more insulated than kernel modules, which have been known to
break weekly.

Similarly, things like /proc etc are clearly intended to be ways to
interface to the kernel in user space, so there's a clear intent there
that nobody can reasonably deny (again, that intent is made _clearer_ by
the COPYING disclaimer, but it would be hard to argue against even in the
absense of that).

But even DESPITE these strong arguments that user-space clearly isn't a
derived work, and real lawyers worried, and felt much happier with the
explicit disclaimer in the COPYING file.

That should tell you something. In particular, it should tell you to be
careful: some courts have made so broad "derivative work" judgements that
it's scary - think about the "Gone With the Wind" parody (I think the
ruling was eventually overturned on First Amendment grounds, but the
point is that you should be very careful, and while source code has
the potential for First Amendment protection, binary modules sure as hell
do not).

And please note that I am _not_ arguing for those overly broad judgements:
I'm just pointing out that you should not assume that "derivative" is
something simple. If an author claims your work is derivative, you should
step very very lightly.

And I claim that binary-only kernel modules ARE derivative "by default",
by virtue of having no meaning without the kernel.

		Linus
