Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318932AbSHMEJD>; Tue, 13 Aug 2002 00:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318933AbSHMEJD>; Tue, 13 Aug 2002 00:09:03 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:55348 "HELO
	larvalstage.com") by vger.kernel.org with SMTP id <S318932AbSHMEJC>;
	Tue, 13 Aug 2002 00:09:02 -0400
Date: Tue, 13 Aug 2002 00:20:00 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Cc: drew@colorado.edu
Subject: devfs compile breaks on 2.4.20-pre2
Message-ID: <Pine.LNX.4.44.0208130011120.1762-100000@daria.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


devfs is seems to be broken for 2.4.20-pre2 because include/linux/genhd.h
has been modified from 2.4.20-pre1.  I see that 'number' member has been
removed from hd_struct in include/linux/genhd.h.

Functions devfs_register_disc and devfs_register_partitions in
fs/partitions/check.c is still expecting "number" it to be there.

Unfortunately I don't know enough about devfs (or kernel in general) to
fix this.  My apologies if this mailing list wrong place to report
problems like this.


John Kim

