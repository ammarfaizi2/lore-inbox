Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKHMSS>; Thu, 8 Nov 2001 07:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277188AbRKHMSJ>; Thu, 8 Nov 2001 07:18:09 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:38404 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277317AbRKHMRx>; Thu, 8 Nov 2001 07:17:53 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15338.30575.374302.718516@beta.reiserfs.com>
Date: Thu, 8 Nov 2001 15:15:43 +0300
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: Sasha Pachev <sasha@mysql.com>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk I/O - 2.4.13
In-Reply-To: <Pine.LNX.4.40.0111080627320.12430-100000@omega.hbh.net>
In-Reply-To: <Pine.LNX.4.40.0111080546030.12366-100000@omega.hbh.net>
	<Pine.LNX.4.40.0111080627320.12430-100000@omega.hbh.net>
X-Mailer: VM 6.96 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oktay Akbal writes:
 > I just did a quick retest with  sql-bench on my machine and found that
 > reiserfs seems to be a source for that problem.
 > I did not reproduce the whole problem, since i stopped
 > test-create before the system was to unresponsive.
 > 
 > But I started test-create on a partition with
 > reiserfs. After much files were created the system to very
 > long for bash command-completion or doing simple thing
 > free, top etc. this was even after test-create was stopped.
 > It took about 30 seconds till the system responded normally.
 > 
 > Same test with ext2 on the same partition showed no problems.
 > 
 > Reran the test with reiserfs and the system got unresponsive
 > again.

It doesn't seem that you have the same problem as Sasha. Reiserfs has
known problem with dealing with large holes, so may be this explains
situation. We'll try to reproduce your results.

 > 
 > Did you use reiserfs ?
 > 
 > Oktay
 > 

Nikita.

 > 
 > On Thu, 8 Nov 2001, Oktay Akbal wrote:
 > 
 > > On Wed, 7 Nov 2001, Sasha Pachev wrote:
 > >
 > > > Summary:
 > > >
 > > > System slowdown under unexplained excessive disk I/O
 > > >
 > > > Full description:
 > > >
 > > > While running X, KDE, having a few windows open, I ran make -j4 on MySQL
 > > > source tree. I do this all the time and it usually works just fine - the
 > > > system is a little bit unresponsive. However, occasionally the system becomes
 > > > completely unresponsive - the disk goes crazy, the machine pings but neither
 > > > ssh or telnet work - connection to the port is established, but nothing
 > > > further than that. It does respond to magic SysRQ. I was able to get a memory
 > > > info dump + stack traces into syslog, included below. The filesystem is
 > > > ReiserFS.
 > 
