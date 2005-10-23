Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVJWLjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVJWLjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJWLjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 07:39:45 -0400
Received: from lucidpixels.com ([66.45.37.187]:43671 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750701AbVJWLjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 07:39:44 -0400
Date: Sun, 23 Oct 2005 07:39:34 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
cc: debian-user@lists.debian.org
Subject: xfs_db -c frag -r /dev/hda1 - Segmentation fault
In-Reply-To: <4080C826.F4C53CD@dmministries.org>
Message-ID: <Pine.LNX.4.64.0510230736490.30489@p34>
References: <4080C826.F4C53CD@dmministries.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

p34:~# xfs_db -c frag -r /dev/hda1
Segmentation fault
p34:~# xfs_db -c frag -r /dev/hde1
Segmentation fault
p34:~# xfs_db -c frag -r /dev/hdk1
Segmentation fault
p34:~#

Debian Etch, 2.6.13.4, stopped working a while ago, either before newer 
debian packages or a newer kernel, does anyone who uses Debian+XFS have 
this problem as well?

Towards the end of the strace:
munmap(0xb7fb6000, 4096)                = 0
open("/proc/meminfo", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0xb7fb6000
read(3, "MemTotal:      1035452 kB\nMemFre"..., 1024) = 598
close(3)                                = 0
munmap(0xb7fb6000, 4096)                = 0
rt_sigaction(SIGINT, {0x80628f4, [], 0}, NULL, 8) = 0
_llseek(4, 512, [512], SEEK_SET)        = 0
read(4, "XAGF\0\0\0\1\0\0\0\0\0:pn\0\0\0\1\0\0\0\2\0\0\0\0\0\0\0"..., 512) 
= 512
_llseek(4, 1024, [1024], SEEK_SET)      = 0
read(4, "XAGI\0\0\0\1\0\0\0\0\0:pn\0\0\3@\0\0\0\3\0\0\0\1\0\0\000"..., 
512) = 512
_llseek(4, 12288, [12288], SEEK_SET)    = 0
read(4, "IABT\0\0\0\r\377\377\377\377\377\377\377\377\0\0\0\200"..., 4096) 
= 4096
_llseek(4, 32768, [32768], SEEK_SET)    = 0
read(4, "INA\355\1\1\0\3\0\0\0\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0\0\0"..., 
16384) = 16384
mmap2(NULL, 268443648, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xa7df7000
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
p34:~#

Is this a kernel, XFS or Debian problem?

Thanks!

Justin.
