Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318092AbSGROw7>; Thu, 18 Jul 2002 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318107AbSGROw7>; Thu, 18 Jul 2002 10:52:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18696 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318092AbSGROw6>; Thu, 18 Jul 2002 10:52:58 -0400
Date: Thu, 18 Jul 2002 10:50:34 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020716212322.GT442@clusterfs.com>
Message-ID: <Pine.LNX.3.96.1020718104332.7522A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Andreas Dilger wrote:

> This is all done already for both LVM and EVMS snapshots.  The filesystem
> (ext3, reiserfs, XFS, JFS) flushes the outstanding operations and is
> frozen, the snapshot is created, and the filesystem becomes active again.
> It takes a second or less.  Then dump will guarantee 100% correct backups
> of the snapshot filesystem.  You would have to do a backup on the snapshot
> to guarantee 100% correctness even with tar.

I think I'm missing a part of this, the "a snapshot is created" sounds a
lot like "here a miracle occurs." Where is this snapshot saved? And how do
you take it in one sec regardless of f/s size? Is this one of those
theoretical things which requires two mirrored copies of the f/s so you
will still have RAID-1 after you break one? Or are changes journaled
somewhere until the snapshot is transferred to external media? And how do
you force applications to stop with their files in a valid state?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

