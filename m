Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTBTRU7>; Thu, 20 Feb 2003 12:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTBTRUE>; Thu, 20 Feb 2003 12:20:04 -0500
Received: from havoc.daloft.com ([64.213.145.173]:5782 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265402AbTBTRS5>;
	Thu, 20 Feb 2003 12:18:57 -0500
Date: Thu, 20 Feb 2003 12:28:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alex Larsson <alexl@redhat.com>, procps-list@redhat.com,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
Message-ID: <20030220172857.GH9800@gtf.org>
References: <Pine.LNX.4.44.0302200902260.2493-100000@home.transmeta.com> <Pine.LNX.4.44.0302201810160.32017-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302201810160.32017-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 06:14:38PM +0100, Ingo Molnar wrote:
> On Thu, 20 Feb 2003, Linus Torvalds wrote:
> > It would just be _so_ much nicer if the threads would show up as
> > subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable,
> > and just generally more sane.
> 
> Al says that this cannot be done sanely, and is fraught with security
> problems. I'd vote for it if it were possible. Al?

Having the kernel automatically manage creation/destruction of
directories is the sticking point, AFAIK.

Why not use the "squid method"?  Create directories 00..FF, and sort the
pids/tids into buckets that way.  Then you are not creating and
destroying directories all the time.

	Jeff



