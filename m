Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132247AbRCVXvU>; Thu, 22 Mar 2001 18:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbRCVXtB>; Thu, 22 Mar 2001 18:49:01 -0500
Received: from [195.63.194.11] ([195.63.194.11]:1289 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S132252AbRCVXq6>;
	Thu, 22 Mar 2001 18:46:58 -0500
Message-ID: <3C9BCD6E.94A5BAA0@evision-ventures.com>
Date: Sat, 23 Mar 2002 01:33:50 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Clouse <stephenc@theiqgroup.com>
CC: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva> <20010322124727.A5115@win.tue.nl> <20010322142831.A929@owns.warpcore.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clouse wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thu, Mar 22, 2001 at 12:47:27PM +0100, Guest section DW wrote:
> > Last week I installed SuSE 7.1 somewhere.
> > During the install: "VM: killing process rpm",
> > leaving the installer rather confused.
> > (An empty machine, 256MB, 144MB swap, I think 2.2.18.)
> >
> > Last month I had a computer algebra process running for a week.
> > Killed. But this computation was the only task this machine had.
> > Its sole reason of existence.
> > Too bad - zero information out of a week's computation.
> > (I think 2.4.0.)
> >
> > Clearly, Linux cannot be reliable if any process can be killed
> > at any moment. I am not happy at all with my recent experiences.
> 
> Really the whole oom_kill process seems bass-ackwards to me.  I can't in my mind
> logically justify annihilating large-VM processes that have been running for
> days or weeks instead of just returning ENOMEM to a process that just started
> up.
> 
> We run Oracle on a development box here, and it's always the first to get the
> axe (non-root process using 70-80 MB VM).  Whenever someone's testing decides to
> run away with memory, I usually spend the rest of the day getting intimate with
> the backup files, since SIGKILLing random Oracle processes, as you might have
> guessed, has a tendency to rape the entire database.
> 
> It would be nice to give immunity to certain uids, or better yet, just turn the
> damn thing off entirely.  I've already hacked that in...errr, out.

AMEN! TO THIS!
Uptime of a process is a much better mesaure for a killing candidate
then it's size.
