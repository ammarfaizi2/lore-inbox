Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUDWUey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUDWUey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUDWUey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:34:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261347AbUDWUew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:34:52 -0400
Date: Fri, 23 Apr 2004 16:34:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
cc: Paul Jackson <pj@sgi.com>, Timothy Miller <miller@techsource.com>,
       tytso@mit.edu, miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
In-Reply-To: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu>
Message-ID: <Pine.LNX.4.53.0404231624010.1352@chaos>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Joel Jaeggli wrote:

> On Fri, 23 Apr 2004, Paul Jackson wrote:
>
> > > SO... in addition to the brilliance of AS, is there anything else that
> > > can be done (using compression or something else) which could aid in
> > > reducing seek time?
> >
> > Buy more disks and only use a small portion of each for all but the
> > most infrequently accessed data.
>
> faster drives. The biggest disks at this point are far slower that the
> fastest... the average read service time on a maxtor atlas 15k is like
> 5.7ms on 250GB western digital sata, 14.1ms, so that more than twice as
> many reads can be executed on the fastest disks you can buy now... of
> course then you pay for it in cost, heat, density, and controller costs.
> everthing is a tradeoff though.
>

If you want to have fast disks, then you should do what I
suggested to Digital 20 years ago when they had ST-506
interfaces and SCSI was available only from third-parties.
It was called "striping" (I'm serious!). Not the so-called
RAID crap that took the original idea and destroyed it.
If you have 32-bits, you design an interface board for 32
disks. The interface board strips each bit to the data that
each disk gets. That makes the whole array 32 times faster
than a single drive and, of course, 32 times larger.

There is no redundancy in such an array, just brute-force
speed. One can add additional bits and CRC correction which
would allow the failure (or removal) of one drive at a time.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


