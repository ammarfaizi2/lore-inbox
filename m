Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSIVXvA>; Sun, 22 Sep 2002 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264623AbSIVXvA>; Sun, 22 Sep 2002 19:51:00 -0400
Received: from bitmover.com ([192.132.92.2]:21948 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264619AbSIVXu7>;
	Sun, 22 Sep 2002 19:50:59 -0400
Date: Sun, 22 Sep 2002 16:56:04 -0700
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200209222356.g8MNu4V10172@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: boring BK stats
Cc: dev@bitmover.com
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should be working on getting the bk-3.0 release done but I'm sick of
fixing BK-on-windows bugs...

Linus' kernel tree has 13333 revision controlled files in it.  Without
repository compression, it eats up 280M in an ext2 fs.  With repository
compression, that drops to 129M.  After checking out all the files, the
size of the revision history and the checked out files is 317MB when
the revision history is compressed.  That means the tree without the
history is 188MB, we get the revision history in less space than the
checked out tree.  That's pretty cool, by the way, I know of no other
SCM system which can say that.

Checking out the tree takes 16 seconds.  Doing an integrity check takes 10
seconds if the repository is uncompressed, 15 seconds if it is compressed.
That's on 1.3Ghz Athlon w/ PC133 memory running at the slower CAS rate,
but lots of it, around 900MB.

An integrity check checksums the entire revision history and does a
checkout into /dev/null to make sure that both the overall and most
recent delta checksums are valid.

There are about 8600 changesets in the tree.  There have been 76998
deltas made to the tree since Feb 05 2002.  That's an average of 37
changesets and 333 deltas per *day* seven days a week.  If you assume
a 5 day work week then the numbers are 52 csets/day and 466 deltas/day.

Those changerate numbers are pretty zippy.  You guys are rockin'.

As for syncs with bkbits, I dunno, my guess is we're pushing 300,000 pulls
or so.  We're nowhere near to saturating the T1 line so BK compression
stuff is working well.
