Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbSALL50>; Sat, 12 Jan 2002 06:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285907AbSALL5Q>; Sat, 12 Jan 2002 06:57:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3144 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285878AbSALL5E>; Sat, 12 Jan 2002 06:57:04 -0500
Date: Sat, 12 Jan 2002 12:56:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020112125625.E1482@inspiron.school.suse.de>
In-Reply-To: <20020112004528.A159@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020112004528.A159@earthlink.net>; from rwhron@earthlink.net on Sat, Jan 12, 2002 at 12:45:28AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 12:45:28AM -0500, rwhron@earthlink.net wrote:
> 
> Patch to have 1-3 GB of virtual memory and not show up as highmem:
> 
> Tested on uniprocessor Athlon with 1024 MB RAM and 1027 MB swap.
> Caused no LTP (ltp-20020108) regressions.
> Did a test like http://marc.theaimsgroup.com/?l=linux-kernel&m=101064072924424&w=2
> This time the test completed in 51 minutes (11% faster) and I had setiathome running
> the whole time and listened to 12 mp3s sampled at 128k.
> 
> dmesg|grep Mem
> Memory: 1029848k/1048512k available (1054k kernel code, 18276k reserved, 260k data, 240k init, 0k highmem)
> 
> egrep '^CONFIG_HIGH|GB' /usr/src/linux/.config
> CONFIG_HIGHMEM4G=y
> CONFIG_HIGHMEM=y
> # CONFIG_1GB is not set
> CONFIG_2GB=y
> # CONFIG_3GB is not set
> # CONFIG_05GB is not set
> 
> uname -a
> Linux rushmore 2.4.18pre2aa2-2g #2 Fri Jan 11 22:25:55 EST 2002 i686 unknown
> 
> Derived from:
> htty://kernelnewbies.org/kernels/rh72/SOURCES/linux-2.4.2-vm-1-2-3-gbyte.patch
> Some parts of the patch above are already in the mainline trees.
> 
> Patch below applies to 2.4.18pre2aa2:

for a fileserver (even more if in kernel like tux) it certainly make
sense to have as much direct mapped memory as possible, it is not the
recommended setup for a generic purpose kernel though. So I applied the
patch (except the prefix thing which is distribution specific). thanks,

Andrea
