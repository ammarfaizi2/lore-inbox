Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSKCGk1>; Sun, 3 Nov 2002 01:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSKCGk0>; Sun, 3 Nov 2002 01:40:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32190 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261663AbSKCGk0>;
	Sun, 3 Nov 2002 01:40:26 -0500
Date: Sun, 3 Nov 2002 01:46:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211022144070.2934-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211030138420.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> On the other hand, I have this suspicion that the most secure setup is one 
> that the sysadmin is _used_ to, and knows all the pitfalls of. Which 
> obviously is a big argument for just maintaining the status quo with suid 
> binaries.
> 
> We have decades of knowledge on how to minimize the negative impact of
> suid (I've used sendmail as an example of a suid program, and yet last I
> looked sendmail was actually pretty careful about dropping all unnecessary
> privileges very early on).

Quite so.  Now, ability to _remove_ capabilities on exec() is a Good Thing(tm)
regardless of suid.  It can be combined with suid - that gives you something
that is still evil, but less than it used to be.  But I don't see any point
in new independent mechanism for raising caps - e.g. since it assumes a
bunch of new programs that were written to run with elevated caps and
with assumption that they will be less dangerous than suid-root ones.
Somehow, it doesn't make me happy about running such programs - not for
first 5 years or so.

