Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSGRTOE>; Thu, 18 Jul 2002 15:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSGRTOE>; Thu, 18 Jul 2002 15:14:04 -0400
Received: from chaos.analogic.com ([204.178.40.224]:44418 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318317AbSGRTOD>; Thu, 18 Jul 2002 15:14:03 -0400
Date: Thu, 18 Jul 2002 15:19:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027018996.1116.136.camel@sinai>
Message-ID: <Pine.LNX.3.95.1020718150735.1373A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Robert Love wrote:

> On Thu, 2002-07-18 at 11:56, Richard B. Johnson wrote:
> 
> > What should have happened is each of the tasks need only about
> > 4k until they actually access something. Since they can't possibly
> > access everything at once, we need to fault in pages as needed,
> > not all at once. This is what 'overcomit' is, and it is necessary.
> 
> Then do not enable strict overcommit, Dick.
> 
> > If you have 'fixed' something so that no RAM ever has to be paged
> > you have a badly broken system.
> 
> That is not the intention of Alan or I's work at all.
> 
> 	Robert Love

Okay then. When would it be useful? I read that it would be useful
in embedded systems, but everything that will ever run on embedded
systems is known at compile time, or is uploaded by something written
by an intelligent developer, so I don't think it's useful there. I
'do' embedded systems and have never encountered OOM.

I also read about some 'home users' not knowing how to set up
there systems. I don't think one CPU cycle should be wasted to
protect them, well maybe 10, but that's it.

I keep seeing the same thing about protecting root against fork and
malloc bombs and I get rather "malloc()" about it. All distributions
I have seen, so far, come with `gcc` and `make`. The kiddies can
crap all over their kernels at their heart's content. I don't think
Linux should be reduced to the lowest common denominator.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


