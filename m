Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271555AbRHZUti>; Sun, 26 Aug 2001 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271573AbRHZUt3>; Sun, 26 Aug 2001 16:49:29 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:22291 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S271555AbRHZUtQ>;
	Sun, 26 Aug 2001 16:49:16 -0400
Date: Sun, 26 Aug 2001 14:45:15 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826144515.A21306@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108261715010.5646-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll have to wait to display more ignorance (on this subject)
until next week. Off to
LinuxWorld SF - rushing in where Alan Cox is afraid to go!

And OT: the Embedded Linux Consortium is considering standards
for Embedded Linux, as is the Emblix Consortium (Japan), the Open Group,
and, for all I know, the UN, the NRA, and the Committee for the 
Preservation Welsh Poetry. I'd be
interested in any suggestions, comments, proposals, or witty remarks
I could convey to  the first three of  these august organizations.


On Sun, Aug 26, 2001 at 05:34:24PM -0300, Rik van Riel wrote:
> On Sun, 26 Aug 2001, Victor Yodaiken wrote:
> > On Sun, Aug 26, 2001 at 04:38:55PM -0300, Rik van Riel wrote:
> > > On Sun, 26 Aug 2001, Victor Yodaiken wrote:
> > >
> > Daniel was suggesting a readahead thread, if I'm not mistaken.
> 
> Ouch, that's about as insane as it gets ;)
> 
> 
> > > > BTW: maybe I'm oversimplifying, but since read-ahead is an optimization
> > > > trading memory space for time, why doesn't it just turn off when there's
> > > > a shortage of free memory?
> > > > 		num_pages = (num_requestd_pages +  (there_is_a_boatload_of_free_space? readahead: 0)
> > >
> > > When the VM load is high, the last thing you want to do is
> > > shrink the size of your IO operations, this would only lead
> > > to more disk seeks and possibly thrashing.
> >
> > Doesn't this very much depend on why VM load is high and on the
> > kind of I/O load? For example, if your I/O load is already in
> > big chunks or if VM stress is being caused by a bunch of big
> > threads hammering shared data that is in page cache already.
> 
> Processes accessing stuff already in RAM aren't causing
> any VM stress, since all the stuff they need is already
> in RAM.
> 
> As for I/O already being done in big chunks, I'm not sure
> if readahead would have any influence on this situation.
> 
> > At least to me, "thrashing" where the OS is shuffling pages in and
> > out without work getting done is different from "thrashing" where
> > user processes run with suboptimal I/O.
> 
> Actually, "suboptimal I/O" and "shuffling pages without getting
> work done" are pretty similar.
> 
> > > It would be nice to do something similar to TCP window
> > > collapse for readahead, though...
> 
> > That is, failure to use readahead may be caused by memory pressure,
> > scheduling delays, etc - how do you tell the difference between a
> > process that would profit from readahead if the scheduler would let it
> > and one that would not?
> 
> I don't think we'd need to know the difference at all times.
> After all, TCP manages fine without knowing the reason for
> packet loss ;)
> 
> 
> > > IA64: a worthy successor to i860.
> >
> > Not the 432?
> 
> ;)
> 
> Rik
> -- 
> IA64: a worthy successor to i860.
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
