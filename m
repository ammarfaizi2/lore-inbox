Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTBTTUl>; Thu, 20 Feb 2003 14:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTBTTUl>; Thu, 20 Feb 2003 14:20:41 -0500
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:25745 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S266540AbTBTTUj>; Thu, 20 Feb 2003 14:20:39 -0500
Date: Thu, 20 Feb 2003 14:30:36 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: =?iso-8859-1?Q?Thomas_B=E4tzler?= <t.baetzler@bringe.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: filesystem access slowing system to a crawl 
In-Reply-To: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
Message-ID: <Pine.LNX.4.44.0302201133160.3029-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, Thomas,

On Tue, 4 Feb 2003, Thomas Bätzler wrote:

> maybe you could help me out with a really weird problem we're having
> with a NFS fileserver for a couple of webservers:
> 
> - Dual Xeon 2.2 GHz
> - 6 GB RAM
> - QLogic FCAL Host adapter with about 5.5 TB on a several RAIDs
> - Debian "woody" w/Kernel 2.4.19
> 
> Running just "find /" (or ls -R or tar on a large directory) locally
> slows the box down to absolute unresponsiveness - it takes minutes
> to just run ps and kill the find process. During that time, kupdated
> and kswapd gobble up all available CPU time. 
> 
> The system performs great otherwise, so I've ruled out a hardware
> problem. It can't be a load problem because during normal operation,
> the system is more or less bored out of its mind (70-90% idle time).
> 
> I'm really at the end of my wits here :-(
> 
> Any help would be greatly appreciated!

	I'm sure the inode problem Andrew and Andrea have pointed out is 
more likely.
	However, just out of interest, does the problem go away or become
less severe if you use "noatime" on that filesystem?

mount -o remount,noatime /my_raid_mount_point

	?
	Cheers,
	- Bill

---------------------------------------------------------------------------
	Lavish spending can be disastrous.  Don't buy any lavishes for a 
while.
(Courtesy of Paul Jakma <paul@clubi.ie>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

