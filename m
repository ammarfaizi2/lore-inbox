Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSHUSlS>; Wed, 21 Aug 2002 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSHUSlS>; Wed, 21 Aug 2002 14:41:18 -0400
Received: from gremlin.ics.uci.edu ([128.195.1.70]:16778 "HELO
	gremlin.ics.uci.edu") by vger.kernel.org with SMTP
	id <S318641AbSHUSlL>; Wed, 21 Aug 2002 14:41:11 -0400
Date: Wed, 21 Aug 2002 11:45:06 -0700 (PDT)
From: Mukesh Rajan <mrajan@ics.uci.edu>
To: Richard Zidlicky <rz@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: detecting hard disk idleness
In-Reply-To: <20020821153917.B1444@linux-m68k.org>
Message-ID: <Pine.SOL.4.20.0208211141210.21898-100000@hobbit.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this again would mean that i would have to poll the /proc/interrupt file.
i want to avoid polling because of very small poll interval causing
overhead. i am still wondering if this could be implemented with some sort
of interrupt mechanism in linux (kernel interrupting user program or user
program waiting on some signal)

- mukesh


On Wed, 21 Aug 2002, Richard Zidlicky wrote:

> On Tue, Aug 20, 2002 at 11:25:11PM -0700, Mukesh Rajan wrote:
> > hi,
> > 
> > i'm trying to implement an alogrithm that requires as input the idleness
> > period of a hard disk (i.e. time between satisfying a request and arrival
> > of new request).
> > 
> > so far implementation polls "proc/stat" periodically to detect idleness
> > over the poll period. this implementation is not accurate and also i have
> > very small poll interval (milli secs). with some measurements, conclusion
> > is that implementation is consuming quite some power. this millisecond
> > polling overhead could be avoided if i can come up with an interrupt
> > driven implementation. in DOS, i would have manipulated the interrupt
> > table and inserted my code for 13h (disk interrupt right?). this would
> > help me do some preprocessing before the actual call to the hard disk
> > (13h).
> > 
> > is this possible in any way in Linux? i.e. have the kernel inform a
> > program when a hard disk interrupt occurs? either through interrupt
> > manipulation or otherwise?
> 
> cat /proc/interrupts
> 
> Richard
> 

