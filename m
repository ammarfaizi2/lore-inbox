Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSCARux>; Fri, 1 Mar 2002 12:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293460AbSCARum>; Fri, 1 Mar 2002 12:50:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15488 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293458AbSCARue>; Fri, 1 Mar 2002 12:50:34 -0500
Date: Fri, 1 Mar 2002 12:50:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Matthew Allum <mallum@xblox.net>, linux-kernel@vger.kernel.org
Subject: Re: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
In-Reply-To: <Pine.LNX.4.44.0203011749480.11136-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.3.95.1020301123724.5515A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Zwane Mwaikambo wrote:

> On Fri, 1 Mar 2002, Richard B. Johnson wrote:
> 
> > Turn off CONFIG_X86_WP_WORKS_OK and CONFIG_X86_CMPXCHG. This allows
> > booting using Linux Version 2.4.1.
> 
> I'm sure others have asked you before, why do you have an obsession
>  with 2.4.1?
> 
> Thanks,
> 	Perplexed.

Later versions, including the current 2.4.18 fail, to mount an initrd.
Since I use the same kernel for everything (very small), with different
modules as different machines may require, I need a working initrd.

This machine, and several others, require SCSI modules to be installed
before the final root file-system is accessible. The last kernels I've
tried, 2.2.17 and 2.2.18 find a compressed file-system for initrd, then
promptly free it. I end up with a panic can't mount root on 1:0. This
is /dev/ram0. I have tried /dev/ram1 (1:1) as well. The kernel recognizes
what file-system it should mount, but doesn't. This has been reported
on LK several times over the past year. I even provided a script that
any interested person can execute to make an 'initrd floppy' to verify
that a root file-system can be found and mounted. The only responses
I got were things like; "You should use cramfs". I need an ext2
file-system on the RAM Disk. I guess there's no longer any interest
in that amongst kernel developers. 

Once somebody makes a kernel they has both a working loop device and
a working initial RAM Disk, I will use that kernel. In the meantime,
I'm stuck at 2.4.1.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

