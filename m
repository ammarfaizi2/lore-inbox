Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUAJAzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUAJAzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:55:35 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:46979
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264874AbUAJAyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:54:01 -0500
Date: Fri, 9 Jan 2004 20:06:40 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup with 2.6.0
Message-ID: <20040109200640.B8282@animx.eu.org>
References: <20040109104955.B6840@animx.eu.org> <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.44.0401091653340.19686-100000@poirot.grange>; from Guennadi Liakhovetski on Fri, Jan 09, 2004 at 05:02:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am constantly accessing NFS with this machine.  Read and write.  It was
> 
> How much data at one go (max)?

I just dumped the backup I made from jaz to the nfs.  I found out that some
things didn't get backed up.  I did multiple backups and one file was larger
than the last (for the same filesystem).

Once I copyied to nfs (which did *NOT* crash it), I ran md5sum on both nfs
copy and jaz copy.  both were exact same.  then I copyied from nfs to nfs.

The size was about 350mb.  (Quite surprised about the jaz drive performance
=)

> > only when I backed it up with tar.  In the event it doesn't lock, tar
> > crashes w/o error/warning (over NFS).
> 
> So, it locks not always?

In the above case, still was booted with init=/bin/sh and did not lockup.  I
did several tar backups.  Sometimes I got a segmentation fault and killed
tar, other times I got my shell killed.

I have not tried enabling TCP yet.  I'm going to try a 2.4 kernel soon.  (I
want to stay with 2.6 since I have a DVD+RW drive)

> > > byte or 1K or 1M? Does it lock immediately as you start the backup or
> >
> > It locks up usually at one point, but not always.
> 
> Since you could backup to Jazz, looks like your filesystem is ok, NFS also
> works in principle...

As stated above, one of the filesystems did not completely backup.

> > > after some time (you could start some process in the background
> > > periodically printing some info on the terminal, like vmstat, cat
> > > /proc/interrupts, free, tcpdump on both ends to a file...) Can you try NFS
> >
> > I can do this I think.  It's fun when running with init being bash.  It will
> > take some time to do since I can't scroll backwards.
> 
> You could also attach a serial console and direct the output there (then
> you also can scroll).

I have not retrieved this yet.

> > > 10/100mbps?
> >
> > 100 FD always.
> 
> Why I am interested in your experiences is that I also have a problem
> transferring large (several M) files over NFS when the server is 2.6 and
> both ends have 100 FD. (You can see my posts this week about 2.6 NFS.) And
> in my case it TCP fixed it. But I never had hard-locks, just cp hanged in
> D, and tcpdump showed timed out reassembly on the receiving side. But I
> was reading from the server.

I have done several gig of transfers to the 2.4 server.  I was burning a
bunch of data from nfs to dvd+r.

In the tests I did above, I ran dmesg several times, Not once did I see an
oops.  I'm not sure, I may have a hardware problem (It's going to be
replaced soon anyway)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
