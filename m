Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSAUUTk>; Mon, 21 Jan 2002 15:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSAUUTb>; Mon, 21 Jan 2002 15:19:31 -0500
Received: from fw.aub.dk ([195.24.1.194]:29826 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S288086AbSAUUTV>;
	Mon, 21 Jan 2002 15:19:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 21 Jan 2002 21:16:11 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201211418050.17139-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0201211418050.17139-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SkrT-00039j-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 January 2002 20:26, Mark Hahn wrote:
> > > > To me the benefit is clear enough: ASAP scheduling of IO threads, a
> > > > simple heuristic that improves both throughput and latency.
> > >
> > > I think of "benefit", perhaps naiively, in terms of something that can
> > > be measured or demonstrated rather than just announced.
> >
> > But you see why asap scheduling improves latency/throughput *in theory*,
> > don't you?
>
> NO, IT DOES NOT. why can't you preempt-ophiles get that through your heads?
>
> 	eager scheduling is NOT optimal in general.
>
> for instance, suppose my disk can only read a sector at a time.
> scheduling my sequentially-reading process to wake eagerly
> is most definitly PESSIMAL.  laziness is a cardinal virtue!
> this doesn't preclude heuristics to sometimes short-cut the laziness.
>
It's because your system is behaving wrongly for your dream to come true. If 
your want to handle several expected inputs from IO, you should ask it for an 
interrupt for every package. Rather you should rely on a timer function an 
periodically handle new data and in case of nothing new, go back to 
interrupts..

Eager scheduling is OPTIMAL for the sematics in your system. It thats is not 
optimal for throughput/whatever, it's the code that is wrong!

-Allan

