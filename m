Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271041AbTHQVRC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271043AbTHQVRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:17:01 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:10004 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S271041AbTHQVQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:16:44 -0400
Subject: Re: Can't run Quake 3 on 2.6.0-test3-mm2
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0308171528110.32300@montezuma.mastecende.com>
References: <1061142481.14239.7.camel@iso-8590-lx.zeusinc.com>
	 <Pine.LNX.4.53.0308171528110.32300@montezuma.mastecende.com>
Content-Type: text/plain
Message-Id: <1061154986.1775.2.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 17:16:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-17 at 15:28, Zwane Mwaikambo wrote:
> On Sun, 17 Aug 2003, Tom Sightler wrote:
> 
> > I've recently upgraded to 2.6.0-test3-mm2 and part of my normal testing
> > involves a quick run of q3demo.  Under this kernel the system segfaults
> > when attempting to run this program.  Running strace I was able to
> > determine that this fails when it attempts to open the pak0.pk3 as
> > readonly.  Booting back to 2.6.0-test2-mm1 and the same program
> > continues to work perfectly.
> > 
> > Any ideas what might be going on here?  I haven't found any other
> > applications that exhibit such strange behavior but I'm still testing.
> 
> You may want to send over the entire strace log so that more people can 
> have a look.

OK, it's not very long so I've just attached it here.  Thanks for any
help.

Later,
Tom

[q3demo]$ strace ./q3demo

execve("./q3demo", ["./q3demo"], [/* 33 vars */]) = 0
uname({sys="Linux", node="iso-8590-lx", ...}) = 0
brk(0)                                  = 0x8421000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/lib/libNoVersion.so.1", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=7400, ...}) = 0
close(3)                                = 0
open("/lib/libNoVersion.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\10"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=7400, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40016000
old_mmap(NULL, 7216, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40017000
old_mmap(0x40018000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0) = 0x40018000
close(3)                                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=93339, ...}) = 0
old_mmap(NULL, 93339, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40019000
close(3)                                = 0
open("/usr/X11R6/lib/libX11.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\23"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=907216, ...}) = 0
old_mmap(NULL, 911512, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40030000
old_mmap(0x4010c000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0xdb000) = 0x4010c000
close(3)                                = 0
open("/usr/X11R6/lib/libXext.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000)\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=53360, ...}) = 0
old_mmap(NULL, 56724, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x4010f000
old_mmap(0x4011c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0xc000) = 0x4011c000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\30"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=15720, ...}) = 0
old_mmap(NULL, 13092, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x4011d000
old_mmap(0x40120000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x2000) = 0x40120000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0005\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=210388, ...}) = 0
old_mmap(NULL, 137648, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40121000
old_mmap(0x40142000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x20000) = 0x40142000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200[\1"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1552852, ...}) = 0
old_mmap(NULL, 1279588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40143000
old_mmap(0x40276000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x133000) = 0x40276000
old_mmap(0x40279000, 9828, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40279000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x4027c000
munmap(0x40019000, 93339)               = 0
geteuid32()                             = 500
getuid32()                              = 500
setresuid32(0xffffffff, 0x1f4, 0xffffffff) = 0
brk(0)                                  = 0x8421000
brk(0x8442000)                          = 0x8442000
write(2, "Q3 1.11 linux-i386 Dec  4 1999\n", 31Q3 1.11 linux-i386 Dec  4
1999
) = 31
old_mmap(NULL, 10489856, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4027d000
old_mmap(NULL, 58724352, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40c7e000
write(2, "----- FS_Startup -----\n", 23----- FS_Startup -----
) = 23
mkdir("/home/tsightler/.q3a", 0777)     = 0
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a
directory)
open("./baseq3", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1
ENOENT (No such file or directory)
open("/home/tsightler/.q3a/baseq3",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOENT (No such file
or directory)
write(2, "Current search path:\n", 21Current search path:
)  = 21
write(2, "/home/tsightler/.q3a/baseq3\n", 28/home/tsightler/.q3a/baseq3
) = 28
write(2, "./baseq3\n", 9./baseq3
)               = 9
write(2, "\n", 1
)                       = 1
write(2, "----------------------\n", 23----------------------
) = 23
write(2, "\nRunning in restricted demo mode"..., 35
Running in restricted demo mode.

) = 35
write(2, "----- FS_Startup -----\n", 23----- FS_Startup -----
) = 23
mkdir("/home/tsightler/.q3a", 0777)     = -1 EEXIST (File exists)
open("./demoq3", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 3 entries */, 4096)    = 80
stat64("./demoq3/.", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("./demoq3/..", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("./demoq3/pak0.pk3", {st_mode=S_IFREG|0644, st_size=46853694,
...}) = 0
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
open("./demoq3/pak0.pk3", O_RDONLY)     = 3
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++



