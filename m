Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTBTRWS>; Thu, 20 Feb 2003 12:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTBTRWR>; Thu, 20 Feb 2003 12:22:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55204 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266233AbTBTRVH>;
	Thu, 20 Feb 2003 12:21:07 -0500
Date: Thu, 20 Feb 2003 18:30:34 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Alex Larsson <alexl@redhat.com>, <procps-list@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <20030220172857.GH9800@gtf.org>
Message-ID: <Pine.LNX.4.44.0302201829480.402-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Jeff Garzik wrote:

> > > It would just be _so_ much nicer if the threads would show up as
> > > subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable,
> > > and just generally more sane.
> > 
> > Al says that this cannot be done sanely, and is fraught with security
> > problems. I'd vote for it if it were possible. Al?
> 
> Having the kernel automatically manage creation/destruction of
> directories is the sticking point, AFAIK.

it already has to create/destroy the main PID directory, so i cannot see a 
big difference.

> Why not use the "squid method"?  Create directories 00..FF, and sort the
> pids/tids into buckets that way.  Then you are not creating and
> destroying directories all the time.

yuck ...

	Ingo

