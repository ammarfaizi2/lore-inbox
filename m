Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314371AbSDRPGA>; Thu, 18 Apr 2002 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314373AbSDRPF7>; Thu, 18 Apr 2002 11:05:59 -0400
Received: from borg.org ([208.218.135.231]:9868 "HELO borg.org")
	by vger.kernel.org with SMTP id <S314371AbSDRPF6>;
	Thu, 18 Apr 2002 11:05:58 -0400
Date: Thu, 18 Apr 2002 11:05:58 -0400
From: Kent Borg <kentborg@borg.org>
To: linux-kernel@vger.kernel.org
Subject: Versioning File Systems?
Message-ID: <20020418110558.A16135@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just read an article mentioned on Slashdot,
<http://www.sigmaxi.org/amsci/Issues/Comsci02/Compsci2002-05.html>.

It is a fascinating short summary of the history of hard disks (they
still use the same fundamental design as the very first one) and an
update on current technology (disks are no longer aluminum).  It also
looks at today's 120 gigabyte disk and muses over the question of how
we might ever put an imagined 120 terabyte disk to use.  And the got
me thinking various thoughts, one turns into a question for this list:
It there any work going on to make a versioning file system?

I remember in VMS that I could accumulate "myfile.txt;1",
"myfilw.txt;2", etc., until the local admin got pissed at me for using
up all the disk space with my several megabytes of redundant files.

It is time for Linux to start figuring out ways to use all the disk
space that is on the horizon!  In a few weeks the sweet spot will be
to buy a pair of 80 GB disks.  Disks are outpacing even Red Hat's
"everything" install.

Seriously, I have a server in the basement with a pair of 60 GB RAID 1
disks the protect me against likely hardware failure, but they don't
protect me against: "# rm rf /*".  They don't even let me easily back
out a bad RPM from Red Hat.

I guess I am suggesting the (more constructive) discussions over
desirable Bitkeeper and CVS features consider what it would mean for a
filesystem to absorb some of the key underlying features of each.

As a first crack, I am imagining a file system that records every (or
nearly every) change to every file with time stamps and sequence
numbering.  I don't know what all the primitives would be.  It
obviously seems much of making sense of it all would have to happen in
userland.  Making this too powerful almost brings up some science
fiction problems of time travel through parallel universes, but I
think it could be kept grounded by looking at it as a powerful version
of existing backup systems: they don't have such problems because they
are too cumbersome for them to arise very often.


-kb, the Kent who thinks his journaled filesystem on redundant disks
next needs a better memory.
