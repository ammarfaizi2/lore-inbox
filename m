Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136958AbREJV7F>; Thu, 10 May 2001 17:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136959AbREJV6z>; Thu, 10 May 2001 17:58:55 -0400
Received: from [63.95.87.168] ([63.95.87.168]:42501 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S136958AbREJV6h>;
	Thu, 10 May 2001 17:58:37 -0400
Date: Thu, 10 May 2001 17:58:36 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010510175836.A16497@xi.linuxpower.cx>
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010510134453.A6816@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, May 10, 2001 at 01:44:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 01:44:53PM +0200, Matthias Andree wrote:
[snip]
> If you're deploying a cache partition such as /var/squid (possibly
> having log files in another /var/log partition on another disk drive),
> what's the point about not running (e.  g.) mke2fs and squid -z on boot,
> as well as mounting the system partitions (/usr) read-only (prevents
> fsck on next reboot)? mke2fs is faster than reiserfs recovery probably
> ;-)

A while ago I configured a few squid boxes which ran off of a read-only
system. Mke2fs is actually unacceptably slow on large file systems, faster
then fsck, but still time consuming. I found that zeroing out the disk, then
formating it and saving the non-zero blocks, replaying them on reboot to be
an acceptable solution.
