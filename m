Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTE2RRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTE2RRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:17:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30929 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262457AbTE2RRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:17:09 -0400
Date: Thu, 29 May 2003 19:30:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readcd with 2.5 kernels and ide-cd
Message-ID: <20030529173014.GR845@suse.de>
References: <87r86hk8hi.fsf@gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r86hk8hi.fsf@gitteundmarkus.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29 2003, Markus Plail wrote:
> Hi there!
> 
> Is there work going on to get readcd working with 2.5 kernels and
> ide-cd (without ide-scsi)?
> 
> regards
> Markus
> 
> 
> That's what i get:
> 
> [18:41:23]-[Thu May 29]-[~]
> [plail@plailis_lfs]strace readcd dev=/dev/dvd f=/dev/null     
> execve("/opt/schily/bin/readcd", ["readcd", "dev=/dev/dvd", "f=/dev/null"], [/* 52 vars */]) = 0
> brk(0)                                  = 0x806a000
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=66034, ...}) = 0
> old_mmap(NULL, 66034, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\10\332"..., 1024) = 1024
> fstat64(3, {st_mode=S_IFREG|0755, st_size=5021367, ...}) = 0
> old_mmap(NULL, 1215588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40028000
> mprotect(0x40146000, 44132, PROT_NONE)  = 0
> old_mmap(0x40146000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11d000) = 0x40146000
> old_mmap(0x4014d000, 15460, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014d000
> close(3)                                = 0
> munmap(0x40017000, 66034)               = 0
> brk(0)                                  = 0x806a000
> brk(0x806a0a8)                          = 0x806a0a8
> brk(0x806b000)                          = 0x806b000
> brk(0x806d000)                          = 0x806d000
> open("/dev/dvd", O_RDWR|O_NONBLOCK)     = 3
> fcntl64(3, F_GETFL)                     = 0x8802 (flags O_RDWR|O_NONBLOCK|O_LARGEFILE)
> fcntl64(3, F_SETFL, O_RDWR|O_LARGEFILE) = 0
> ioctl(3, 0x5382, 0xbffff174)            = 0
> ..
> ...[snip].....
> ..
> gettimeofday({1054226509, 647460}, NULL) = 0
> ioctl(3, 0x2285, 0xbfffeecc)            = 0
> gettimeofday({1054226509, 648266}, NULL) = 0
> gettimeofday({1054226509, 648420}, NULL) = 0
> ioctl(3, 0x2285, 0xbfffed4c)            = 0
> gettimeofday({1054226509, 650263}, NULL) = 0
> gettimeofday({1054226509, 650414}, NULL) = 0
> ioctl(3, 0x2285, 0xbfffeffc)            = 0
> gettimeofday({1054226509, 651217}, NULL) = 0
> gettimeofday({1054226509, 651359}, NULL) = 0
> ioctl(3, 0x2285, 0xbfffee9c)            = 0
> gettimeofday({1054226509, 653212}, NULL) = 0
> write(2, "Read  speed:  8467 kB/s (CD  48x"..., 44Read  speed:  8467 kB/s (CD  48x, DVD  6x).
> ) = 44
> write(2, "Write speed:     0 kB/s (CD   0x"..., 44Write speed:     0 kB/s (CD   0x, DVD  0x).
> ) = 44
> rt_sigaction(SIGINT, {0x8049d48, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGTERM, {0x8049d48, [TERM], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
> gettimeofday({1054226509, 660589}, NULL) = 0
> ioctl(3, 0x2285, 0xbffff29c)            = 0
> gettimeofday({1054226509, 661587}, NULL) = 0
> gettimeofday({1054226509, 661733}, NULL) = 0
> ioctl(3, 0x2285, 0xbffff26c)            = 0
> gettimeofday({1054226509, 662943}, NULL) = 0
> write(2, "Capacity: 2246704 Blocks = 44934"..., 68Capacity: 2246704 Blocks = 4493408 kBytes = 4388 MBytes = 4601 prMB
> ) = 68
> write(2, "Sectorsize: 2048 Bytes\n", 23Sectorsize: 2048 Bytes
> ) = 23
> gettimeofday({1054226509, 663619}, NULL) = 0
> ioctl(3, 0x2285, 0xbfffefec)            = 0
> gettimeofday({1054226509, 664867}, NULL) = 0
> write(2, "Copy from SCSI (0,0,0) disk to f"..., 48Copy from SCSI (0,0,0) disk to file '/dev/null'
> ) = 48
> open("/dev/null", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 4
> fcntl64(4, F_GETFL)                     = 0x8001 (flags O_WRONLY|O_LARGEFILE)
> fstat64(4, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
> ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbfffedd8) = -1 ENOTTY (Inappropriate ioctl for device)
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
> _llseek(4, 0, [0], SEEK_CUR)            = 0
> munmap(0x40017000, 4096)                = 0
> write(2, "end:   2246704\n", 15end:   2246704
> )        = 15
> gettimeofday({1054226509, 666723}, NULL) = 0
> ) = 242, "addr:        0 cnt: 128\r", 24addr:        0 cnt: 128
> gettimeofday({1054226509, 667029}, NULL) = 0
> ioctl(3, 0x2285, 0xbfffef9c)            = -1 ENOTTY (Inappropriate ioctl for device)
> write(3, ".\0\0\0$\0\4\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 46) = -1 EPERM (Operation not permitted)
> ioctl(3, 0x2201, 0xbfff6ee8)            = 0
> gettimeofday({1054226509, 667663}, NULL) = 0
> write(2, "readcd: Operation not permitted."..., 64readcd: Operation not permitted. Cannot send SCSI cmd via ioctl
> ) = 64
> _exit(1)                                = ?
> [18:41:49]-[Thu May 29]-[~]
> [plail@plailis_lfs]

Something _very_ fishy is going on there. 0x2285 is the SG_IO ioctl.
First call to it completes, second one returns -ENOTTY. Looks very much
like some kernel bug, see the SNDCTL_TMR_TIMEBASE ioctl returning
-ENOTTY in-between.

I've seen this before (this very bug), but haven't chased it down.

-- 
Jens Axboe

