Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbREWWbf>; Wed, 23 May 2001 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbREWWbZ>; Wed, 23 May 2001 18:31:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34829 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263296AbREWWbJ>;
	Wed, 23 May 2001 18:31:09 -0400
Date: Thu, 24 May 2001 00:31:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loopback, unable to release
Message-ID: <20010524003146.C12470@suse.de>
In-Reply-To: <3B0BD750.4010306@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0BD750.4010306@lycosmail.com>; from ajschrotenboer@lycosmail.com on Wed, May 23, 2001 at 11:29:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23 2001, Adam Schrotenboer wrote:
> Using 2.4.4-ac3 (as well as in 2.4.3*) I have found it impossible to 
> unmap a loopback
> 
> strace losetup -d /dev/loop0 (relevant portion)
> 
> open("/dev/loop0", O_RDONLY)            = 3
> ioctl(3, LOOP_CLR_FD, 0)                = -1 EBUSY (Device or resource busy)
> open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
> ENOENT (No such file or directory)
> open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT 
> (No such file or directory)
> write(2, "ioctl: LOOP_CLR_FD: Device or re"..., 44ioctl: LOOP_CLR_FD: 
> Device or resource busy) = 44
> _exit(1)                                = ?
> 
> also I have loop.o as module, and use count never decreases, in fact 
> right now it is at 294.

Uhm weird. Are you talking about module use count or loop reference
count?

-- 
Jens Axboe

