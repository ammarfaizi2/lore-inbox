Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281476AbRKHGMJ>; Thu, 8 Nov 2001 01:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281477AbRKHGL7>; Thu, 8 Nov 2001 01:11:59 -0500
Received: from [208.48.139.185] ([208.48.139.185]:11990 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S281476AbRKHGLz>; Thu, 8 Nov 2001 01:11:55 -0500
Date: Wed, 7 Nov 2001 22:11:48 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug - System slowdown under unexplained excessive disk I/O - 2.4.13
Message-ID: <20011107221148.A7828@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111080425.fA84Pdb04541@mysql.sashanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111080425.fA84Pdb04541@mysql.sashanet.com>; from sasha@mysql.com on Wed, Nov 07, 2001 at 09:25:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 09:25:38PM -0700, Sasha Pachev wrote:
> 
> Summary: 
> 
> System slowdown under unexplained excessive disk I/O 
> 
> Full description: 
> 
> While running X, KDE, having a few windows open, I ran make -j4 on MySQL 
> source tree. I do this all the time and it usually works just fine - the 
> system is a little bit unresponsive. However, occasionally the system becomes 
> completely unresponsive - the disk goes crazy, the machine pings but neither 
> ssh or telnet work - connection to the port is established, but nothing 
> further than that. It does respond to magic SysRQ. I was able to get a memory 
> info dump + stack traces into syslog, included below. The filesystem is 
> ReiserFS.
> 
> Keywords: 
> 
> vm, ReiserFS, heavy disk I/O,

Let me guess, IDE disks?  Anyway, this is a FAQ.  Go www.namesys.com, click
on the FAQ, and look at #15.

This issue really can be a problem as the entire machine will freeze up for
a good chunk of time while the disk churns away.  Strangely enough, I've
only noticed it on some machines, not all.  But it's enough of a problem to
cause me to switch to ext3.

-Dave
