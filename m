Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTAWMoO>; Thu, 23 Jan 2003 07:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTAWMoO>; Thu, 23 Jan 2003 07:44:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54159 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265139AbTAWMoN>; Thu, 23 Jan 2003 07:44:13 -0500
Date: Thu, 23 Jan 2003 07:53:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Yao Minfeng <yaomf@gdufs.edu.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: new kernel fail
In-Reply-To: <005101c2c2d1$3a5b2380$81df74ca@hammer>
Message-ID: <Pine.LNX.3.95.1030123075021.31010A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Yao Minfeng wrote:

> Dear friends,
> 
> I am rather new to Linux, but really want to have a try. I am running RedHat
> 7.2 with the kernel of
> 2.4.7-10. I just compiled the 2.4.12 and 2.4.16 Kernel, however, when I
> login to the system, I found that
> 
> 1)
> 
> Login: root
> Passwd:
> 
> bash: id: Command not found
> bash: id: Command not found
> bash: id: Command not found
> 
> [: Too many arguments
> 
> ...
> 
> 
> 2) all the files under /home, /usr are missing, this happens both for 2.4.12
> and 2.4.16, but when I login back to 2.4.7-10, the files are there again, I
> can't figure it out.
> 
> Any help is welcome.
> 
> Thanks.
> 
Looks like the order of your file partitions (or labels) got
changed between kernel versions so that your 'slices' are not
being mounted.

do `df` to see what got mounted. Try to mount the other paritions,
first under /mnt, then later at there correct place after to
inspect them under /mnt to see which is which.

After you have it all sorted out, change the entries in
/etc/fstab to be correct for the next boot.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


