Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSDDS2C>; Thu, 4 Apr 2002 13:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSDDS1w>; Thu, 4 Apr 2002 13:27:52 -0500
Received: from bitmover.com ([192.132.92.2]:22472 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289272AbSDDS1n>;
	Thu, 4 Apr 2002 13:27:43 -0500
From: Larry McVoy <lm@bitmover.com>
Date: Thu, 4 Apr 2002 10:27:39 -0800
Message-Id: <200204041827.g34IRdK13319@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: 2 months of BK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Time flies.  Just ran some stats in Linus' tree.  

Linus created his tree on 2002-04-03 17:03:45-08:00.

3177 changesets (logical changes/patches/whatever you want to call them).
55000 deltas in 11832 files.

BitKeeper overhead for maintaining this information, the changeset stuff, is
about 7MB uncompressed.  It started at about 1.5MB for the initial baseline,
so we're growing at about 3MB/month, which is a problem.  

Since I'm typing, here's the set of things we're currently concerned with and
working on for the Linux kernel tree:

    a) Performance of updates.  The actual updates themselves are fairly fast
       but the integrity checks hurt.  We've already released a new version
       which does less integrity checks if you turn on partial_check: yes
       in the config file.

    b) Space overhead.  The design of the changeset data structures doesn't
       scale well enough and we know how to do better.

    c) LODs.  We've been stewing on the discussions that occurred here on
       the whole "I want to have people test this so it needs to be in BK
       but then later I want it out of BK".  We have a LOD design that makes
       that possible and also gives you named containers for each maintainer,
       cherry picking, etc.

    d) Nested repositories. This gives you the ability to chop up the kernel
       and have only the parts you actually need on your disk, that's the
       theory at least.  We have commercial customers who really want this
       and I think it may be useful for the kernel as well.

Those are the main ones and that's enough to keep us busy for several months
at least.
