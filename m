Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSGPVDt>; Tue, 16 Jul 2002 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSGPVDs>; Tue, 16 Jul 2002 17:03:48 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:15880 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S318190AbSGPVDq>; Tue, 16 Jul 2002 17:03:46 -0400
Date: Tue, 16 Jul 2002 23:06:39 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716210639.GC30235@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716193831.GC22053@merlin.emma.line.org> <Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
In-Reply-To: <Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 16 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> On Tue, 16 Jul 2002, Matthias Andree wrote:
> > > or the blockdevice-level snapshots already implemented in Linux..
> > 
> > That would require three atomic steps:
> > 
> > 1. mount read-only, flushing all pending updates
> > 2. take snapshot
> > 3. mount read-write
> > 
> > and then backup the snapshot. A snapshots of a live file system won't
> > do, it can be as inconsistent as it desires -- if your corrupt target is
> > moving or not, dumping it is not of much use.
> 
> Well, couldn't we just kindof lock the file system so that while backing 
> up no writes get through to the real filesystem? This will possibly 
> require a lot of memory (or another space to write to), but it might be 
> done?

But you would want to backup a consistent file system, so when entering
the freeze or snapshot mode, you must flush all pending data in such a
way that the snapshot is consistent (i. e. needs not fsck action
whatsoever).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9NIrfFmbjPHp/pcMRAkAyAJ4wQhTUafOHDrmmA2DGrFKn9NEOHwCdHM3Q
UdlrkGbhUynS86ogxstbdQM=
=vK/f
-----END PGP SIGNATURE-----
