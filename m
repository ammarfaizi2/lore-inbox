Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290098AbSAQVev>; Thu, 17 Jan 2002 16:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290471AbSAQVel>; Thu, 17 Jan 2002 16:34:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290098AbSAQVeh>; Thu, 17 Jan 2002 16:34:37 -0500
Date: Thu, 17 Jan 2002 16:34:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrew Morton <akpm@zip.com.au>
cc: Matt Bernstein <matt@theBachChoir.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: probably very irrelevant oops
In-Reply-To: <3C4739D3.DCFFA025@zip.com.au>
Message-ID: <Pine.LNX.3.95.1020117162359.137A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Andrew Morton wrote:

> Matt Bernstein wrote:
> > 
> > Hi,
> > 
> > I built a fairly pathological kernel based on 2.4.17 with sched-O1-H7,
> > ext3-0.9.17, XFS, jfs-1.0.12 and Intel's e100. (Things are orthogonal
> > enough that they patch together easily :)
> > 
> > It boots fine (but not with devfs) and I can use all four journaled
> > filesystems together happily. So I thought I'd try two very stupid stress
> > tests.
> > 
> > find /lib/modules/2.4.17-expt/kernel/ -type f|while read i; do insmod $i; done
> 
> You're sick.  I like you.

[SNIPPED....]

More sickness follows...

The following script. Used to insert modules, many wouldn't install of
course... In fact, if I would run it several times, I could get the
modules that had to be loaded in a specific order to be installed, then
use `modprobe -c` to make a current listing for /etc/modules.conf.


VER=`uname -r`

for x in `find /lib/modules/${VER} -name "*.o"` ; do
echo $x
insmod $x
done


But with Linux-2.4.7, the system Crashes to a hard-stop on:

MIDI Loopback device driver.
XM 3812 and ODL3

Another OOps at
cs98x0.c


That's about all I could see. There were no logs upon boot, in fact,
some SCSI disk driver installed itself instead of my BusLogic so
no disk I/O was possible!!!



Cheers,
Dick Johnson

Penguin : Linux version 2.4.7 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


