Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280995AbRKOTAh>; Thu, 15 Nov 2001 14:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280985AbRKOTA1>; Thu, 15 Nov 2001 14:00:27 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4592 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280995AbRKOTAV>;
	Thu, 15 Nov 2001 14:00:21 -0500
Date: Thu, 15 Nov 2001 11:59:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat description for proc.txt
Message-ID: <20011115115939.I5739@lynx.no>
Mail-Followup-To: Sven Heinicke <sven@research.nj.nec.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com>; from sven@research.nj.nec.com on Thu, Nov 15, 2001 at 10:29:27AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  10:29 -0500, Sven Heinicke wrote:
> +cpu  58903 1 7337 221340
> +
> +The individual "cpu" entry is will be the same as "cpu0" if you only
> +have one CPU on your system.  Otherwise the "cpu" entry will be a
> +total of all the separate CPU stats.  The four numbers following "cpu"
> +entries are: user, nice, system and unused usage (I think unused usage
> +anyway).

Units of what?  Probably jiffies.  Also "unused" is actually better
described as "idle".

> +disk_io: (3,0):(21459,9839,195208,11620,184240) 
> +
> +The "disk_io" shows data for each active disk.  The above example only
> +shows one active disk.  The first pair is the major followed by the
> +disk number entry.  The others are `dk_drive', `dk_drive_rio',
> +`dk_drive_rblk', `dk_drive_wio', `dk_drive_wblk' entries for that
> +disk.  (If I ever figure out what they are i'll describe them
> +beter. -Sven)

Looks like (in order):
- total number of I/O operations on this drive
- read I/O operations
- read I/O sectors
- write I/O operations
- write I/O sectors

> +btime 1005238271
> +Can't figure what "btime" is.

This appears to be the time in seconds (i.e. unix time = seconds
since Jan 1, 1970), when the system booted. time(0) - btime will
give you uptime in seconds, (as should the sum of all the "cpu"
times / HZ, if you knew what HZ was in userspace).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

