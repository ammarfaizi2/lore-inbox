Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbTD3SE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTD3SE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:04:56 -0400
Received: from watch.techsource.com ([209.208.48.130]:16367 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262286AbTD3SEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:04:51 -0400
Message-ID: <3EB013A1.9030301@techsource.com>
Date: Wed, 30 Apr 2003 14:19:13 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: "Downing, Thomas" <Thomas.Downing@ipc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
References: <170EBA504C3AD511A3FE00508BB89A9202032941@exnanycmbx4.ipc.com> <20030430152041.GA22038@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Larry McVoy wrote:
> 
> 
> My point wasn't about theft, it was about reimplementation.
> I stand behind that point, what I've seen for more than a decade is
> reimplementation after reimplementation.  I'm not saying there is no
> value to that or that it is illegal or that there are no improvements
> (compare Unix diff to GNU diff if you want to see some imrovements).
> There is tons of value in having free versions of useful tools.
> There is also tons of value in the creation of new work.
> 


Here's my example:

Years ago, I realized that when you used malloc(), your process size 
would increase (of course), but when you used free(), your process size 
would not shrink.  This is still the case under Solaris.  I understand 
why it is the case, but I always wondered why someone didn't do 
something to improve it.  I mean, what a lazy, broken way of doing things.

Recently, I came to realize that glibc's implementation is really smart 
about it and releases free'd memory back to the system.  Wow!  What 
commercial vendor would EVER do something that intelligent?  Under 
Solaris, we had to do weird stuff involving mmap to get memory that we 
could release back to the system.  It was a pain.  glibc does it 
automatically!

Now, I have come to realize this because this 'intelligence' in glibc is 
being a major thorn in my side.  I wrote a program which relied on the 
lazy behavior, and the performance is being killed by the overhead of 
releasing the memory back to the system.  But being a thorn in my side 
doesn't make that improvement any less cool or genuinely unique to the 
open source community.

A lot of times, what you'll see from commercial vendors is a set of 
tools that work well.  But only just well enough.  They don't go out of 
their way to improve things.  They give you the same version of diff and 
the same basic functionality from libc for years and years on end.  The 
open source community says, "You know what?  This is lame.  I'm going to 
fix it and make it more useful for everyone."

More and more, people where I work are switching over to using 
GNU/Linux/x86 workstations rather than any of the alternatives, 
primarily because the development environment and the basic tools are 
just SO MUCH BETTER.  (Sure, Sun's Workshop comes with some great 
graphical tools, but who uses them?  And it's expensive anyhow.)

I mean, when will Sun, IBM, or Compaq ever start shipping tcsh or bash 
as the default shell?  Don't they realize that people make typos and 
would like to reedit the line they just typed?  Why are they still in 
the dark ages?

