Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131085AbRCGOEd>; Wed, 7 Mar 2001 09:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131086AbRCGOEY>; Wed, 7 Mar 2001 09:04:24 -0500
Received: from infis-gw.ts.infn.it ([140.105.7.230]:17420 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id <S131085AbRCGOEQ> convert rfc822-to-8bit; Wed, 7 Mar 2001 09:04:16 -0500
Date: Wed, 7 Mar 2001 15:03:36 +0100 (CET)
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2 command execution hangs and then succeded after 2
  minutes....!? STRACE-DUMP
In-Reply-To: <3AA6356F.EC2AB4FA@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10103071458560.9169-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Manfred Spraul wrote:

> Could you use strace and check what the apps are doing during these 2
> minutes?
> 
> Perhaps it's a variation of the nis hang:
> 2.4 doesn't forword udp error messages to the user space app, and thus a
> nis query to a nonexistant nis server blocks until the udp packets time
> out.
> 

Here are the three traces (mc,pine,tar)
The system hangs for minutes in the last part, before the interrupt
Sorry for the size of this email...:) 

execve("/usr/bin/mc", ["mc"], [/* 24 vars */]) = 0
brk(0)                                  = 0x80b2a0c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_dev=makedev(3, 6), st_ino=18436, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=3807, st_atime=2001/03/03-01:53:49, st_mtime=2001/03/03-01:53:20, st_ctime=2001/03/03-01:53:20}) = 0
old_mmap(NULL, 3807, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4000b000
close(4)                                = 0
open("/lib/libcrypt.so.1", O_RDONLY)    = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4000c000
munmap(0x4000c000, 4096)                = 0
old_mmap(NULL, 181644, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4000c000
mprotect(0x40011000, 161164, PROT_NONE) = 0
old_mmap(0x40011000, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x4000) = 0x40011000
old_mmap(0x40032000, 25996, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40032000
close(4)                                = 0
open("/lib/libtermcap.so.2", O_RDONLY)  = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40039000
munmap(0x40039000, 4096)                = 0
old_mmap(NULL, 12000, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40039000
mprotect(0x4003b000, 3808, PROT_NONE)   = 0
old_mmap(0x4003b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x1000) = 0x4003b000
close(4)                                = 0
open("/usr/lib/libgpm.so.1", O_RDONLY)  = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4003c000
munmap(0x4003c000, 4096)                = 0
old_mmap(NULL, 16280, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4003c000
mprotect(0x4003f000, 3992, PROT_NONE)   = 0
old_mmap(0x4003f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x2000) = 0x4003f000
close(4)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40040000
munmap(0x40040000, 4096)                = 0
old_mmap(NULL, 9256, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40040000
mprotect(0x40042000, 1064, PROT_NONE)   = 0
old_mmap(0x40042000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x1000) = 0x40042000
close(4)                                = 0
open("/usr/lib/libslang.so.0", O_RDONLY) = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40043000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40044000
munmap(0x40043000, 4096)                = 0
old_mmap(NULL, 293800, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40045000
mprotect(0x40064000, 166824, PROT_NONE) = 0
old_mmap(0x40064000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x1e000) = 0x40064000
old_mmap(0x40068000, 150440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40068000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40043000
munmap(0x40043000, 4096)                = 0
old_mmap(NULL, 667860, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4008d000
mprotect(0x4011d000, 78036, PROT_NONE)  = 0
old_mmap(0x4011d000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x8f000) = 0x4011d000
old_mmap(0x40125000, 45268, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40125000
close(4)                                = 0
open("/lib/libcurses.so.1", O_RDONLY)   = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40043000
munmap(0x40043000, 4096)                = 0
old_mmap(NULL, 53020, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40131000
mprotect(0x4013b000, 12060, PROT_NONE)  = 0
old_mmap(0x4013b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x9000) = 0x4013b000
old_mmap(0x4013d000, 3868, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4013d000
close(4)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40043000
munmap(0x40043000, 4096)                = 0
old_mmap(NULL, 100360, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4013e000
mprotect(0x40156000, 2056, PROT_NONE)   = 0
old_mmap(0x40156000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x17000) = 0x40156000
close(4)                                = 0
mprotect(0x4013e000, 98304, PROT_READ|PROT_WRITE) = 0
mprotect(0x4013e000, 98304, PROT_READ|PROT_EXEC) = 0
mprotect(0x40131000, 40960, PROT_READ|PROT_WRITE) = 0
mprotect(0x40131000, 40960, PROT_READ|PROT_EXEC) = 0
mprotect(0x4008d000, 589824, PROT_READ|PROT_WRITE) = 0
mprotect(0x4008d000, 589824, PROT_READ|PROT_EXEC) = 0
mprotect(0x4000c000, 20480, PROT_READ|PROT_WRITE) = 0
mprotect(0x4000c000, 20480, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
getpid()                                = 112
getuid()                                = 0
setuid(0)                               = 0
time(NULL)                              = 983584429
brk(0)                                  = 0x80b2a0c
brk(0x80b2a34)                          = 0x80b2a34
brk(0x80b3000)                          = 0x80b3000
open("/etc/localtime", O_RDONLY)        = -1 ENOENT (No such file or directory)
sigaction(SIGPIPE, {0x808c330, [], 0}, NULL, 0x3) = 0
open("/usr/lib/mc/extfs/extfs.ini", O_RDONLY) = 4
fstat(4, {st_dev=makedev(3, 6), st_ino=272390, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=192, st_atime=2001/03/07-11:36:05, st_mtime=1997/11/01-17:47:10, st_ctime=2000/12/08-05:55:42}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40043000
read(4, "\n[extfs]\nzip=.zip .ZIP\nzoo=.zoo\n"..., 4096) = 192
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40043000, 4096)                = 0
brk(0x80b4000)                          = 0x80b4000
lstat(".", {st_dev=makedev(3, 6), st_ino=159856, st_mode=S_IFDIR|0755, st_nlink=7, st_uid=3532, st_gid=800, st_blksize=4096, st_blocks=4, st_size=2048, st_atime=2001/03/03-01:53:40, st_mtime=2001/03/07-14:48:23, st_ctime=2001/03/07-14:48:23}) = 0
lstat("/", {st_dev=makedev(3, 6), st_ino=2, st_mode=S_IFDIR|0755, st_nlink=17, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=1024, st_atime=2001/03/03-01:53:27, st_mtime=2001/02/28-12:52:21, st_ctime=2001/02/28-12:52:21}) = 0
lstat("..", {st_dev=makedev(3, 6), st_ino=256003, st_mode=S_IFDIR|0755, st_nlink=7, st_uid=716, st_gid=10, st_blksize=4096, st_blocks=6, st_size=3072, st_atime=2001/03/03-01:53:37, st_mtime=2001/03/03-01:53:49, st_ctime=2001/03/03-01:53:49}) = 0
open("..", O_RDONLY|O_NONBLOCK)         = 4
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat(4, {st_dev=makedev(3, 6), st_ino=256003, st_mode=S_IFDIR|0755, st_nlink=7, st_uid=716, st_gid=10, st_blksize=4096, st_blocks=6, st_size=3072, st_atime=2001/03/03-01:53:37, st_mtime=2001/03/03-01:53:49, st_ctime=2001/03/03-01:53:49}) = 0
brk(0x80b6000)                          = 0x80b6000
lseek(4, 0, SEEK_CUR)                   = 0
getdents(4, {{d_ino=256003, d_off=12, d_reclen=12, d_name="."} {d_ino=129025, d_off=24, d_reclen=16, d_name=".."} {d_ino=274435, d_off=40, d_reclen=20, d_name="backup"} {d_ino=28712, d_off=52, d_reclen=16, d_name="copy"} {d_ino=296964, d_off=68, d_reclen=16, d_name="trash"} {d_ino=256060, d_off=96, d_reclen=28, d_name="strace-4.2.tar.gz"} {d_ino=159856, d_off=116, d_reclen=24, d_name="strace-4.2"} {d_ino=256073, d_off=156, d_reclen=20, d_name="trace-mc"} {d_ino=86136, d_off=1024, d_reclen=20, d_name="compile"}}, 3933) = 172
lstat("../strace-4.2", {st_dev=makedev(3, 6), st_ino=159856, st_mode=S_IFDIR|0755, st_nlink=7, st_uid=3532, st_gid=800, st_blksize=4096, st_blocks=4, st_size=2048, st_atime=2001/03/03-01:53:40, st_mtime=2001/03/07-14:48:23, st_ctime=2001/03/07-14:48:23}) = 0
close(4)                                = 0
lstat("../..", {st_dev=makedev(3, 6), st_ino=129025, st_mode=S_IFDIR|0755, st_nlink=14, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=1024, st_atime=2001/03/03-01:53:44, st_mtime=2001/02/28-11:28:17, st_ctime=2001/02/28-11:28:17}) = 0
open("../..", O_RDONLY|O_NONBLOCK)      = 4
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat(4, {st_dev=makedev(3, 6), st_ino=129025, st_mode=S_IFDIR|0755, st_nlink=14, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=1024, st_atime=2001/03/03-01:53:44, st_mtime=2001/02/28-11:28:17, st_ctime=2001/02/28-11:28:17}) = 0
lseek(4, 0, SEEK_CUR)                   = 0
getdents(4, {{d_ino=129025, d_off=12, d_reclen=12, d_name="."} {d_ino=2, d_off=24, d_reclen=16, d_name=".."} {d_ino=131073, d_off=36, d_reclen=16, d_name="bin"} {d_ino=137217, d_off=48, d_reclen=16, d_name="lib"} {d_ino=190466, d_off=60, d_reclen=16, d_name="sbin"} {d_ino=129029, d_off=72, d_reclen=16, d_name="adm"} {d_ino=194562, d_off=84, d_reclen=16, d_name="doc"} {d_ino=235522, d_off=96, d_reclen=16, d_name="man"} {d_ino=256002, d_off=112, d_reclen=16, d_name="local"} {d_ino=256003, d_off=124, d_reclen=16, d_name="temp"} {d_ino=296963, d_off=140, d_reclen=20, d_name="libexec"} {d_ino=307203, d_off=156, d_reclen=16, d_name="share"} {d_ino=30726, d_off=168, d_reclen=16, d_name="src"} {d_ino=81927, d_off=184, d_reclen=20, d_name="include"} {d_ino=69639, d_off=1024, d_reclen=16, d_name="etc"}}, 3933) = 244
lstat("../../temp", {st_dev=makedev(3, 6), st_ino=256003, st_mode=S_IFDIR|0755, st_nlink=7, st_uid=716, st_gid=10, st_blksize=4096, st_blocks=6, st_size=3072, st_atime=2001/03/03-01:53:49, st_mtime=2001/03/03-01:53:49, st_ctime=2001/03/03-01:53:49}) = 0
close(4)                                = 0
lstat("../../..", {st_dev=makedev(3, 6), st_ino=2, st_mode=S_IFDIR|0755, st_nlink=17, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=1024, st_atime=2001/03/03-01:53:27, st_mtime=2001/02/28-12:52:21, st_ctime=2001/02/28-12:52:21}) = 0
open("../../..", O_RDONLY|O_NONBLOCK)   = 4
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat(4, {st_dev=makedev(3, 6), st_ino=2, st_mode=S_IFDIR|0755, st_nlink=17, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=1024, st_atime=2001/03/03-01:53:27, st_mtime=2001/02/28-12:52:21, st_ctime=2001/02/28-12:52:21}) = 0
lseek(4, 0, SEEK_CUR)                   = 0
getdents(4, {{d_ino=2, d_off=12, d_reclen=12, d_name="."} {d_ino=2, d_off=36, d_reclen=16, d_name=".."} {d_ino=4097, d_off=48, d_reclen=16, d_name="bin"} {d_ino=6145, d_off=60, d_reclen=16, d_name="boot"} {d_ino=14337, d_off=76, d_reclen=16, d_name="cdrom"} {d_ino=16385, d_off=88, d_reclen=16, d_name="dev"} {d_ino=18433, d_off=100, d_reclen=16, d_name="etc"} {d_ino=69633, d_off=116, d_reclen=20, d_name="floppy"} {d_ino=71681, d_off=128, d_reclen=16, d_name="home"} {d_ino=94209, d_off=140, d_reclen=16, d_name="lib"} {d_ino=112641, d_off=152, d_reclen=16, d_name="mnt"} {d_ino=114689, d_off=164, d_reclen=16, d_name="proc"} {d_ino=11, d_off=180, d_reclen=16, d_name="qzone"} {d_ino=116737, d_off=192, d_reclen=16, d_name="root"} {d_ino=124929, d_off=204, d_reclen=16, d_name="sbin"} {d_ino=126977, d_off=216, d_reclen=16, d_name="seti"} {d_ino=12, d_off=228, d_reclen=16, d_name="tmp"} {d_ino=129025, d_off=240, d_reclen=16, d_name="usr"} {d_ino=114700, d_off=1024, d_reclen=16, d_name="var"}}, 3933) = 304
lstat("../../../usr", {st_dev=makedev(3, 6), st_ino=129025, st_mode=S_IFDIR|0755, st_nlink=14, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=1024, st_atime=2001/03/03-01:53:49, st_mtime=2001/02/28-11:28:17, st_ctime=2001/02/28-11:28:17}) = 0
close(4)                                = 0
getuid()                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 4
fstat(4, {st_dev=makedev(3, 6), st_ino=18472, st_mode=S_IFREG|0600, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=4, st_size=1208, st_atime=2001/03/03-01:53:27, st_mtime=1998/01/18-23:49:20, st_ctime=2000/12/08-05:54:58}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40043000
read(4, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1208
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40043000, 4096)                = 0
open("/lib/libnss_files.so.1", O_RDONLY) = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40043000
munmap(0x40043000, 4096)                = 0
old_mmap(NULL, 31880, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40157000
mprotect(0x4015e000, 3208, PROT_NONE)   = 0
old_mmap(0x4015e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x6000) = 0x4015e000
close(4)                                = 0
mprotect(0x40157000, 28672, PROT_READ|PROT_WRITE) = 0
mprotect(0x40157000, 28672, PROT_READ|PROT_EXEC) = 0
open("/etc/passwd", O_RDONLY)           = 4
fcntl(4, F_GETFD)                       = 0
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat(4, {st_dev=makedev(3, 6), st_ino=18521, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=612, st_atime=2001/03/03-01:53:27, st_mtime=2001/02/06-17:34:59, st_ctime=2001/02/06-17:34:59}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40043000
read(4, "halt:x:7:0:halt:/sbin:/sbin/halt"..., 4096) = 612
close(4)                                = 0
munmap(0x40043000, 4096)                = 0
open("/etc/group", O_RDONLY)            = 4
fcntl(4, F_GETFD)                       = 0
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat(4, {st_dev=makedev(3, 6), st_ino=18443, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=289, st_atime=2001/03/03-01:53:27, st_mtime=1999/04/16-18:54:58, st_ctime=2000/12/08-05:54:57}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40043000
lseek(4, 0, SEEK_CUR)                   = 0
read(4, "root::0:root\nbin::1:root,bin,dae"..., 4096) = 289
read(4, "", 4096)                       = 0
open("/lib/libnss_nisplus.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libnss_nisplus.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libnss_nis.so.1", O_RDONLY)  = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x4015f000
munmap(0x4015f000, 4096)                = 0
old_mmap(NULL, 33040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x4015f000
mprotect(0x40166000, 4368, PROT_NONE)   = 0
old_mmap(0x40166000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x6000) = 0x40166000
close(5)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x40168000
munmap(0x40168000, 4096)                = 0
old_mmap(NULL, 21576, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x40168000
mprotect(0x4016c000, 5192, PROT_NONE)   = 0
old_mmap(0x4016c000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x3000) = 0x4016c000
close(5)                                = 0
mprotect(0x40168000, 16384, PROT_READ|PROT_WRITE) = 0
mprotect(0x40168000, 16384, PROT_READ|PROT_EXEC) = 0
mprotect(0x4015f000, 28672, PROT_READ|PROT_WRITE) = 0
mprotect(0x4015f000, 28672, PROT_READ|PROT_EXEC) = 0
uname({sysname="Linux", nodename="lcars", release="2.4.2", version="#2 Mon Mar 5 19:16:35 CET 2001", machine="i586"}) = 0
gettimeofday({983584429, 480302}, NULL) = 0
getpid()                                = 112
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
getpid()                                = 112
bind(5, {sin_family=AF_INET, sin_port=htons(712), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
ioctl(5, FIONBIO, [1])                  = 0
sendto(5, ";\247\32\363\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\247\32\363\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\247\32\363\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\247\32\363\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\247\32\363\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\247\32\363\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = ? ERESTARTNOHAND (To be restarted)
--- SIGINT (Interrupt) ---
+++ killed by SIGINT +++


execve("/usr/bin/pine", ["pine"], [/* 24 vars */]) = 0
brk(0)                                  = 0x837cc9c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_dev=makedev(3, 6), st_ino=18436, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=3807, st_atime=2001/03/03-01:54:20, st_mtime=2001/03/03-01:53:20, st_ctime=2001/03/03-01:53:20}) = 0
old_mmap(NULL, 3807, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4000b000
close(4)                                = 0
open("/usr/lib/libncurses.so.4", O_RDONLY) = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4000c000
munmap(0x4000c000, 4096)                = 0
old_mmap(NULL, 252268, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4000c000
mprotect(0x4003e000, 47468, PROT_NONE)  = 0
old_mmap(0x4003e000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x31000) = 0x4003e000
old_mmap(0x40046000, 14700, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40046000
close(4)                                = 0
open("/lib/libcrypt.so.1", O_RDONLY)    = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4004a000
munmap(0x4004a000, 4096)                = 0
old_mmap(NULL, 181644, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4004a000
mprotect(0x4004f000, 161164, PROT_NONE) = 0
old_mmap(0x4004f000, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x4000) = 0x4004f000
old_mmap(0x40070000, 25996, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40070000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40077000
munmap(0x40077000, 4096)                = 0
old_mmap(NULL, 667860, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40077000
mprotect(0x40107000, 78036, PROT_NONE)  = 0
old_mmap(0x40107000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x8f000) = 0x40107000
old_mmap(0x4010f000, 45268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4010f000
close(4)                                = 0
mprotect(0x40077000, 589824, PROT_READ|PROT_WRITE) = 0
mprotect(0x40077000, 589824, PROT_READ|PROT_EXEC) = 0
mprotect(0x4004a000, 20480, PROT_READ|PROT_WRITE) = 0
mprotect(0x4004a000, 20480, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
getpid()                                = 140
brk(0)                                  = 0x837cc9c
brk(0x837ccd4)                          = 0x837ccd4
brk(0x837d000)                          = 0x837d000
alarm(0)                                = 0
brk(0x8380000)                          = 0x8380000
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
time(NULL)                              = 983584461
getpid()                                = 140
time(NULL)                              = 983584461
getuid()                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 4
fstat(4, {st_dev=makedev(3, 6), st_ino=18472, st_mode=S_IFREG|0600, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=4, st_size=1208, st_atime=2001/03/03-01:54:03, st_mtime=1998/01/18-23:49:20, st_ctime=2000/12/08-05:54:58}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4011b000
read(4, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1208
brk(0x8381000)                          = 0x8381000
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x4011b000, 4096)                = 0
open("/lib/libnss_files.so.1", O_RDONLY) = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4011b000
munmap(0x4011b000, 4096)                = 0
old_mmap(NULL, 31880, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4011b000
mprotect(0x40122000, 3208, PROT_NONE)   = 0
old_mmap(0x40122000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x6000) = 0x40122000
close(4)                                = 0
mprotect(0x4011b000, 28672, PROT_READ|PROT_WRITE) = 0
mprotect(0x4011b000, 28672, PROT_READ|PROT_EXEC) = 0
open("/etc/passwd", O_RDONLY)           = 4
fcntl(4, F_GETFD)                       = 0
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat(4, {st_dev=makedev(3, 6), st_ino=18521, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=612, st_atime=2001/03/03-01:54:06, st_mtime=2001/02/06-17:34:59, st_ctime=2001/02/06-17:34:59}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40123000
read(4, "halt:x:7:0:halt:/sbin:/sbin/halt"..., 4096) = 612
close(4)                                = 0
munmap(0x40123000, 4096)                = 0
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
ioctl(0, TCGETS, {c_iflags=0x1500, c_oflags=0x5, c_cflags=0x4bf, c_lflags=0xa3b, c_line=0, c_cc="\x03\x1c\x7f\x15\x04\x00\x01\x00\x11\x13\x1a\x00\x12\x0f\x17\x16\x00\x00\x00\xf0\xea\xff\xbf\x1b\x07\x0e\x40\x00\x00\x00\x00\xb4"}) = 0
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
alarm(0)                                = 0
access("/root/.pinercex", F_OK)         = -1 ENOENT (No such file or directory)
rename("/root/.pine-debug3", "/root/.pine-debug4") = 0
rename("/root/.pine-debug2", "/root/.pine-debug3") = 0
rename("/root/.pine-debug1", "/root/.pine-debug2") = 0
open("/root/.pine-debug1", O_RDWR|O_CREAT|O_TRUNC, 0600) = 4
fcntl(4, F_GETFL)                       = 0x2 (flags O_RDWR)
fstat(4, {st_dev=makedev(3, 6), st_ino=116748, st_mode=S_IFREG|0600, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2001/03/03-01:54:21, st_mtime=2001/03/03-01:54:21, st_ctime=2001/03/03-01:54:21}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40123000
lseek(4, 0, SEEK_CUR)                   = 0
time(NULL)                              = 983584461
open("/etc/localtime", O_RDONLY)        = -1 ENOENT (No such file or directory)
stat("/etc/cram-md5.pwd", 0xbfffea10)   = -1 ENOENT (No such file or directory)
alarm(0)                                = 0
open("/etc/c-client.cf", O_RDONLY)      = -1 ENOENT (No such file or directory)
alarm(0)                                = 0
alarm(0)                                = 0
open("/root/.mminit", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/root/.imaprc", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/etc/passwd", O_RDONLY)           = 5
fcntl(5, F_GETFD)                       = 0
fcntl(5, F_SETFD, FD_CLOEXEC)           = 0
fstat(5, {st_dev=makedev(3, 6), st_ino=18521, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=612, st_atime=2001/03/03-01:54:21, st_mtime=2001/02/06-17:34:59, st_ctime=2001/02/06-17:34:59}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40124000
read(5, "halt:x:7:0:halt:/sbin:/sbin/halt"..., 4096) = 612
close(5)                                = 0
munmap(0x40124000, 4096)                = 0
alarm(0)                                = 0
open("/etc/passwd", O_RDONLY)           = 5
fcntl(5, F_GETFD)                       = 0
fcntl(5, F_SETFD, FD_CLOEXEC)           = 0
fstat(5, {st_dev=makedev(3, 6), st_ino=18521, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=612, st_atime=2001/03/03-01:54:21, st_mtime=2001/02/06-17:34:59, st_ctime=2001/02/06-17:34:59}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40124000
read(5, "halt:x:7:0:halt:/sbin:/sbin/halt"..., 4096) = 612
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x40124000, 4096)                = 0
open("/lib/libnss_nisplus.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libnss_nisplus.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libnss_nis.so.1", O_RDONLY)  = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x40124000
munmap(0x40124000, 4096)                = 0
old_mmap(NULL, 33040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x40124000
mprotect(0x4012b000, 4368, PROT_NONE)   = 0
old_mmap(0x4012b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x6000) = 0x4012b000
close(5)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x4012d000
munmap(0x4012d000, 4096)                = 0
old_mmap(NULL, 21576, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x4012d000
mprotect(0x40131000, 5192, PROT_NONE)   = 0
old_mmap(0x40131000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x3000) = 0x40131000
close(5)                                = 0
mprotect(0x4012d000, 16384, PROT_READ|PROT_WRITE) = 0
mprotect(0x4012d000, 16384, PROT_READ|PROT_EXEC) = 0
mprotect(0x40124000, 28672, PROT_READ|PROT_WRITE) = 0
mprotect(0x40124000, 28672, PROT_READ|PROT_EXEC) = 0
uname({sysname="Linux", nodename="lcars", release="2.4.2", version="#2 Mon Mar 5 19:16:35 CET 2001", machine="i586"}) = 0
brk(0x8382000)                          = 0x8382000
gettimeofday({983584461, 251175}, NULL) = 0
getpid()                                = 140
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
getpid()                                = 140
bind(5, {sin_family=AF_INET, sin_port=htons(740), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
ioctl(5, FIONBIO, [1])                  = 0
sendto(5, ";\243\233f\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\243\233f\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\243\233f\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = ? ERESTARTNOHAND (To be restarted)
--- SIGINT (Interrupt) ---
+++ killed by SIGINT +++



execve("/bin/tar", ["tar", "-xvzf", "/usr/src/linux-2.2.18.tar.gz"], [/* 24 vars */]) = 0
brk(0)                                  = 0x80638a0
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_dev=makedev(3, 6), st_ino=18436, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=8, st_size=3807, st_atime=2001/03/03-01:54:47, st_mtime=2001/03/03-01:53:20, st_ctime=2001/03/03-01:53:20}) = 0
old_mmap(NULL, 3807, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4000b000
close(4)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 4
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4000c000
munmap(0x4000c000, 4096)                = 0
old_mmap(NULL, 667860, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4000c000
mprotect(0x4009c000, 78036, PROT_NONE)  = 0
old_mmap(0x4009c000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x8f000) = 0x4009c000
old_mmap(0x400a4000, 45268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400a4000
close(4)                                = 0
mprotect(0x4000c000, 589824, PROT_READ|PROT_WRITE) = 0
mprotect(0x4000c000, 589824, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
getpid()                                = 153
brk(0)                                  = 0x80638a0
brk(0x80638d8)                          = 0x80638d8
brk(0x8064000)                          = 0x8064000
sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 0x400375d0) = 0
time(NULL)                              = 983584487
geteuid()                               = 0
umask(0)                                = 022
umask(022)                              = 0
brk(0x8066000)                          = 0x8066000
brk(0x8069000)                          = 0x8069000
pipe([4, 5])                            = 0
fork()                                  = 154
close(5)                                = 0
fstat(4, {st_dev=makedev(0, 0), st_ino=159, st_mode=S_IFIFO|0600, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=0, st_size=0, st_atime=2001/03/03-01:54:47, st_mtime=2001/03/03-01:54:47, st_ctime=2001/03/03-01:54:47}) = 0
stat("/dev/null", {st_dev=makedev(3, 6), st_ino=16490, st_mode=S_IFCHR|0666, st_nlink=1, st_uid=0, st_gid=3, st_blksize=4096, st_blocks=0, st_rdev=makedev(1, 3), st_atime=2000/12/08-05:54:56, st_mtime=2000/12/08-05:54:56, st_ctime=2000/12/08-05:54:56}) = 0
read(4, "linux/\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 10240) = 10240
open("/etc/nsswitch.conf", O_RDONLY)    = 5
fstat(5, {st_dev=makedev(3, 6), st_ino=18472, st_mode=S_IFREG|0600, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=4, st_size=1208, st_atime=2001/03/03-01:54:21, st_mtime=1998/01/18-23:49:20, st_ctime=2000/12/08-05:54:58}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400b0000
read(5, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1208
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x400b0000, 4096)                = 0
open("/lib/libnss_files.so.1", O_RDONLY) = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x400b0000
munmap(0x400b0000, 4096)                = 0
old_mmap(NULL, 31880, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x400b0000
mprotect(0x400b7000, 3208, PROT_NONE)   = 0
old_mmap(0x400b7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x6000) = 0x400b7000
close(5)                                = 0
mprotect(0x400b0000, 28672, PROT_READ|PROT_WRITE) = 0
mprotect(0x400b0000, 28672, PROT_READ|PROT_EXEC) = 0
open("/etc/passwd", O_RDONLY)           = 5
fcntl(5, F_GETFD)                       = 0
fcntl(5, F_SETFD, FD_CLOEXEC)           = 0
fstat(5, {st_dev=makedev(3, 6), st_ino=18521, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=4096, st_blocks=2, st_size=612, st_atime=2001/03/03-01:54:21, st_mtime=2001/02/06-17:34:59, st_ctime=2001/02/06-17:34:59}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400b8000
read(5, "halt:x:7:0:halt:/sbin:/sbin/halt"..., 4096) = 612
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x400b8000, 4096)                = 0
open("/lib/libnss_nisplus.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libnss_nisplus.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libnss_nis.so.1", O_RDONLY)  = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x400b8000
munmap(0x400b8000, 4096)                = 0
old_mmap(NULL, 33040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x400b8000
mprotect(0x400bf000, 4368, PROT_NONE)   = 0
old_mmap(0x400bf000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x6000) = 0x400bf000
close(5)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 5
old_mmap(NULL, 4096, PROT_READ, MAP_PRIVATE, 5, 0) = 0x400c1000
munmap(0x400c1000, 4096)                = 0
old_mmap(NULL, 21576, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x400c1000
mprotect(0x400c5000, 5192, PROT_NONE)   = 0
old_mmap(0x400c5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x3000) = 0x400c5000
close(5)                                = 0
mprotect(0x400c1000, 16384, PROT_READ|PROT_WRITE) = 0
mprotect(0x400c1000, 16384, PROT_READ|PROT_EXEC) = 0
mprotect(0x400b8000, 28672, PROT_READ|PROT_WRITE) = 0
mprotect(0x400b8000, 28672, PROT_READ|PROT_EXEC) = 0
uname({sysname="Linux", nodename="lcars", release="2.4.2", version="#2 Mon Mar 5 19:16:35 CET 2001", machine="i586"}) = 0
gettimeofday({983584487, 855312}, NULL) = 0
getpid()                                = 153
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
getpid()                                = 153
bind(5, {sin_family=AF_INET, sin_port=htons(753), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
ioctl(5, FIONBIO, [1])                  = 0
sendto(5, ";\255Cn\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\255Cn\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\255Cn\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = 0 (Timeout)
sendto(5, ";\255Cn\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3\0\0"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
select(1024, [5], NULL, NULL, {5, 0})   = ? ERESTARTNOHAND (To be restarted)
--- SIGINT (Interrupt) ---
+++ killed by SIGINT +++

