Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280832AbRKGQJA>; Wed, 7 Nov 2001 11:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRKGQIu>; Wed, 7 Nov 2001 11:08:50 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:54147 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280832AbRKGQIl>; Wed, 7 Nov 2001 11:08:41 -0500
Date: Wed, 7 Nov 2001 17:08:36 +0100
From: Erik Hensema <erik@hensema.net>
To: Ricky Beam <jfbeam@bluetopia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011107170836.A4782@hensema.net>
Reply-To: erik@hensema.xs4all.nl
In-Reply-To: <slrn9uglko.esu.spamtrap@dexter.hensema.xs4all.nl> <Pine.GSO.4.33.0111061648040.17287-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.33.0111061648040.17287-100000@sweetums.bluetronic.net>; from jfbeam@bluetopia.net on Tue, Nov 06, 2001 at 05:09:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 05:09:28PM -0500, Ricky Beam wrote:
> On 6 Nov 2001, Erik Hensema wrote:
> >When /proc is turned into some binary interface we'd need to create little
> >programs which read the binary values from the files and output them on
> >their stdout, which is quite cumbersome, IMHO.
> 
> So, do you run 'free' or 'cat /proc/meminfo'?  'uptime' or 'cat /proc/uptime'?
> 'netstat', 'route', 'arp', etc. or root through /proc/net/*?  I bet you use
> 'ps' instead of monkeying around in all the [0-9]* entries in /proc.  The
> fact is, we already have "little programs" converting, shuffling, reformating,
> and printing out those values.

Yes, but I meant a program which reads a single binary value and outputs it
as ascii, as a generic layer between the binary /proc and the ascii world
of shell scripts.

I don't like a binary /proc.

> However, yes, there are useful "human" elements in /proc.  And they really
> are there for the sole benefit of a human (eg. /proc/scsi/scsi, /proc/modules,
> /proc/slabinfo, etc.)  The bigger picture is that they don't particularly
> belong in "/proc" -- the thing originally created to access the process table
> without rooting through /dev/kmem. (Raise your hand if you were around for
> this.)

I've been around for six years (that is, six years on Linux, not quite as
long on lkml), which isn't quite long enough, I think.

But I agree: /proc is populated with files that don't really belong there.
Maybe everything should be moved to /kernel? (except for the process info,
offcourse).

[...]

> >Heck, 95% compatibility could even be achieved using a 100% userspace app
> >which serves the data over named pipes.
> 
> Screw backwards compatibilty.  Sometimes you have to cut your loses and
> move on.  We don't want to end up like Microsoft and the whole brain-fuck
> that is their dll world. (Yes, they knew it was stupid.  And yes, they
> would love to abandon it, but it's far, far too late.)  We switched to ELF,
> abandoned libc4, etc.  Add another to the pile.

It will be very, very hard for distributors to create a distribution which
runs one the native 2.6 /proc interface as soon as 2.6 comes out. I think
we must assume rewriting things like procps, init scripts, etc. will only
start as soon as 2.6 comes out. We should provide some transitional period
for userspace to adapt, but make clear to everybody that compatibility
isn't going to last forever.

-- 
Erik Hensema (erik@hensema.net)
