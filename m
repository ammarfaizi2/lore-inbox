Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSGQSoW>; Wed, 17 Jul 2002 14:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSGQSoW>; Wed, 17 Jul 2002 14:44:22 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61191 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316598AbSGQSoW>; Wed, 17 Jul 2002 14:44:22 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Date: 17 Jul 2002 18:41:59 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ah4dpn$2tj$1@gatekeeper.tmr.com>
References: <1026490866.5316.41.camel@thud> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann> <20020715211448.GI442@clusterfs.com>
X-Trace: gatekeeper.tmr.com 1026931319 2995 192.168.12.62 (17 Jul 2002 18:41:59 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020715211448.GI442@clusterfs.com>,
Andreas Dilger  <adilger@clusterfs.com> wrote:

| Well, the dump can only be inconsistent for files that are being changed
| during the dump itself.  As for hanging the system, that would be a bug
| regardless of whether it was dump or "dd" reading from the block device.
| A bug related to this was fixed, probably in 2.4.19-preX somewhere.

Any dump on a live f/s would seem to have the problem that files are
changing as they are read and may not be consistant. I suppose there
could be some kind of "fsync and journal lock" on a file, allowing all
writes to a file to be journaled while the file is backed up. However,
such things don't scale well for big files with lots of writes, and the
file, while unchanging, may not be valid.

Backups of running files are best done by the application, like Oracle
as a for-instance. Neither the o/s nor the backup can be sure when/if
the data is in a valid state.

Tar has this problem, although not the same issues with data on the fly
in buffers.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
