Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbRLRS5Y>; Tue, 18 Dec 2001 13:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284612AbRLRSzt>; Tue, 18 Dec 2001 13:55:49 -0500
Received: from ash.lnxi.com ([207.88.130.242]:64501 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S284694AbRLRSzK>;
	Tue, 18 Dec 2001 13:55:10 -0500
To: Guolin Cheng <Guolin@alexa.com>
Cc: linux-kernel@vger.kernel.org,
        Etherboot-users <etherboot-users@lists.sourceforge.net>
Subject: Re: [Etherboot-users] 1G memory limit and Etherboot
In-Reply-To: <A6CFEF730CCE38449F1774A6B5D62B0C031963@shockG.archive.alexa.com>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 18 Dec 2001 11:55:05 -0700
In-Reply-To: <A6CFEF730CCE38449F1774A6B5D62B0C031963@shockG.archive.alexa.com>
Message-ID: <m3zo4gs6ie.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guolin Cheng <Guolin@alexa.com> writes:

> hi, Eric,
> 
>  I tried a few days ago, using etherboot 5.0.2, mknbi 1.2.6 with different
> --rdbase options, but all failed. The kernel is 2.4.13, the initrd is around
> 64M. 

Unless something regressed 2.4.13 should be fairly robust in this
regard.
 
>  The netbooted client is a 1.5G memory HP Vectra 420. It can successfully
> netbooted with 512M memory. But can not boot when memory is added to 1024M
> and 1.5G.
> 
>  The error prompt is something like:
> 
> 	Kernel panic: VFS: Unable to mount root fs on 01:00

Which just means it couldn't find your ramdisk.  If you could please
report all of your kernel messages.  A serial console is ideal for that
purpose.  Without more information I cannot even guess why you are having
problems.

>  I'm using Official kernel 2.4.13, the base system is RedHat 7.1 on HP
> vectra 420.
> 
>  The commands I used to create the tagged images is:
> 
>  /usr/bin/mknbi-linux --output=./kernel.test.0540 --ip=dhcp
> --rdbase=0x5b000000 --rootdir=/dev/ram0 --append="idebus=66 ide0=ata66
> ide1=ata66 ro" bzImage initrd
> 
>  I also tried options, --rdbase=top/asis/0x00300000, all can failed with the
> same above problem.
> 
>  At last I use local hard disk boot, with the same kernel (4G high memory
> option enabled), it can boot successfully, then I tried to see the memory
> mapping, and get the following information:
> 
[snip]
> 
>  Please suggest which method, I can try to netboot the machine. Thanks a
> lot.


Eric
