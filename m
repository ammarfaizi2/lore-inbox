Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTBGXbg>; Fri, 7 Feb 2003 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBGXbg>; Fri, 7 Feb 2003 18:31:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:60564 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266840AbTBGXbf>;
	Fri, 7 Feb 2003 18:31:35 -0500
Date: Fri, 7 Feb 2003 15:40:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-Id: <20030207154045.5080b1b0.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302071338130.926-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0302061848360.851-200000@localhost.localdomain>
	<Pine.LNX.4.44.0302071338130.926-200000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2003 23:41:09.0491 (UTC) FILETIME=[6407C430:01C2CF02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cox.net> wrote:
>
> Further on this problem.  I did a system restore to a disk on /dev/hdb, 
> fixed up fstab and other files so I could boot from /dev/hdb1.  I got 
> results similar to the original.  However, this time I did get log 
> messages.  

OK, I tried your .config and the same happened here - no console output and
huge amounts of disk I/O as the system was booting.  No filesystem problems
on reboot, however.

I couldn't immediately see the reason for this.  You have your whole input
layer configured as a module, perhaps that has upset things.

I suggest that you work on the config settings and find out what it is that
is causing the tty layer to not come up.

