Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRCWWJr>; Fri, 23 Mar 2001 17:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbRCWWJg>; Fri, 23 Mar 2001 17:09:36 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:18697 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131472AbRCWWJZ>; Fri, 23 Mar 2001 17:09:25 -0500
Date: Sat, 24 Mar 2001 00:18:03 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Paul Jakma <paulj@itg.ie>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.33.0103232026310.31380-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.30.0103232312440.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Mar 2001, Paul Jakma wrote:
> On Fri, 23 Mar 2001, Szabolcs Szakacsits wrote:
> > About the "use resource limits!". Yes, this is one solution. The
> > *expensive* solution (admin time, worse resource utilization, etc).

Thanks for cutting out relevant parts that said how to increase user
base and satisfaction keeping and using the existent possibility as
well.

> traditional user limits have worse resource utilisation? think what
> kind of utilisation a guaranteed allocation system would have. instead
> of 128MB, you'd need maybe a GB of RAM and many many GB of swap for
> most systems.

Nonsense hodgepodge. See and/or mesaure the impact. I sent numbers in my
former email. You also missed non-overcommit must be _optional_ [i.e.
you wouldn't be forced to use it ;)]. Yes, there are users and
enterprises who require it and would happily pay the 50-100% extra swap
space for the same workload and extra reliability.

> - setting up limits on a RH system takes 1 minute by editing
> /etc/security/limits.conf.

At every time you add/delete users, add/delete special apps, etc.
Please note again, some people wants this way, some only for sometimes,
and others really don't care because system guarantees for the admins
they will always have the resources to take action [unfortunately this
is not Linux].

> - Rik's current oom killer may not do a good job now, but it's
> impossible for it to do a /perfect/ job without implementing
> kernel/esp.c.

Rik's killer is quite fine at _default_. But there will be always people
who won't like it [the bastards think humans can still make better
decisions than machines]. Wouldn't it be win for both sides if you could
point out, "Hey, if you don't like the default, use the
/proc/sys/vm/oom_killer interface"? As I said before there are also
such patch by Chris Swiedler and definitely not a huge, complex one.
And these stupid threads could be forgotten for good and all.

> - with limits set you will have:
>  - /possible/ underutilisation on some workloads.

Depends, guaranteed underutilisation or guaranteed extra unreliability
fit the picture many times as well.

> no matter how good or bad Rik's killer is, i'd much rather set limits
> and just about /never/ have it invoked.

Thanks for expressing your opinion but others [not necessarily me] have
"occasionally" other one depending on the job what the box must do.

	Szaka


