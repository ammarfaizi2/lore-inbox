Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283694AbRLECCc>; Tue, 4 Dec 2001 21:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283691AbRLECCW>; Tue, 4 Dec 2001 21:02:22 -0500
Received: from trillium-hollow.org ([209.180.166.89]:59408 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S283694AbRLECCG>; Tue, 4 Dec 2001 21:02:06 -0500
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro] 
In-Reply-To: Your message of "Tue, 04 Dec 2001 16:36:46 PST."
             <20011204163646.M7439@work.bitmover.com> 
Date: Tue, 04 Dec 2001 18:02:01 -0800
From: erich@uruk.org
Message-Id: <E16BRNp-0003Ts-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry McVoy <lm@bitmover.com> wrote:

> > > There seems to be a little misunderstanding here; from what
> > > I gathered when talking to Larry, the idea behind ccClusters
> > > is that they provide a single system image in a NUMA box, but
> > > with separated operating system kernels.
> 
> Right except NUMA is orthogonal, ccClusters work fine on a regular SMP 
> box.

...[details omitted for the moment]...

The basic idea seems a sound one, though maybe consider going from
a simple/robust cluster solution back to NUMA boxen.  A transparent
virtual computer image is kind of the goal long-term, right?

That is the plan I have for a different OS/kernel I'm working on,
and it seems valid so far.


Uni-proc design plus simple SMP only in the core kernel code fixes
SO many little SMP brain-deadnesses.

For example, there should be no reason that most drivers or any other
random kernel module should know anything about SMP.  Under Linux, it
annoys me to no end that I have to ever know (and yes, I count compiling
against "SMP" configuration having to know)...  more and more sources of
error.


Then, as long as you make the simple cluster solution handle "hot-swap/
bring-up/tear-down" of nodes from the beginning, you can easily do
things like bring new processor modules, machines, etc. online or out
of your system.


This even argues that you should try working from something like a
Mosix cluster as a starting point, to test it out.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
