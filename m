Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135820AbREFUAv>; Sun, 6 May 2001 16:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135823AbREFUAm>; Sun, 6 May 2001 16:00:42 -0400
Received: from idiom.com ([216.240.32.1]:28426 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S135820AbREFUAa>;
	Sun, 6 May 2001 16:00:30 -0400
Message-ID: <3AF5C81E.C52CF4F2@namesys.com>
Date: Sun, 06 May 2001 14:54:38 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ReiserFS seems to be stable as of 2.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug reports that are hardware failures masquerading as reiserfs bugs
dominate our mailing list.  We also get bug reports from users with
versions that are prior to 2.4.4.  We are now working on making the code
more likely to identify a hardware failure as a hardware failure
(without killing performance, which means there are many things we can
do but we can't fully cure that problem).

fsck is the one non-solid piece of our code, and that has greatly
improved and will hopefully be solid by June 1.  Two persons are working
on it full-time.

We have one bugfix in reiserfs that is not yet in the main kernel,
mainly because it is a deep bugfix that we are being careful with so
that it does not add more bugs.  One user only so far has hit that bug.

We have some new code that we are saving for 2.5.1, to relocate, resize,
and generally tune the journal, and to mark blocks bad for users that
need to do that for long enough to get a new disk drive (if you see bad
blocks, usually your drive is no longer worth trusting your home
directory to.)

We will improve performance throughout 2.5, with a new block allocator
and a journal tuning and relocation patch, being the most important
changes likely to happen soon.

All in all, things look good for starting work on reiser4 on June 1.:)

Hans
