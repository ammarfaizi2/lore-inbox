Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbTCTX07>; Thu, 20 Mar 2003 18:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTCTX07>; Thu, 20 Mar 2003 18:26:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48565 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263320AbTCTX05>;
	Thu, 20 Mar 2003 18:26:57 -0500
Date: Thu, 20 Mar 2003 15:34:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: akpm@digeo.com, green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs oops [2.5.65]
Message-Id: <20030320153427.6265e864.rddunlap@osdl.org>
In-Reply-To: <20030320231335.GB4638@suse.de>
References: <20030319141048.GA19361@suse.de>
	<20030320112559.A12732@namesys.com>
	<20030320132409.GA19042@suse.de>
	<20030320165941.0d19d09d.akpm@digeo.com>
	<20030320231335.GB4638@suse.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003 23:13:35 +0000 Dave Jones <davej@codemonkey.org.uk> wrote:

| On Thu, Mar 20, 2003 at 04:59:41PM -0800, Andrew Morton wrote:
|  > > 
|  > > Slab corruption: start=c70c7044, expend=c70c7213 problemat=c70c7044
|  > > Last user: [<c0280dcb>](reiserfs_alloc_inode+0x1b/0x30)
|  > > Data: (lots of hex)
|  > 
|  > Alas, the "(lots of hex)" is important - it lets us determine which member of
|  > struct reiserfs_inode was actually altered.
| 
| You're in luck, as noted in the follow up, I captured it all..
| http://www.codemonkey.org.uk/cruft/oops.txt
|  
|  > It would be nice if we had a more robust way of capturing all this info,
|  > especially the oops-while-running-X lossage.  Dump-to-floppy or something.
| 
| The tricky thing about capturing this one was that something in the VFS
| was wedged hard, so I'm lucky the logs made it to disk.
| Using sysrq, I synced and the disks made really nasty chugging noises.
| umount read only made it write a bunch of stuff out, more chugging
| noises for 15 minutes, kill all tasks then popped up a getty for me to
| log in on. It took about 3 minutes to get a shell (disk IO was seriously
| slow). I took a peek at vmstat 1 (no logs of this sorry), and nothing
| out of the ordinary. Not much in swap, plenty of swap free.
| short: the machine was horked. I synced, and rebooted, and thankfully
| the logs were still there after fsck.ext2 recovered /var

I've done some 2.5.xyz work on kmsgdump (dump kernel messages to
floppy).  I'll try to get back to it soon.

--
~Randy
