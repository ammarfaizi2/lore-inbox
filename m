Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282212AbRLQTCi>; Mon, 17 Dec 2001 14:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282222AbRLQTC3>; Mon, 17 Dec 2001 14:02:29 -0500
Received: from codepoet.org ([166.70.14.212]:9993 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S282212AbRLQTCY>;
	Mon, 17 Dec 2001 14:02:24 -0500
Date: Mon, 17 Dec 2001 12:02:23 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root and initrd kernel panic woes
Message-ID: <20011217120222.A14761@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Torrey Hoffman <torrey.hoffman@myrio.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB07@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB07@mail0.myrio.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 17, 2001 at 10:38:51AM -0800, Torrey Hoffman wrote:
> 
> and then the system just hangs.  When it works, the messages are
> identical up to that point but continue...
> 
> init started:  BusyBox v0.51 (2001.04.25-13:32+0000) multi-call binary
> (etc.)

Any particular reason you are using a version of busybox that is 
quite old?  You really should get a newer release -- I've fixed a 
lot of bugs since then.

> I have a complete set of files and dev nodes for the initrd in 
> ./rootfs. They add up to about 3 MB.  Nothing too unusual - busybox, 
> glibc 2.1.3, etc.
> 
> My build system kernel is 2.4.16, has the standard 4 MB ramdisk, 
> and I use the following script to create the initrd:
> 
> #!/bin/bash
> 
> rm -rf initrd.gz
> umount /dev/ram
> mke2fs -m0 /dev/ram 4000
> mount -t ext2 /dev/ram /mnt/ramdisk
> cp -a rootfs/* /mnt/ramdisk
> umount /dev/ram
> dd if=/dev/ram bs=1k count=4000 of=initrd
> gzip initrd


Can you sucessfully chroot into your rootfs dir?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
