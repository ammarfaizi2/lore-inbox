Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSGQVIj>; Wed, 17 Jul 2002 17:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSGQVIj>; Wed, 17 Jul 2002 17:08:39 -0400
Received: from [195.137.34.203] ([195.137.34.203]:51632 "HELO sam.home.net")
	by vger.kernel.org with SMTP id <S316728AbSGQVIi>;
	Wed, 17 Jul 2002 17:08:38 -0400
Date: Wed, 17 Jul 2002 22:24:07 +0100
From: Sam Mason <mason@f2s.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: shreenivasa H V <shreenihv@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
Message-ID: <20020717212407.GB9633@sam.home.net>
References: <20020717203929.GA9633@sam.home.net> <Pine.LNX.4.44.0207182229460.7854-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207182229460.7854-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 10:32:04PM +0200, Ingo Molnar wrote:
>On Wed, 17 Jul 2002, Sam Mason wrote:
>> The important thing to remember is that this isn't a normal scheduling
>> method, it's used for VERY specialised software which is assumed to have
>> (almost) complete control of the machine. [...]
>so how does this differ from a normal Linux system that is used
>exclusively? The specialized tasks will get evenly distributed between
>CPUs (as long as the number of tasks is not higher than the number of
>CPUs), and nothing should interrupt them.

At the moment I can't think of anything, but I'm sure that someone
with a bit of real life experience will show up and prove me wrong.

>> [...] Gang scheduled processes would have the highest priority possible
>> and would get executed before any other processes.  This works because
>> the software knows what it's doing and assumes that the user only ran
>> one bit of gang scheduled software, if all of these are valid
>> assumptions everything should work nicely.
>>
>> Thinking about it, if a process just sets itself to be the highest
>> priority and constrains it's self to appropriate processors then it
>> wouldn't surprise me if this was just what you want to do gang
>> scheduled.
>
>yeah. You can schedule processes 'manually' by using affinities - this is
>for corner-cases which know it 100% well what they are doing. But the
>default scheduler should get the '8 tasks running on an 8-way system' case
>right as well - each CPU will run a single number-cruncher, and there wont
>be any bouncing.

I think that would work, I would also assume that the program has
enough knowledge to start only the required number of tasks and
therefore let the scheduler figure out where to put them.
