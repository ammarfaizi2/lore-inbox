Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbREXCTQ>; Wed, 23 May 2001 22:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbREXCTG>; Wed, 23 May 2001 22:19:06 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:65296 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S263344AbREXCS6>; Wed, 23 May 2001 22:18:58 -0400
Date: Thu, 24 May 2001 10:18:55 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loopback, unable to release
In-Reply-To: <3B0BD750.4010306@lycosmail.com>
Message-ID: <Pine.LNX.4.33.0105241013120.203-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.5-pre5 and before on 2.4.x (without -ac) and don't have such
problem.

boston:root:/tmp> mount -o loop ram /mnt
boston:root:/tmp> umount /mnt
boston:root:/tmp> strace losetup -d /dev/loop0
execve("/sbin/losetup", ["losetup", "-d", "/dev/loop0"], [/* 47 vars */])
= 0
brk(0)                                  = 0x804b408
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)


Did you umount the loopback device or ensure that nobody is using it?



On Wed, 23 May 2001, Adam Schrotenboer wrote:

> Using 2.4.4-ac3 (as well as in 2.4.3*) I have found it impossible to
> unmap a loopback
>
> strace losetup -d /dev/loop0 (relevant portion)
>
> open("/dev/loop0", O_RDONLY)            = 3
> ioctl(3, LOOP_CLR_FD, 0)                = -1 EBUSY (Device or resource busy)

