Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290792AbSAaBQ6>; Wed, 30 Jan 2002 20:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290795AbSAaBQt>; Wed, 30 Jan 2002 20:16:49 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:13829 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S290792AbSAaBQf>;
	Wed, 30 Jan 2002 20:16:35 -0500
Message-Id: <5.1.0.14.0.20020131115023.02652d60@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 31 Jan 2002 12:16:29 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: A modest proposal -- We need a patch penguin
Cc: Daniel Egger <degger@fhm.edu>, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1012396396.32247.2.camel@sonja>
In-Reply-To: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
 <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:13 PM 30/01/02 +0100, Daniel Egger wrote:
>Am Mit, 2002-01-30 um 00.50 schrieb Linus Torvalds:
>
> > Or look at USB: I get the USB patches from Greg, and he gets them from
> > various different people. Johannes Erdfelt is the maintainer for uhci.c,
> > and he sends them to Greg, not to me.
>
>What about creating a small document that states who's the correct
>recipient for a subsystem? This would prevent dotzends of questions
>like "Where do I send my patches?" and turn them into a RTFF.

A reworking of MAINTAINERS could be beneficial and help achieve this.

Linus mentioned that he prefers to look at the code to see who to talk to. 
Others have mentioned this may be nice, but makes it hard to get some sort 
of overall view, plus since programmers can be inconsistent in stuff like 
this, it may not always happen. How about we turn the problem upside down, 
and figure out how to get the code easily referenced in MAINTAINERS?

What I'm thinking is that we could add (multiple?) lines into MAINTAINERS 
that specify the actual FILES in the kernel (in reference to linux/) that 
someone works on or maintains. We don't have to list every file (wildcards, 
regex's, etc, can work too), plus you can list the maintainers of various 
areas of the code (such as generic maintainers of all the files under a 
part of the kernel file tree) by just listing what directories they 
control. Something so that it's dead simple to extract who maintains this file.

Here's a possible example:

Say I'm looking at the SiS/Trident Audio Driver, and I have a patch I want 
to send to a maintainer. The file I'm working on is:

linux/drivers/sound/trident.*

If I could easily search MAINTAINERS for who maintains this file, I'm made. 
If I can't find that, I start trimming the search (to say 
linux/drivers/sound/, which would be the sound maintainer).

If we say add an F: field to maintainers (at the end of the maintainers 
record), you can easily do things like...

grep -B 10 "F: linux/drivers/sound/trident" /usr/src/linux/MAINTAINERS

...and get some sort of results (-B is "before context, which displays 
lines before the found line, and is quite useful in this sort of situation) 
that help. This is just a quick and dirty example, and I'm sure someone 
could easily write a small script that could parse the output better, do 
things like automatically cut the search back till it finds a match, etc.

This could also be used to figure out a tree of who does what, which is 
probably not a bad idea.

Just an idea of course. *grin*


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

