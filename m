Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUDWU6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUDWU6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUDWU6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:58:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261378AbUDWU62 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:58:28 -0400
Date: Fri, 23 Apr 2004 16:59:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
In-Reply-To: <yw1xoepio24x.fsf@kth.se>
Message-ID: <Pine.LNX.4.53.0404231651120.1643@chaos>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu>
 <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, [iso-8859-1] Måns Rullgård wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
>
> > On Fri, 23 Apr 2004, Joel Jaeggli wrote:
> >
> >> On Fri, 23 Apr 2004, Paul Jackson wrote:
> >>
> >> > > SO... in addition to the brilliance of AS, is there anything else that
> >> > > can be done (using compression or something else) which could aid in
> >> > > reducing seek time?
> >> >
> >> > Buy more disks and only use a small portion of each for all but the
> >> > most infrequently accessed data.
> >>
> >> faster drives. The biggest disks at this point are far slower that the
> >> fastest... the average read service time on a maxtor atlas 15k is like
> >> 5.7ms on 250GB western digital sata, 14.1ms, so that more than twice as
> >> many reads can be executed on the fastest disks you can buy now... of
> >> course then you pay for it in cost, heat, density, and controller costs.
> >> everthing is a tradeoff though.
> >>
> >
> > If you want to have fast disks, then you should do what I
> > suggested to Digital 20 years ago when they had ST-506
> > interfaces and SCSI was available only from third-parties.
> > It was called "striping" (I'm serious!). Not the so-called
> > RAID crap that took the original idea and destroyed it.
> > If you have 32-bits, you design an interface board for 32
> > disks. The interface board strips each bit to the data that
> > each disk gets. That makes the whole array 32 times faster
> > than a single drive and, of course, 32 times larger.
>
> For best performance, the spindles should be synchronized too.  This
> might be tricky with disks not intended for such operation, of course.

Actually not. You need a FIFO to cache your bits into buffers of bytes
anyway. Depending upon the length of the FIFO, you can "rubber-band" a
lot of rotational latency. When you are dealing with a lot of drives,
you are never going to have all the write currents turn on at the same
time anyway because they are (very) soft-sectored, i.e., block
replacement, etc.

Your argument was used to shout down the idea. Actually, I think
it was lost in the NIH syndrome anyway.

>
> --
> Måns Rullgård
> mru@kth.se
>


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


