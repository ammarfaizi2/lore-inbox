Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbRGMV2L>; Fri, 13 Jul 2001 17:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbRGMV2B>; Fri, 13 Jul 2001 17:28:01 -0400
Received: from gruel.uchicago.edu ([128.135.39.156]:19471 "EHLO
	gruel.uchicago.edu") by vger.kernel.org with ESMTP
	id <S267544AbRGMV1s>; Fri, 13 Jul 2001 17:27:48 -0400
Date: Fri, 13 Jul 2001 16:24:45 -0500 (CDT)
From: Gary Lyons <lyons@gruel.uchicago.edu>
Reply-To: <lyons@pobox.com>
To: Chris Wedgwood <cw@f00f.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ioctl bug?
In-Reply-To: <20010714091249.D5737@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107131621130.12456-100000@gruel.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2001, Chris Wedgwood wrote:

> On Sat, Jul 14, 2001 at 09:09:05AM +1200, Chris Wedgwood wrote:
>
>     strace -fblah lsattr some-dir/
>
>     (where some-dir is empty)
>
> actually, make sure at least one file is in there

Ok here it is but I should mention that Aan Cox just sent me an
email saying he already has a patch for this.

Thanks
Gary
-- 
"UNIX *is* user-friendly....  It's just picky about who it's friends
with!"
                --anonymous

-------output of strace -oblah lsattr ttt/-------------


execve("/usr/bin/lsattr", ["lsattr", "ttt/"], [/* 40 vars */]) = 0
uname({sys="Linux", node="raptor.umaryland.edu", ...}) = 0
brk(0)                                  = 0x8049180
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=93618, ...}) = 0
old_mmap(NULL, 93618, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
open("/lib/libext2fs.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p8\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=86714, ...}) = 0
old_mmap(NULL, 73824, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002f000
mprotect(0x40040000, 4192, PROT_NONE)   = 0
old_mmap(0x40040000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0x40040000
close(3)                                = 0
open("/lib/libe2p.so.2", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\17"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=18313, ...}) = 0
old_mmap(NULL, 16800, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40042000
mprotect(0x40045000, 4512, PROT_NONE)   = 0
old_mmap(0x40045000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x40045000
old_mmap(0x40046000, 416, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40046000
close(3)                                = 0
open("/lib/libcom_err.so.2", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\t\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=8196, ...}) = 0
old_mmap(NULL, 8368, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40047000
mprotect(0x40048000, 4272, PROT_NONE)   = 0
old_mmap(0x40048000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x40048000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\302"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5634864, ...}) = 0
old_mmap(NULL, 1242920, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4004a000
mprotect(0x40170000, 38696, PROT_NONE)  = 0
old_mmap(0x40170000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x125000) = 0x40170000
old_mmap(0x40176000, 14120, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40176000
close(3)                                = 0
munmap(0x40018000, 93618)               = 0
getpid()                                = 2501
lstat64("ttt/", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
open("ttt/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
brk(0)                                  = 0x8049180
brk(0x804a1c8)                          = 0x804a1c8
brk(0x804b000)                          = 0x804b000
getdents64(3, /* 3 entries */, 4096)    = 80
lstat64("ttt//.", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
lstat64("ttt//..", {st_mode=S_IFDIR|0700, st_size=20480, ...}) = 0
lstat64("ttt//qwerty", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
open("ttt//qwerty", O_RDONLY|O_NONBLOCK) = 4
ioctl(4, EXT2_IOC_GETFLAGS, 0xbffff5c8) = 0
close(4)                                = 0
open("ttt//qwerty", O_RDONLY|O_NONBLOCK) = 4
ioctl(4, EXT2_IOC_GETVERSION, 0xbffff5c8) = 0
close(4)                                = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, "------------ ttt//qwerty\n", 25) = 25
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
_exit(0)                                = ?




