Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317993AbSGPVgP>; Tue, 16 Jul 2002 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSGPVgO>; Tue, 16 Jul 2002 17:36:14 -0400
Received: from p508875D5.dip.t-dialin.net ([80.136.117.213]:58259 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317993AbSGPVgK>; Tue, 16 Jul 2002 17:36:10 -0400
Date: Tue, 16 Jul 2002 15:38:50 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020716212322.GT442@clusterfs.com>
Message-ID: <Pine.LNX.4.44.0207161534280.3452-100000@hawkeye.luckynet.adm>
X-Location: Calgary; CA
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, Andreas Dilger wrote:
> This is all done already for both LVM and EVMS snapshots.  The filesystem
> (ext3, reiserfs, XFS, JFS) flushes the outstanding operations and is
> frozen, the snapshot is created, and the filesystem becomes active again.
> It takes a second or less.

Anyway, we could do that in parallel if we did it like that:

sync	-> significant data is being written
lock	-> data writes stay cached, but aren't written
snapshot
unlock	-> data is getting written
now unmount the snapshout (clean it)
write the modified snapshot to disk...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

