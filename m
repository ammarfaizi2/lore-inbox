Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTBLHEQ>; Wed, 12 Feb 2003 02:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTBLHEQ>; Wed, 12 Feb 2003 02:04:16 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:58803 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S266944AbTBLHEP>;
	Wed, 12 Feb 2003 02:04:15 -0500
From: "LA Walsh" <law@tlinx.org>
To: <linux-kernel@vger.kernel.org>, <linux-security-module@wirex.com>
Subject: RE: lsm truly "generic" allowing complete choice?  Clean? Simple?  I don't think so.
Date: Tue, 11 Feb 2003 23:13:55 -0800
Message-ID: <000201c2d266$4daa51a0$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200302120142.34882.russell@coker.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell Coker
> 
> I think that most people who want to use LSM and similar 
> systems don't want to 
> re-write any significant portion of their applications.  
---
	I would agree -- that is true for _most_ people.
> People who want 
> serious security and are prepared to re-write applications 
> will probably want 
> a high-assurance kernel and won't use Linux.
---
	Why rewrite?  My security policy is burned into a ROM as 
well as all my files -- and all files are set to 777, how many 
applications am I going to need to port to fit on an embedded 
system?

	Why shouldn't I be able to config the kernel at compile time
to include the basest of functionality, I put in a terminal program, 
maybe, a copy of a video and audio player, device drivers for a dvd/cdrom,
an ethernet interface and maybe a custom remote/LCD display.  Where
do I need or want UIDs' or want checks for 'execute' access?  If I
call 'exec', its because it's burned into the ROM that way and I don't
care about 'execute' bits.

	Maybe I'd be able to configure out paging support as well...Think
of linux in your toaster with a cute penguin on the side...  You load
your pre-sliced bread into the bread dispenser, and then right after
you finish the morning coffee (started brewing when you turned off
the alarm for the last time, or maybe earlier) and finish the slashdot
morning news, you click the toast icon on your kitchen desktop and the
bread dispenser drops the bread into the toaster.  

	Now how many of those home-appliance IP's will need security
controls?  Hopefully about as many people need security on their 
appliances now -- you have a locked door parameter and an isolated internal
net...if you need security for your appliances -- someone has already
broken into your house.  That's not good.  You don't design every 
appliance, range, fridge and stereo with DAC security controls --
they are assumed safe behind your front door.  

	Now what cheap OS can we put on those appliances?  What's 'free'
these days and is adaptable as a chameleon (I hope).  Certainly no
dinosaur OS's, that's for sure.


> For all the machines I run (hand-held, laptop, embedded 
> server, desktop, and 
> server) I plan to keep Unix permissions whether I need them 
> or not.  Removing 
> them breaks too much compatability at the moment.  Maybe if 
> someone else gets 
> a few thousand Linux machines running without any Unix 
> permissions and fixes 
> a lot of the bugs I'll consider it.
---
	It's not *for* you...a no-security machine wouldn't be
useful as a general purpose machine.  You'd have something akin to
Win98...no...it has readonly/system/hidden...something less than
DOS 1.0 since it even had those.  

	The idea was 'completely generic' to support implementation of
any of the security policies/models -- including those that require
audit.  Audit isn't just for 'audit'...it can be very useful in IDS
and to a small extent, verification.  

	The points needed for audit, possibly with some augmentation might
also allow for performance statistics on the level Win2k/NT has.  I have
to believe that the combined talent of linux programmers has to exceed
that of MS.  Creativity and control are opposite forces -- the more
of one you have, the less of the other.  But MS has some software that
does quite well in benchmarks -- at least giving linux a run-for the money.
I think one of the reasons why is instrumenting and performance figures
that are tied into every kernel.  You know when the disk is your bottle
neck, or your memory, you know how many programs are spilling.  You
don't have to setup a special kernel or write extra software.  It's
all built-in.  Of course in the linux world, it'd be a build-time
config, but if done right, I'd leave it on all the time (I'd expect
< 1% performance impact in typical cases).

-l

