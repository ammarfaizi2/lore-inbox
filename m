Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTLWXXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTLWXXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:23:35 -0500
Received: from stat0143.cruzio.com ([63.249.101.143]:57095 "EHLO O.Q.NET")
	by vger.kernel.org with ESMTP id S263228AbTLWXXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:23:31 -0500
RECEIVED: FROM ulmo BY O.Q.NET WITH local (Exim 4.22 #1 (Debian))
	ID 1AYvs0-0000Xp-3G; Tue, 23 Dec 2003 15:23:20 -0800
To: dickson@permanentmail.com, greg@kroah.com, ULMO@q.net
Subject: Re: DevFS vs. udev
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031223073052.5fc48b20.dickson@permanentmail.com>
Message-Id: <E1AYvs0-0000Xp-3G@O.Q.NET>
From: "Bradley W. Allen" <ULMO@Q.NET>
Date: Tue, 23 Dec 2003 15:23:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the cogent reply.  I think all your substantiated
points are valid.  I'll have to see what I can do about the rest,
as you said.

I'm glad others responded to what seems like an inaccurate post of
mine.  At least I, if not others, can persue it as was suggested
by you and Greg KH <greg@kroah.com> for now.

I am not volunteering at this time to work on DevFS.

The main problem is documentation, as you pointed out.  I went to
"make menuconfig" in the new stable kernel, and ran into this problem
head-on:  help for that option says that it is either depracated
or obsolete, and after using it without big problems for a long
time, I wanted to know why.  Everything I saw after that smelled
bad, and I'm saying so, but that may not mean that it is.  It was
so bad I didn't even read the "paper" about why on one of the
referenced web sites.  Also, my old 3 year archive via USENET
of linux-kernel no longer exists within my grasp (not any fault of
mine), so I'm forced to use web archive access, and it's hard to
navigate in those.

To respond to Greg KH, my uses are not for a highly production
oriented mission critical corporate system or anything, but they
are timing critical.  If it takes more CPU, RAM, and time to open
/dev/null and all the other hundreds of devices in /dev that get
opened every time some programs start, that is not only bloat, but
more trouble.  Moving kernel functions into user space has always
been a pet peeve of mine:  why do it, when it just means shuffling
back and forth between system calls and user processes ... if that's
what is actually happening ... unless that's not what's happening
...  I'll have to research this myself at some other time.

okay.  So I don't know what I'm talking about within /dev internals
in the kernel.  It's just not well documented.  I can read the
documents, then know what I'm talking about there, but all I'm
trying to do is install 2.6.  Ok, so I could have taken the word
of the help system.  Meanwhile, I've had to spend at least half
a day re-configuring a non-DevFS /dev for the first time in half
a decade in preparation for this big depracation, and I am upset
about it.

Sure, I could continue to use DevFS, but if as you said, it's not
going to be around long, then I could be in trouble for depending
on it.

I'm going to use disk /dev for now, until I have time to understand
this better, which will probably be around halfway through next year.

Already, I'm living the old pain I thought was left way behind of
archiving and moving around /dev subdirectories, and having to
consider the differences between systems, kernels, distributions,
and versions of backup, something I thought I didn't have to worry
about.  If udev gets OK or DevFS doesn't break, I may go back to
that someday.

For now, if whatever I do doesn't slow the system down more
than about .1 seconds per access of *all* the /dev/ devices
necessary for a complete program transition (in a swapping
Pentium III), then I should be OK.  Perhaps that was
unconsciously nagging me:  userspace =? swap; swap every time
/dev gets accessed?  If indeed this is just an undocumented
transition, then my confidence is higher that you've made
sure this isn't a problem, and I just didn't read about it.
In one of my uses, /dev doesn't get accessed very often,
perhaps once every half hour (giving it plenty of chance to swap
if it has that ability, which I don't want it to), but when it
does, it expects sub-second turnaround on the entire lot.
If udev doesn't actually get used during device opens and closes,
then that will fix that problem.  Too many unanswered questions.

Sorry for the "emotional" fuss.  (Perhaps my personal environment
needs less of that pressure, too :? )
