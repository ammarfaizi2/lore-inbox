Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRKFGrC>; Tue, 6 Nov 2001 01:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278098AbRKFGqv>; Tue, 6 Nov 2001 01:46:51 -0500
Received: from unthought.net ([212.97.129.24]:21721 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S278081AbRKFGqt>;
	Tue, 6 Nov 2001 01:46:49 -0500
Date: Tue, 6 Nov 2001 07:46:47 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: SpaceWalker <spacewalker@altern.org>
Cc: Stuart Young <sgy@amc.com.au>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106074647.A1588@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	SpaceWalker <spacewalker@altern.org>, Stuart Young <sgy@amc.com.au>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20011105144855.01f83310@mail.amc.localnet> <5.1.0.14.0.20011105154947.01f6fec0@mail.amc.localnet> <3BE6BF22.E06E8D19@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3BE6BF22.E06E8D19@altern.org>; from spacewalker@altern.org on Mon, Nov 05, 2001 at 05:32:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 05:32:34PM +0100, SpaceWalker wrote:
> Stuart Young wrote:
> > 
> > At 11:05 PM 4/11/01 -0500, Alexander Viro wrote:
> > 
> > >On Mon, 5 Nov 2001, Stuart Young wrote:
> > >
> > > > Any reason we can't move all the process info into something like
> > > > /proc/pid/* instead of in the root /proc tree?
> > >
> > >Thanks, but no thanks.  If we are starting to move stuff around, we
> > >would be much better off leaving in /proc only what it was supposed
> > >to contain - per-process information.
> > 
> 
> We could add a file into /proc like /proc/processes that contains once
> all process informations that some programs like top or ps can read only
> Once.
> It could save a lot of time in kernel mode scanning the process list for
> each process.
> later, a new version of ps or top could simply stat /proc/processes and
> if it exists uses it to give informations to the user.
> What do you think of this idea ?

We would have the same "changing format of /proc/processes" parsing
problems as we have now with the rest of /proc.

Why not implement all of top in the kernel, so that you could do a
 cat /dev/top   and have the usual top output nicely shown ?   ;)

(yes, the last one was a joke!)

Your suggestion may improve the performance of one or two userland
applications, but it does not attack the real problem: that /proc is not
machine readable.   

We would be maintaining yet another /proc file, but we'd still have the
problems we have now.   Implementing an A.I. in every CPU meter applet out
there, while still having to accept that the A.I. gives up on us every now and
then (when someone decides to add an ASCII art visualization of the utilization
of the various ALUs in /proc/cpuinfo for example - the worst part being that
this example is probably not even far fetched!)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
