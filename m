Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281425AbRKHFeF>; Thu, 8 Nov 2001 00:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281474AbRKHFdq>; Thu, 8 Nov 2001 00:33:46 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:63668 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281425AbRKHFdm>; Thu, 8 Nov 2001 00:33:42 -0500
Date: Thu, 8 Nov 2001 06:33:40 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: Sasha Pachev <sasha@mysql.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk
 I/O - 2.4.13
In-Reply-To: <Pine.LNX.4.40.0111080546030.12366-100000@omega.hbh.net>
Message-ID: <Pine.LNX.4.40.0111080627320.12430-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.25)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just did a quick retest with  sql-bench on my machine and found that
reiserfs seems to be a source for that problem.
I did not reproduce the whole problem, since i stopped
test-create before the system was to unresponsive.

But I started test-create on a partition with
reiserfs. After much files were created the system to very
long for bash command-completion or doing simple thing
free, top etc. this was even after test-create was stopped.
It took about 30 seconds till the system responded normally.

Same test with ext2 on the same partition showed no problems.

Reran the test with reiserfs and the system got unresponsive
again.

Did you use reiserfs ?

Oktay


On Thu, 8 Nov 2001, Oktay Akbal wrote:

> On Wed, 7 Nov 2001, Sasha Pachev wrote:
>
> > Summary:
> >
> > System slowdown under unexplained excessive disk I/O
> >
> > Full description:
> >
> > While running X, KDE, having a few windows open, I ran make -j4 on MySQL
> > source tree. I do this all the time and it usually works just fine - the
> > system is a little bit unresponsive. However, occasionally the system becomes
> > completely unresponsive - the disk goes crazy, the machine pings but neither
> > ssh or telnet work - connection to the port is established, but nothing
> > further than that. It does respond to magic SysRQ. I was able to get a memory
> > info dump + stack traces into syslog, included below. The filesystem is
> > ReiserFS.

