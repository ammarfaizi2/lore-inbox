Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSGQUaT>; Wed, 17 Jul 2002 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSGQUaT>; Wed, 17 Jul 2002 16:30:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56246 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316674AbSGQUaR>;
	Wed, 17 Jul 2002 16:30:17 -0400
Date: Thu, 18 Jul 2002 22:32:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Sam Mason <mason@f2s.com>
Cc: shreenivasa H V <shreenihv@usa.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Gang Scheduling in linux
In-Reply-To: <20020717203929.GA9633@sam.home.net>
Message-ID: <Pine.LNX.4.44.0207182229460.7854-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jul 2002, Sam Mason wrote:

> The important thing to remember is that this isn't a normal scheduling
> method, it's used for VERY specialised software which is assumed to have
> (almost) complete control of the machine. [...]

so how does this differ from a normal Linux system that is used
exclusively? The specialized tasks will get evenly distributed between
CPUs (as long as the number of tasks is not higher than the number of
CPUs), and nothing should interrupt them.

> [...] Gang scheduled processes would have the highest priority possible
> and would get executed before any other processes.  This works because
> the software knows what it's doing and assumes that the user only ran
> one bit of gang scheduled software, if all of these are valid
> assumptions everything should work nicely.
> 
> Thinking about it, if a process just sets itself to be the highest
> priority and constrains it's self to appropriate processors then it
> wouldn't surprise me if this was just what you want to do gang
> scheduled.

yeah. You can schedule processes 'manually' by using affinities - this is
for corner-cases which know it 100% well what they are doing. But the
default scheduler should get the '8 tasks running on an 8-way system' case
right as well - each CPU will run a single number-cruncher, and there wont
be any bouncing.

	Ingo

