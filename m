Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136208AbRD0Uci>; Fri, 27 Apr 2001 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136211AbRD0Uc2>; Fri, 27 Apr 2001 16:32:28 -0400
Received: from irc.penguinhosting.net ([206.152.182.152]:44951 "HELO
	zeus.penguinhosting.net") by vger.kernel.org with SMTP
	id <S136208AbRD0UcX>; Fri, 27 Apr 2001 16:32:23 -0400
Date: Fri, 27 Apr 2001 20:32:20 +0000
From: Ian Gulliver <ian@penguinhosting.net>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS oops/panic/uninterruptable sleeps in -ac
Message-ID: <20010427203220.A10517@penguinhosting.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux zeus.penguinhosting.net 2.4.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an SMP PenIII that had been running 2.4.1-ac18 for 65
days.  Its /home partition was a newly created (first used on
that kernel) ResierFS 3.6.x partition.  For no obvious reason,
two days ago, processes started going into uninterruptable
sleeps, reportedly in "down" in the kernel.  

We rebooted into 2.4.3-ac14, and suddenly we had oops and
eventually panics when accessing certain parts of /home.
(just an "ls" could spawn an oops, and an "ls -l" could
spawn a panic).  This is a production box, so unfortunately
writing down the oops/panic info was the lowest priority
on my list and it didn't happen.

We tried a reiserfsck with the newest reiserfsutils with
both --rebuild-sb and --rebuild-tree, and neither worked.

Finally, as a last resort before returning to ext2, we tried
2.4.3 stock kernel.  Magically, everything worked fine.
We have yet to see any instability, and we can't make any
processes stick, even under load.

This seems to be a bug somewhere in the ac patch, possibly
related to SMP.  If anyone could figure it out, it'd really
be nice to fix this before the bug makes it way into the
stock kernels.

Ian Gulliver
Penguin Hosting
http://www.penguinhosting.net/
