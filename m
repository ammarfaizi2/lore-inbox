Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315469AbSFEVWV>; Wed, 5 Jun 2002 17:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFEVWU>; Wed, 5 Jun 2002 17:22:20 -0400
Received: from waste.org ([209.173.204.2]:51862 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315469AbSFEVWT>;
	Wed, 5 Jun 2002 17:22:19 -0400
Date: Wed, 5 Jun 2002 16:22:16 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17Fgdc-0001dt-00@starship>
Message-ID: <Pine.LNX.4.44.0206051612170.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Daniel Phillips wrote:

> > And that alternative sucks. Think scalability.
> >
> > >   2) Implement a filesystem with realtime response
> >
> > And your shared fs alternative sucks. Think abysmal disk throughput for
> > the rest of the system. Think starvation. Think all the reasons we've been
> > trying to clean up the elevator code times ten. And that's just for the
> > device queue, never mind the deadlock avoidance problems. See "priority
> > inversion".
>
> What kind of argument is that?  It sounds like: because our current block
> interface sucks, all block interfaces suck, and always will.  On the
> contrary, I believe our current interface sucks precisely because it is
> not built according to sound principles of realtime design.

No, the above is a theoretical argument about how optimizing disk access
and locking works that's in no way specific to Linux. Remember, hard RT is
trades throughput for latency guarantees. Worst case for this is devices
queues for disks. Go through the thought experiment of what happens when
an RT task and a !RT task interleave disk access. Worse, what happens when
they're creating files (and all the locking that entails) in the same
directory.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

