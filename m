Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288645AbSATOfi>; Sun, 20 Jan 2002 09:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288662AbSATOf2>; Sun, 20 Jan 2002 09:35:28 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:55825 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288645AbSATOfQ>;
	Sun, 20 Jan 2002 09:35:16 -0500
Date: Sun, 20 Jan 2002 07:34:32 -0700
From: yodaiken@fsmlabs.com
To: george anzinger <george@mvista.com>
Cc: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver.Neukum@lrz.uni-muenchen.de,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020120073432.A30665@hq.fsmlabs.com>
In-Reply-To: <E16QB8b-0002K8-00@the-village.bc.nu> <87sn98ftpi.fsf@fadata.bg> <20020114154640.A26460@hq.fsmlabs.com> <876664vxm8.fsf@fadata.bg> <20020115053135.B32605@hq.fsmlabs.com> <3C4A9C97.15AE9D32@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C4A9C97.15AE9D32@mvista.com>; from george@mvista.com on Sun, Jan 20, 2002 at 02:31:51AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 02:31:51AM -0800, george anzinger wrote:
> yodaiken@fsmlabs.com wrote:
> > What I think we need is a kind of interval real-time scheduling.
> > Something like:
> >         The system has a basic timing period of N milliseconds where
> >         N is at lease 500 and probably more.
> > 
> >         Over a N millisecond period each process gets a full scheduling quantum
> >         and, if it requests, a full I/O quantum.
> >         For a niced process there is some calculated interval greater than
> >         N. An I/O quantum should correspond somehow to a rate of I/0.
> > 
> >         RTLIMIT is used to set the max number of processes allowed to start
> >         and this determines the computation length of "one quantum"
> 
> Have you looked at SCHED_SPORADIC (see 1003.1d-1999)?

Yes, but I don't think it does much - although its description is quite
long and complex.
