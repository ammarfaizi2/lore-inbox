Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbTLZHuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLZHuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:50:32 -0500
Received: from jack.feedbackplusinc.com ([64.25.11.70]:17098 "EHLO
	jack.feedbackplusinc.com") by vger.kernel.org with ESMTP
	id S264954AbTLZHub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:50:31 -0500
Subject: XFS filesystem corruption: 2.6.0. Massive failure. With raid5
From: Jerry Haltom <jhaltom@feedbackplusinc.com>
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072425031.737.9.camel@osaka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 01:50:31 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has happened twice now. Massive XFS file system corruption. The
system is running on a 3ware card in Raid5 config. / is XFS. Cannot
mount:

XFS: log has mismatchd uuid - can't recover
XFS: failed to find log head
XFS: log mount/recovery/failed
...

xfs_repair lets me know a lot of stuff, and:

* ERROR: mismathced uuid in log
* SB: some long number
* log: a slightly different long number

It doesn't work.

xfs_logprint -t /dev/sda4 produces a lot of illegal type errors and ends
up with Segmentation fault (uh oh).

I am willing to give an XFS developer access to the machine to poke
around (and fix it!!!) It's just my desktop at home, not a big deal. But
I have a ton of large files i'd like to recover. :)

I could fix it by forcing hte logs clean, that is what I did the first
time this happened. However, I lost a lot of files last time, and this
shouldn't happen. So here it is for you guys. I am hanging out in #xfs
on irc.freenode.net if anybody wants to check it out.

Jerry Haltom
Feedback Plus, Inc.

