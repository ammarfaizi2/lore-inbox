Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTLET6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTLET6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:58:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28544
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264374AbTLET5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:57:30 -0500
Date: Fri, 5 Dec 2003 20:58:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oom killer in 2.4.23
Message-ID: <20031205195800.GB2121@dualathlon.random>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it> <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205140520.39289a3a.kristian.peters@korseby.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 02:05:20PM +0100, Kristian Peters wrote:
> Andrea Arcangeli <andrea@suse.de> schrieb:
> > Marcelo asked me to to make it configurable at runtime so you could go
> > in the deadlock prone stautus of 2.4.22 on demand, but I'm not going to
> > add more features to 2.4 today unless they're blocker bugs (even if that
> > would be simple to implement), actually it's not even my choice so don't
> > ask me for that sorry.
> 
> Andrea, your vm does not work correctly in any cases.

what you're complaining is the 'selection of the task to be killed'.
That's not solvable. the kernel can't read your brain period. Only if
the kernel could read the brain of the adminstrator then you would be
happy, there is no way the kernel can know which is the task you really
want to have killed first.

> It's so simple. I've tried to fill up my memory with that crappy
> khexedit that comes with kde2. You'll see how my memory fills with the
> contents of the whole file I load. When I have started 2 or 3
> instances of khexedit my memory was nearly completely filled. Than I
> tried to start another khexedit (with a file that should nearly fit
> into memory), and the pain began.

The kernel can't know what is a pain for you and what is pain for other
people.

Measuring the page fault rate seems to get the closest heuristic that
may not be a pain for most people, all current oom killers are a pain
for somebody, desktop users where pretty much fine with 2.4.22, server
users had pain with 2.4.22 and should have less pain with 2.4.23. There
is no way to make everybody happy in 2.4.

> Rick's old vm worked better. It'd have killed the task that had last allocated memory.

it was the biggest one that's why. the old omm killer gets your desktop
scenario always correctly, true, (as far as your biggest task doesn't
get stuck on nfs etc..)

> PS: If you need more details it should be no problem to do this again.

I'm aware about those issues, that's a feature not a bug.
