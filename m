Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280617AbRKFWJ6>; Tue, 6 Nov 2001 17:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280619AbRKFWJs>; Tue, 6 Nov 2001 17:09:48 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:24215 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S280617AbRKFWJd>; Tue, 6 Nov 2001 17:09:33 -0500
Date: Tue, 6 Nov 2001 17:09:28 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: <erik@hensema.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <slrn9uglko.esu.spamtrap@dexter.hensema.xs4all.nl>
Message-ID: <Pine.GSO.4.33.0111061648040.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2001, Erik Hensema wrote:
>ASCII is readable by all languages with little programmer effort. In C, you
>can use a simple scanf, Perl and shells like plain ascii best.

Right.  Use scanf and you'll be spending the rest of your life chasing
buffer overflows.  Dealing with text efficiently is not "simple."  If it
were, CS students wouldn't take so long to learn how to process text inputs.

And perl handles binary as well as text.  It can deal with binary faster
than it can text, but most people are too lazy to use binary formats with
perl. (I've seen a few, but they were all custom web applications.)

>When /proc is turned into some binary interface we'd need to create little
>programs which read the binary values from the files and output them on
>their stdout, which is quite cumbersome, IMHO.

So, do you run 'free' or 'cat /proc/meminfo'?  'uptime' or 'cat /proc/uptime'?
'netstat', 'route', 'arp', etc. or root through /proc/net/*?  I bet you use
'ps' instead of monkeying around in all the [0-9]* entries in /proc.  The
fact is, we already have "little programs" converting, shuffling, reformating,
and printing out those values.

However, yes, there are useful "human" elements in /proc.  And they really
are there for the sole benefit of a human (eg. /proc/scsi/scsi, /proc/modules,
/proc/slabinfo, etc.)  The bigger picture is that they don't particularly
belong in "/proc" -- the thing originally created to access the process table
without rooting through /dev/kmem. (Raise your hand if you were around for
this.)

>Yes, maintain compatibility for 2.6 and try to dump it for 2.8.

Heh.  It took how many years to get "2.4" stamped on a version?  I'm guessing
2.5 will not exist for several months and the actual "stable" 2.6 will not
be available until 2005.

>Heck, 95% compatibility could even be achieved using a 100% userspace app
>which serves the data over named pipes.

Screw backwards compatibilty.  Sometimes you have to cut your loses and
move on.  We don't want to end up like Microsoft and the whole brain-fuck
that is their dll world. (Yes, they knew it was stupid.  And yes, they
would love to abandon it, but it's far, far too late.)  We switched to ELF,
abandoned libc4, etc.  Add another to the pile.

--Ricky


