Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316232AbSFJCzK>; Sun, 9 Jun 2002 22:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSFJCzJ>; Sun, 9 Jun 2002 22:55:09 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:53695 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S316232AbSFJCzA>; Sun, 9 Jun 2002 22:55:00 -0400
Date: Sun, 09 Jun 2002 23:00:08 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: rpm --rebuild fails on 2.5.20
To: Dave Jones <davej@suse.de>, linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D041638.4030101@hotmail.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_yLborKId603phi6RRTkhkA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
In-Reply-To: <linux.kernel.20020608215520.D13140@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_yLborKId603phi6RRTkhkA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Sorry, I decided to try it on 2.5.21 first. But I can't even get i to 
compile. So...

Here are two attachments. Both are the output of "strace rpm -q strace". 
  The first is from 2.5.20, the second from 2.4.18 ( which works ).

I'm nothing close to a hacker, but tell me if anything else would be 
helpful.

jay

Dave Jones wrote:
> On Sat, Jun 08, 2002 at 02:15:10PM -0400, jay wrote:
>  > When I try to use rpm to rebuild a src.rpm, it gives a Segmentation 
>  > fault on 2.5.20. Works on 2.5.18 and 2.4.18.
>  > 
>  > rpm -vvvvvv --rebuild ORBit2*
>  > Segmentation fault
>  > Some small src.rpm files work, e.g. filesystem-2.1.6-4.src.rpm, but not all.
> 
> can you strace an operation that fails, and find out where it's
> segfaulting.  Also, check dmesg for a kernel oops, and decode
> with kysmoops if present.
> 
> I've one other report of a problem with capabilities, which
> might be related.
> 
>         Dave 
> 



--Boundary_(ID_yLborKId603phi6RRTkhkA)
Content-type: text/plain; name=strace.out
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=strace.out

execve("/bin/rpm", ["rpm", "-q", "stace"], [/* 31 vars */]) = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
uname({sys="Linux", node="daddy", ...}) = 0
geteuid32()                             = 0
getuid32()                              = 0
getegid32()                             = 0
getgid32()                              = 0
getrlimit(0x3, 0xbffff568)              = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 1580
rt_sigaction(SIGRTMIN, {0x812de80, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x812dd9c, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x812deec, [], 0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff330, 30, (nil), 0}) = 0
brk(0)                                  = 0x8215550
brk(0x8215580)                          = 0x8215580
brk(0x8216000)                          = 0x8216000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40000000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
brk(0x8217000)                          = 0x8217000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40000000, 4096)                = 0
open("/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=371, ...}) = 0
old_mmap(NULL, 371, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40000000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20666, ...}) = 0
old_mmap(NULL, 20666, PROT_READ, MAP_SHARED, 3, 0) = 0x40001000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MEASUREMENT", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=29, ...}) = 0
old_mmap(NULL, 29, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40007000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TELEPHONE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
old_mmap(NULL, 65, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40008000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_ADDRESS", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
old_mmap(NULL, 161, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40009000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NAME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=83, ...}) = 0
old_mmap(NULL, 83, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000a000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_PAPER", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=40, ...}) = 0
old_mmap(NULL, 40, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000b000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=58, ...}) = 0
old_mmap(NULL, 58, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000c000
close(3)                                = 0
brk(0x8218000)                          = 0x8218000
open("/usr/lib/locale/en_US.iso885915/LC_MONETARY", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=292, ...}) = 0
old_mmap(NULL, 292, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000d000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22592, ...}) = 0
old_mmap(NULL, 22592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000e000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TIME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2457, ...}) = 0
old_mmap(NULL, 2457, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NUMERIC", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
old_mmap(NULL, 60, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=173680, ...}) = 0
old_mmap(NULL, 173680, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/usr/lib/rpm/rpmpopt-4.0.4", O_RDONLY) = 3
lseek(3, 0, SEEK_END)                   = 15353
lseek(3, 0, SEEK_SET)                   = 0
read(3, "#/*! \\page config_rpmpopt Defaul"..., 15353) = 15353
close(3)                                = 0
brk(0x8219000)                          = 0x8219000
brk(0x821a000)                          = 0x821a000
brk(0x821b000)                          = 0x821b000
open("/etc/popt", O_RDONLY)             = -1 ENOENT (No such file or directory)
getuid32()                              = 0
geteuid32()                             = 0
open("/root/.popt", O_RDONLY)           = -1 ENOENT (No such file or directory)
getpid()                                = 1580
getrlimit(0x3, 0xbffff5d8)              = 0
setrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGRTMIN, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {SIG_DFL}, NULL, 8) = 0
execve("/usr/lib/rpm/rpmq", ["/usr/lib/rpm/rpmq", "-q", "stace"], [/* 31 vars */]) = 0
uname({sys="Linux", node="daddy", ...}) = 0
brk(0)                                  = 0x804bea8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=86649, ...}) = 0
old_mmap(NULL, 86649, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/librpmbuild-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300<\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=127402, ...}) = 0
old_mmap(NULL, 195024, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002a000
mprotect(0x40045000, 84432, PROT_NONE)  = 0
old_mmap(0x40045000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1a000) = 0x40045000
old_mmap(0x40047000, 76240, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40047000
close(3)                                = 0
open("/usr/lib/librpm-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320f\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=289538, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4005a000
old_mmap(NULL, 301216, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4005b000
mprotect(0x40099000, 47264, PROT_NONE)  = 0
old_mmap(0x40099000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x3e000) = 0x40099000
old_mmap(0x4009c000, 34976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4009c000
close(3)                                = 0
open("/usr/lib/librpmdb-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20Q\1\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=2066537, ...}) = 0
old_mmap(NULL, 694732, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400a5000
mprotect(0x4014a000, 18892, PROT_NONE)  = 0
old_mmap(0x4014a000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa5000) = 0x4014a000
old_mmap(0x4014d000, 6604, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014d000
close(3)                                = 0
open("/usr/lib/librpmio-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\201"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=447647, ...}) = 0
old_mmap(NULL, 240760, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4014f000
mprotect(0x4017d000, 52344, PROT_NONE)  = 0
old_mmap(0x4017d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2e000) = 0x4017d000
old_mmap(0x40182000, 31864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40182000
close(3)                                = 0
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\30"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=60465, ...}) = 0
old_mmap(NULL, 55660, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4018a000
mprotect(0x40196000, 6508, PROT_NONE)   = 0
old_mmap(0x40196000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xb000) = 0x40196000
close(3)                                = 0
open("/usr/lib/libbz2.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\21"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=68011, ...}) = 0
old_mmap(NULL, 61012, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40198000
mprotect(0x401a6000, 3668, PROT_NONE)   = 0
old_mmap(0x401a6000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe000) = 0x401a6000
close(3)                                = 0
open("/usr/lib/libpopt.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\21\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=29376, ...}) = 0
old_mmap(NULL, 27192, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401a7000
mprotect(0x401ad000, 2616, PROT_NONE)   = 0
old_mmap(0x401ad000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x401ad000
close(3)                                = 0
open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20D\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=101902, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ae000
old_mmap(NULL, 81340, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401af000
mprotect(0x401bc000, 28092, PROT_NONE)  = 0
old_mmap(0x401bc000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x401bc000
close(3)                                = 0
open("/lib/librt.so.1", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\33\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=34206, ...}) = 0
old_mmap(NULL, 69140, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401c3000
mprotect(0x401c9000, 44564, PROT_NONE)  = 0
old_mmap(0x401c9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x6000) = 0x401c9000
old_mmap(0x401ca000, 40468, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401ca000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`u\1B4\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1401027, ...}) = 0
old_mmap(0x42000000, 1264928, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
mprotect(0x4212c000, 36128, PROT_NONE)  = 0
old_mmap(0x4212c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12c000) = 0x4212c000
old_mmap(0x42131000, 15648, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42131000
close(3)                                = 0
munmap(0x40014000, 86649)               = 0
modify_ldt(0x1, 0xbffff95c, 0x10)       = 0
getpid()                                = 1580
rt_sigaction(SIGRTMIN, {0x401b79c0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x401b6c90, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x401b7a10, [], 0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff60c, 30, (nil), 0}) = 0
brk(0)                                  = 0x804bea8
brk(0x804bed8)                          = 0x804bed8
brk(0x804c000)                          = 0x804c000
brk(0x804d000)                          = 0x804d000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=371, ...}) = 0
mmap2(NULL, 371, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20666, ...}) = 0
mmap2(NULL, 20666, PROT_READ, MAP_SHARED, 3, 0) = 0x40015000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MEASUREMENT", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=29, ...}) = 0
mmap2(NULL, 29, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001b000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TELEPHONE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
mmap2(NULL, 65, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001c000
close(3)                                = 0
brk(0x804e000)                          = 0x804e000
open("/usr/lib/locale/en_US.iso885915/LC_ADDRESS", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
mmap2(NULL, 161, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NAME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=83, ...}) = 0
mmap2(NULL, 83, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001e000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_PAPER", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=40, ...}) = 0
mmap2(NULL, 40, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001f000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=58, ...}) = 0
mmap2(NULL, 58, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40020000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MONETARY", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=292, ...}) = 0
mmap2(NULL, 292, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40021000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22592, ...}) = 0
mmap2(NULL, 22592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40022000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TIME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2457, ...}) = 0
mmap2(NULL, 2457, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40028000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NUMERIC", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
mmap2(NULL, 60, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40029000
close(3)                                = 0
brk(0x804f000)                          = 0x804f000
open("/usr/lib/locale/en_US.iso885915/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=173680, ...}) = 0
mmap2(NULL, 173680, PROT_READ, MAP_PRIVATE, 3, 0) = 0x401d4000
close(3)                                = 0
open("/usr/lib/rpm/rpmpopt-4.0.4", O_RDONLY) = 3
lseek(3, 0, SEEK_END)                   = 15353
lseek(3, 0, SEEK_SET)                   = 0
read(3, "#/*! \\page config_rpmpopt Defaul"..., 15353) = 15353
close(3)                                = 0
brk(0x8050000)                          = 0x8050000
open("/etc/popt", O_RDONLY)             = -1 ENOENT (No such file or directory)
getuid32()                              = 0
geteuid32()                             = 0
open("/root/.popt", O_RDONLY)           = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="daddy", ...}) = 0
rt_sigaction(SIGILL, {0x401b7f00, [ILL], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
open("/usr/lib/rpm/rpmrc", O_RDONLY)    = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023667040, 661500}, NULL) = 0
brk(0x8051000)                          = 0x8051000
fstat64(3, {st_mode=S_IFREG|0644, st_size=10029, ...}) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 662130}, NULL) = 0
read(3, "#/*! \\page config_rpmrc Default "..., 8192) = 8192
gettimeofday({1023667040, 662304}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 662499}, NULL) = 0
read(3, "NT MiNT TOS\nos_compat: TOS: Free"..., 8192) = 1837
gettimeofday({1023667040, 662597}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 662735}, NULL) = 0
read(3, "", 6355)                       = 0
gettimeofday({1023667040, 662813}, NULL) = 0
gettimeofday({1023667040, 662916}, NULL) = 0
close(3)                                = 0
gettimeofday({1023667040, 663015}, NULL) = 0
gettimeofday({1023667040, 663080}, NULL) = 0
gettimeofday({1023667040, 663120}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
brk(0x8052000)                          = 0x8052000
brk(0x8053000)                          = 0x8053000
brk(0x8054000)                          = 0x8054000
brk(0x8055000)                          = 0x8055000
open("/etc/rpmrc", O_RDONLY)            = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023667040, 664903}, NULL) = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=130, ...}) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 665534}, NULL) = 0
read(3, "# jfb did this + it\'s for the gc"..., 8192) = 130
gettimeofday({1023667040, 665644}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 665785}, NULL) = 0
read(3, "", 8062)                       = 0
gettimeofday({1023667040, 665863}, NULL) = 0
gettimeofday({1023667040, 665917}, NULL) = 0
close(3)                                = 0
gettimeofday({1023667040, 665994}, NULL) = 0
gettimeofday({1023667040, 666040}, NULL) = 0
gettimeofday({1023667040, 666078}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/root/.rpmrc", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/usr/lib/rpm/macros", O_RDONLY)   = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023667040, 666497}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 666803}, NULL) = 0
read(3, "#/*! \\page config_macros Default"..., 8192) = 8192
gettimeofday({1023667040, 666965}, NULL) = 0
brk(0x8056000)                          = 0x8056000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 669011}, NULL) = 0
read(3, " before rpm-3.0.5) are not suppo"..., 8192) = 8192
gettimeofday({1023667040, 669146}, NULL) = 0
brk(0x8057000)                          = 0x8057000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 670691}, NULL) = 0
read(3, "hen repackaging\n#\terased package"..., 8192) = 8192
gettimeofday({1023667040, 670820}, NULL) = 0
brk(0x8058000)                          = 0x8058000
brk(0x8059000)                          = 0x8059000
brk(0x805a000)                          = 0x805a000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 676266}, NULL) = 0
read(3, "e} \\\n#  CFLAGS=\"%{optflags}\" ./c"..., 8192) = 5912
gettimeofday({1023667040, 676391}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 676533}, NULL) = 0
read(3, "", 2280)                       = 0
gettimeofday({1023667040, 676609}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 677620}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023667040, 677702}, NULL) = 0
gettimeofday({1023667040, 677768}, NULL) = 0
close(3)                                = 0
gettimeofday({1023667040, 677848}, NULL) = 0
gettimeofday({1023667040, 677893}, NULL) = 0
gettimeofday({1023667040, 677931}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/usr/lib/rpm/i686-linux/macros", O_RDONLY) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023667040, 678184}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 678454}, NULL) = 0
read(3, "# Per-platform rpm configuration"..., 8192) = 3574
gettimeofday({1023667040, 678571}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 678713}, NULL) = 0
read(3, "", 4618)                       = 0
gettimeofday({1023667040, 678791}, NULL) = 0
brk(0x805b000)                          = 0x805b000
brk(0x805c000)                          = 0x805c000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 679975}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023667040, 680056}, NULL) = 0
gettimeofday({1023667040, 680104}, NULL) = 0
close(3)                                = 0
gettimeofday({1023667040, 680182}, NULL) = 0
gettimeofday({1023667040, 680226}, NULL) = 0
gettimeofday({1023667040, 680264}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/etc/rpm/macros.specspo", O_RDONLY) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023667040, 680488}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 680746}, NULL) = 0
read(3, "%_i18ndomains\tredhat-dist\n", 8192) = 26
gettimeofday({1023667040, 680850}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 680990}, NULL) = 0
read(3, "", 8166)                       = 0
gettimeofday({1023667040, 681067}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 681373}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023667040, 681451}, NULL) = 0
gettimeofday({1023667040, 681502}, NULL) = 0
close(3)                                = 0
gettimeofday({1023667040, 681579}, NULL) = 0
gettimeofday({1023667040, 681621}, NULL) = 0
gettimeofday({1023667040, 681658}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/etc/rpm/macros.db1", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/etc/rpm/macros.cdb", O_RDONLY)   = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023667040, 681929}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 682189}, NULL) = 0
read(3, "#%__dbi_cdb\tcreate cdb\n", 8192) = 23
gettimeofday({1023667040, 682287}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 682425}, NULL) = 0
read(3, "", 8169)                       = 0
gettimeofday({1023667040, 682503}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023667040, 682651}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023667040, 682727}, NULL) = 0
gettimeofday({1023667040, 682773}, NULL) = 0
close(3)                                = 0
gettimeofday({1023667040, 682850}, NULL) = 0
gettimeofday({1023667040, 682893}, NULL) = 0
gettimeofday({1023667040, 682931}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/etc/rpm/macros", O_RDONLY)       = -1 ENOENT (No such file or directory)
open("/etc/rpm/i686-linux/macros", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/root/.rpmmacros", O_RDONLY)      = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.000")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.001")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.002")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.003")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.004")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.005")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.006")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.007")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.008")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.009")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.010")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.011")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.012")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.013")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.014")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.015")         = -1 ENOENT (No such file or directory)
access("/var/lib/rpm", W_OK)            = 0
access("/var/lib/rpm/__db.001", F_OK)   = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.iso885915/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.iso885915/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/var/lib/rpm/DB_CONFIG", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/var/lib/rpm/__db.001", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE, 0644) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
open("/var/lib/rpm/__db.001", O_RDWR|O_CREAT|O_LARGEFILE, 0644) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
_llseek(4, 0, [0], SEEK_END)            = 0
_llseek(4, 0, [0], SEEK_CUR)            = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x401ff000
close(4)                                = 0
open("/etc/mtab", O_RDONLY)             = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=262, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40201000
read(4, "/dev/hde5 / ext3 rw 0 0\nnone /pr"..., 4096) = 262
close(4)                                = 0
munmap(0x40201000, 4096)                = 0
open("/proc/cpuinfo", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40201000
read(4, "processor\t: 0\nvendor_id\t: Genuin"..., 1024) = 380
read(4, "", 1024)                       = 0
close(4)                                = 0
munmap(0x40201000, 4096)                = 0
close(3)                                = 0
open("/var/lib/rpm/__db.002", O_RDWR|O_CREAT|O_LARGEFILE, 0644) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
_llseek(3, 0, [0], SEEK_END)            = 0
_llseek(3, 647168, [647168], SEEK_CUR)  = 0
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
mmap2(NULL, 655360, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x40201000
close(3)                                = 0
open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=20832256, ...}) = 0
_llseek(3, 0, [0], SEEK_SET)            = 0
read(3, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 256) = 256
close(3)                                = 0
open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=20832256, ...}) = 0
brk(0x805e000)                          = 0x805e000
pread(3, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 4096, 0) = 4096
fcntl64(3, F_SETLK, {type=F_RDLCK, whence=SEEK_SET, start=0, len=0}) = 0
access("/var/lib/rpm", W_OK)            = 0
access("/var/lib/rpm/__db.001", F_OK)   = 0
open("/var/lib/rpm/Name", O_RDONLY|O_LARGEFILE) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=45056, ...}) = 0
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 256) = 256
close(4)                                = 0
open("/var/lib/rpm/Name", O_RDONLY|O_LARGEFILE) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=45056, ...}) = 0
pread(4, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 4096, 0) = 4096
brk(0x8060000)                          = 0x8060000
pread(4, "\0\0\0\0\1\0\0\0\4\0\0\0\0\0\0\0\n\0\0\0^\1\363\2\0\2\366"..., 4096, 16384) = 4096
pread(4, "\0\0\0\0\1\0\0\0\n\0\0\0\4\0\0\0\0\0\0\0H\0?\r\0\2\366"..., 4096, 40960) = 4096
brk(0x8063000)                          = 0x8063000
fstat64(1, {st_mode=S_IFREG|0644, st_size=29935, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x402a1000
write(1, "package stace is not installed\n", 31package stace is not installed
) = 31
close(4)                                = 0
close(3)                                = 0
munmap(0x40201000, 655360)              = 0
munmap(0x401ff000, 8192)                = 0
open("/var/lib/rpm/DB_CONFIG", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
stat64("/var/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
open("/var/lib/rpm/__db.001", O_RDWR|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=8192, ...}) = 0
close(3)                                = 0
open("/var/lib/rpm/__db.001", O_RDWR|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x401ff000
close(3)                                = 0
open("/var/lib/rpm/__db.002", O_RDWR|O_CREAT|O_LARGEFILE, 0) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 655360, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x40201000
close(3)                                = 0
munmap(0x40201000, 655360)              = 0
unlink("/var/lib/rpm/__db.002")         = 0
munmap(0x401ff000, 8192)                = 0
unlink("/var/lib/rpm/__db.001")         = 0
open("/var/lib/rpm", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(0x3, 0x805b510, 0x1000, 0x805b510) = 536
getdents64(0x3, 0x805b510, 0x1000, 0x805b510) = 0
close(3)                                = 0
unlink("/var/lib/rpm/__db_lock.share")  = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db_log.share")   = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db_mpool.share") = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db_txn.share")   = -1 ENOENT (No such file or directory)
munmap(0x402a1000, 4096)                = 0
_exit(1)                                = ?

--Boundary_(ID_yLborKId603phi6RRTkhkA)
Content-type: text/plain; name=strace2.out
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=strace2.out

execve("/bin/rpm", ["rpm", "-q", "strace"], [/* 31 vars */]) = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
uname({sys="Linux", node="daddy", ...}) = 0
geteuid32()                             = 0
getuid32()                              = 0
getegid32()                             = 0
getgid32()                              = 0
getrlimit(0x3, 0xbffff568)              = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 1638
rt_sigaction(SIGRTMIN, {0x812de80, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x812dd9c, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x812deec, [], 0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff330, 30, (nil), 0}) = 0
brk(0)                                  = 0x8215550
brk(0x8215580)                          = 0x8215580
brk(0x8216000)                          = 0x8216000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40000000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
brk(0x8217000)                          = 0x8217000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40000000, 4096)                = 0
open("/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=371, ...}) = 0
old_mmap(NULL, 371, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40000000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20666, ...}) = 0
old_mmap(NULL, 20666, PROT_READ, MAP_SHARED, 3, 0) = 0x40001000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MEASUREMENT", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=29, ...}) = 0
old_mmap(NULL, 29, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40007000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TELEPHONE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
old_mmap(NULL, 65, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40008000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_ADDRESS", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
old_mmap(NULL, 161, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40009000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NAME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=83, ...}) = 0
old_mmap(NULL, 83, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000a000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_PAPER", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=40, ...}) = 0
old_mmap(NULL, 40, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000b000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=58, ...}) = 0
old_mmap(NULL, 58, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000c000
close(3)                                = 0
brk(0x8218000)                          = 0x8218000
open("/usr/lib/locale/en_US.iso885915/LC_MONETARY", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=292, ...}) = 0
old_mmap(NULL, 292, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000d000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22592, ...}) = 0
old_mmap(NULL, 22592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4000e000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TIME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2457, ...}) = 0
old_mmap(NULL, 2457, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NUMERIC", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
old_mmap(NULL, 60, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=173680, ...}) = 0
old_mmap(NULL, 173680, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/usr/lib/rpm/rpmpopt-4.0.4", O_RDONLY) = 3
lseek(3, 0, SEEK_END)                   = 15353
lseek(3, 0, SEEK_SET)                   = 0
read(3, "#/*! \\page config_rpmpopt Defaul"..., 15353) = 15353
close(3)                                = 0
brk(0x8219000)                          = 0x8219000
brk(0x821a000)                          = 0x821a000
brk(0x821b000)                          = 0x821b000
open("/etc/popt", O_RDONLY)             = -1 ENOENT (No such file or directory)
getuid32()                              = 0
geteuid32()                             = 0
open("/root/.popt", O_RDONLY)           = -1 ENOENT (No such file or directory)
getpid()                                = 1638
getrlimit(0x3, 0xbffff5d8)              = 0
setrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGRTMIN, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {SIG_DFL}, NULL, 8) = 0
execve("/usr/lib/rpm/rpmq", ["/usr/lib/rpm/rpmq", "-q", "strace"], [/* 31 vars */]) = 0
uname({sys="Linux", node="daddy", ...}) = 0
brk(0)                                  = 0x804bea8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=86649, ...}) = 0
old_mmap(NULL, 86649, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/librpmbuild-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300<\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=127402, ...}) = 0
old_mmap(NULL, 195024, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002a000
mprotect(0x40045000, 84432, PROT_NONE)  = 0
old_mmap(0x40045000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1a000) = 0x40045000
old_mmap(0x40047000, 76240, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40047000
close(3)                                = 0
open("/usr/lib/librpm-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320f\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=289538, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4005a000
old_mmap(NULL, 301216, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4005b000
mprotect(0x40099000, 47264, PROT_NONE)  = 0
old_mmap(0x40099000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x3e000) = 0x40099000
old_mmap(0x4009c000, 34976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4009c000
close(3)                                = 0
open("/usr/lib/librpmdb-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20Q\1\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=2066537, ...}) = 0
old_mmap(NULL, 694732, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400a5000
mprotect(0x4014a000, 18892, PROT_NONE)  = 0
old_mmap(0x4014a000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa5000) = 0x4014a000
old_mmap(0x4014d000, 6604, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014d000
close(3)                                = 0
open("/usr/lib/librpmio-4.0.4.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\201"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=447647, ...}) = 0
old_mmap(NULL, 240760, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4014f000
mprotect(0x4017d000, 52344, PROT_NONE)  = 0
old_mmap(0x4017d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2e000) = 0x4017d000
old_mmap(0x40182000, 31864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40182000
close(3)                                = 0
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\30"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=60465, ...}) = 0
old_mmap(NULL, 55660, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4018a000
mprotect(0x40196000, 6508, PROT_NONE)   = 0
old_mmap(0x40196000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xb000) = 0x40196000
close(3)                                = 0
open("/usr/lib/libbz2.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\21"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=68011, ...}) = 0
old_mmap(NULL, 61012, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40198000
mprotect(0x401a6000, 3668, PROT_NONE)   = 0
old_mmap(0x401a6000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe000) = 0x401a6000
close(3)                                = 0
open("/usr/lib/libpopt.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\21\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=29376, ...}) = 0
old_mmap(NULL, 27192, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401a7000
mprotect(0x401ad000, 2616, PROT_NONE)   = 0
old_mmap(0x401ad000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x401ad000
close(3)                                = 0
open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20D\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=101902, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ae000
old_mmap(NULL, 81340, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401af000
mprotect(0x401bc000, 28092, PROT_NONE)  = 0
old_mmap(0x401bc000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x401bc000
close(3)                                = 0
open("/lib/librt.so.1", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\33\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=34206, ...}) = 0
old_mmap(NULL, 69140, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401c3000
mprotect(0x401c9000, 44564, PROT_NONE)  = 0
old_mmap(0x401c9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x6000) = 0x401c9000
old_mmap(0x401ca000, 40468, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401ca000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`u\1B4\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1401027, ...}) = 0
old_mmap(0x42000000, 1264928, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
mprotect(0x4212c000, 36128, PROT_NONE)  = 0
old_mmap(0x4212c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12c000) = 0x4212c000
old_mmap(0x42131000, 15648, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42131000
close(3)                                = 0
munmap(0x40014000, 86649)               = 0
modify_ldt(0x1, 0xbffff95c, 0x10)       = 0
getpid()                                = 1638
rt_sigaction(SIGRTMIN, {0x401b79c0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x401b6c90, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x401b7a10, [], 0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff60c, 30, (nil), 0}) = 0
brk(0)                                  = 0x804bea8
brk(0x804bed8)                          = 0x804bed8
brk(0x804c000)                          = 0x804c000
brk(0x804d000)                          = 0x804d000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=371, ...}) = 0
mmap2(NULL, 371, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20666, ...}) = 0
mmap2(NULL, 20666, PROT_READ, MAP_SHARED, 3, 0) = 0x40015000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MEASUREMENT", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=29, ...}) = 0
mmap2(NULL, 29, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001b000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TELEPHONE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
mmap2(NULL, 65, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001c000
close(3)                                = 0
brk(0x804e000)                          = 0x804e000
open("/usr/lib/locale/en_US.iso885915/LC_ADDRESS", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
mmap2(NULL, 161, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NAME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=83, ...}) = 0
mmap2(NULL, 83, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001e000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_PAPER", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=40, ...}) = 0
mmap2(NULL, 40, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001f000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=58, ...}) = 0
mmap2(NULL, 58, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40020000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_MONETARY", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=292, ...}) = 0
mmap2(NULL, 292, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40021000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22592, ...}) = 0
mmap2(NULL, 22592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40022000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_TIME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2457, ...}) = 0
mmap2(NULL, 2457, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40028000
close(3)                                = 0
open("/usr/lib/locale/en_US.iso885915/LC_NUMERIC", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
mmap2(NULL, 60, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40029000
close(3)                                = 0
brk(0x804f000)                          = 0x804f000
open("/usr/lib/locale/en_US.iso885915/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=173680, ...}) = 0
mmap2(NULL, 173680, PROT_READ, MAP_PRIVATE, 3, 0) = 0x401d4000
close(3)                                = 0
open("/usr/lib/rpm/rpmpopt-4.0.4", O_RDONLY) = 3
lseek(3, 0, SEEK_END)                   = 15353
lseek(3, 0, SEEK_SET)                   = 0
read(3, "#/*! \\page config_rpmpopt Defaul"..., 15353) = 15353
close(3)                                = 0
brk(0x8050000)                          = 0x8050000
open("/etc/popt", O_RDONLY)             = -1 ENOENT (No such file or directory)
getuid32()                              = 0
geteuid32()                             = 0
open("/root/.popt", O_RDONLY)           = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="daddy", ...}) = 0
rt_sigaction(SIGILL, {0x401b7f00, [ILL], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
open("/usr/lib/rpm/rpmrc", O_RDONLY)    = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023677015, 103024}, NULL) = 0
brk(0x8051000)                          = 0x8051000
fstat64(3, {st_mode=S_IFREG|0644, st_size=10029, ...}) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 103628}, NULL) = 0
read(3, "#/*! \\page config_rpmrc Default "..., 8192) = 8192
gettimeofday({1023677015, 103794}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 103985}, NULL) = 0
read(3, "NT MiNT TOS\nos_compat: TOS: Free"..., 8192) = 1837
gettimeofday({1023677015, 104084}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 104220}, NULL) = 0
read(3, "", 6355)                       = 0
gettimeofday({1023677015, 104298}, NULL) = 0
gettimeofday({1023677015, 104406}, NULL) = 0
close(3)                                = 0
gettimeofday({1023677015, 104499}, NULL) = 0
gettimeofday({1023677015, 104560}, NULL) = 0
gettimeofday({1023677015, 104598}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
brk(0x8052000)                          = 0x8052000
brk(0x8053000)                          = 0x8053000
brk(0x8054000)                          = 0x8054000
brk(0x8055000)                          = 0x8055000
open("/etc/rpmrc", O_RDONLY)            = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023677015, 106342}, NULL) = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=130, ...}) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 106689}, NULL) = 0
read(3, "# jfb did this + it\'s for the gc"..., 8192) = 130
gettimeofday({1023677015, 106792}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 106927}, NULL) = 0
read(3, "", 8062)                       = 0
gettimeofday({1023677015, 107004}, NULL) = 0
gettimeofday({1023677015, 107057}, NULL) = 0
close(3)                                = 0
gettimeofday({1023677015, 107134}, NULL) = 0
gettimeofday({1023677015, 107179}, NULL) = 0
gettimeofday({1023677015, 107215}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/root/.rpmrc", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/usr/lib/rpm/macros", O_RDONLY)   = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023677015, 107655}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 107947}, NULL) = 0
read(3, "#/*! \\page config_macros Default"..., 8192) = 8192
gettimeofday({1023677015, 108101}, NULL) = 0
brk(0x8056000)                          = 0x8056000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 109565}, NULL) = 0
read(3, " before rpm-3.0.5) are not suppo"..., 8192) = 8192
gettimeofday({1023677015, 109691}, NULL) = 0
brk(0x8057000)                          = 0x8057000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 111238}, NULL) = 0
read(3, "hen repackaging\n#\terased package"..., 8192) = 8192
gettimeofday({1023677015, 111366}, NULL) = 0
brk(0x8058000)                          = 0x8058000
brk(0x8059000)                          = 0x8059000
brk(0x805a000)                          = 0x805a000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 116569}, NULL) = 0
read(3, "e} \\\n#  CFLAGS=\"%{optflags}\" ./c"..., 8192) = 5912
gettimeofday({1023677015, 116686}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 116825}, NULL) = 0
read(3, "", 2280)                       = 0
gettimeofday({1023677015, 116900}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 117894}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023677015, 117976}, NULL) = 0
gettimeofday({1023677015, 118040}, NULL) = 0
close(3)                                = 0
gettimeofday({1023677015, 118118}, NULL) = 0
gettimeofday({1023677015, 118164}, NULL) = 0
gettimeofday({1023677015, 118201}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/usr/lib/rpm/i686-linux/macros", O_RDONLY) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023677015, 118450}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 118709}, NULL) = 0
read(3, "# Per-platform rpm configuration"..., 8192) = 3574
gettimeofday({1023677015, 118822}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 118958}, NULL) = 0
read(3, "", 4618)                       = 0
gettimeofday({1023677015, 119036}, NULL) = 0
brk(0x805b000)                          = 0x805b000
brk(0x805c000)                          = 0x805c000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 120185}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023677015, 120265}, NULL) = 0
gettimeofday({1023677015, 120314}, NULL) = 0
close(3)                                = 0
gettimeofday({1023677015, 120390}, NULL) = 0
gettimeofday({1023677015, 120435}, NULL) = 0
gettimeofday({1023677015, 120471}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/etc/rpm/macros.specspo", O_RDONLY) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023677015, 120693}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 120941}, NULL) = 0
read(3, "%_i18ndomains\tredhat-dist\n", 8192) = 26
gettimeofday({1023677015, 121161}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 121300}, NULL) = 0
read(3, "", 8166)                       = 0
gettimeofday({1023677015, 121379}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 121674}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023677015, 121753}, NULL) = 0
gettimeofday({1023677015, 121801}, NULL) = 0
close(3)                                = 0
gettimeofday({1023677015, 121878}, NULL) = 0
gettimeofday({1023677015, 121922}, NULL) = 0
gettimeofday({1023677015, 121959}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/etc/rpm/macros.db1", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/etc/rpm/macros.cdb", O_RDONLY)   = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
gettimeofday({1023677015, 122245}, NULL) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ff000
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 122498}, NULL) = 0
read(3, "#%__dbi_cdb\tcreate cdb\n", 8192) = 23
gettimeofday({1023677015, 122592}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 122725}, NULL) = 0
read(3, "", 8169)                       = 0
gettimeofday({1023677015, 122802}, NULL) = 0
select(4, [3], NULL, NULL, {1, 0})      = 1 (in [3], left {1, 0})
gettimeofday({1023677015, 122949}, NULL) = 0
read(3, "", 8192)                       = 0
gettimeofday({1023677015, 123025}, NULL) = 0
gettimeofday({1023677015, 123069}, NULL) = 0
close(3)                                = 0
gettimeofday({1023677015, 123144}, NULL) = 0
gettimeofday({1023677015, 123186}, NULL) = 0
gettimeofday({1023677015, 123223}, NULL) = 0
munmap(0x401ff000, 8192)                = 0
open("/etc/rpm/macros", O_RDONLY)       = -1 ENOENT (No such file or directory)
open("/etc/rpm/i686-linux/macros", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/root/.rpmmacros", O_RDONLY)      = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.000")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.001")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.002")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.003")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.004")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.005")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.006")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.007")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.008")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.009")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.010")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.011")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.012")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.013")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.014")         = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db.015")         = -1 ENOENT (No such file or directory)
access("/var/lib/rpm", W_OK)            = 0
access("/var/lib/rpm/__db.001", F_OK)   = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.iso885915/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.iso885915/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/var/lib/rpm/DB_CONFIG", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/var/lib/rpm/__db.001", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE, 0644) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
open("/var/lib/rpm/__db.001", O_RDWR|O_CREAT|O_LARGEFILE, 0644) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
_llseek(4, 0, [0], SEEK_END)            = 0
_llseek(4, 0, [0], SEEK_CUR)            = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x401ff000
close(4)                                = 0
open("/etc/mtab", O_RDONLY)             = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=301, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40201000
read(4, "/dev/hde5 / ext3 rw 0 0\nnone /pr"..., 4096) = 301
close(4)                                = 0
munmap(0x40201000, 4096)                = 0
open("/proc/cpuinfo", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40201000
read(4, "processor\t: 0\nvendor_id\t: Genuin"..., 1024) = 375
read(4, "", 1024)                       = 0
close(4)                                = 0
munmap(0x40201000, 4096)                = 0
close(3)                                = 0
open("/var/lib/rpm/__db.002", O_RDWR|O_CREAT|O_LARGEFILE, 0644) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
_llseek(3, 0, [0], SEEK_END)            = 0
_llseek(3, 647168, [647168], SEEK_CUR)  = 0
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
mmap2(NULL, 655360, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x40201000
close(3)                                = 0
open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=20832256, ...}) = 0
_llseek(3, 0, [0], SEEK_SET)            = 0
read(3, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 256) = 256
close(3)                                = 0
open("/var/lib/rpm/Packages", O_RDONLY|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=20832256, ...}) = 0
brk(0x805e000)                          = 0x805e000
pread(3, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 4096, 0) = 4096
fcntl64(3, F_SETLK, {type=F_RDLCK, whence=SEEK_SET, start=0, len=0}) = 0
access("/var/lib/rpm", W_OK)            = 0
access("/var/lib/rpm/__db.001", F_OK)   = 0
open("/var/lib/rpm/Name", O_RDONLY|O_LARGEFILE) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=45056, ...}) = 0
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 256) = 256
close(4)                                = 0
open("/var/lib/rpm/Name", O_RDONLY|O_LARGEFILE) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=45056, ...}) = 0
pread(4, "\0\0\0\0\1\0\0\0\0\0\0\0a\25\6\0\7\0\0\0\0\20\0\0\0\10"..., 4096, 0) = 4096
brk(0x8060000)                          = 0x8060000
pread(4, "\0\0\0\0\1\0\0\0\4\0\0\0\0\0\0\0\n\0\0\0^\1\363\2\0\2\366"..., 4096, 16384) = 4096
brk(0x8062000)                          = 0x8062000
pread(3, "\0\0\0\0\1\0\0\0\361\10\0\0\0\0\0\0@\22\0\0|\1b\3\0\2\373"..., 4096, 9375744) = 4096
pread(3, "\0\0\0\0\1\0\0\0\360\r\0\0\0\0\0\0\361\r\0\0\1\0\346\17"..., 4096, 14614528) = 4096
pread(3, "\0\0\0\0\1\0\0\0\361\r\0\0\360\r\0\0\0\0\0\0\1\0n\7\0\7"..., 4096, 14618624) = 4096
brk(0x8064000)                          = 0x8064000
open("/etc/mtab", O_RDONLY)             = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=301, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x402a1000
read(5, "/dev/hde5 / ext3 rw 0 0\nnone /pr"..., 4096) = 301
close(5)                                = 0
munmap(0x402a1000, 4096)                = 0
open("/proc/meminfo", O_RDONLY)         = 5
fstat64(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x402a1000
read(5, "        total:    used:    free:"..., 1024) = 602
close(5)                                = 0
munmap(0x402a1000, 4096)                = 0
brk(0x8067000)                          = 0x8067000
brk(0x806a000)                          = 0x806a000
fstat64(1, {st_mode=S_IFREG|0644, st_size=30955, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x402a1000
write(1, "strace-4.4-4\n", 13strace-4.4-4
)          = 13
close(4)                                = 0
close(3)                                = 0
munmap(0x40201000, 655360)              = 0
munmap(0x401ff000, 8192)                = 0
open("/var/lib/rpm/DB_CONFIG", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
stat64("/var/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
open("/var/lib/rpm/__db.001", O_RDWR|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=8192, ...}) = 0
close(3)                                = 0
open("/var/lib/rpm/__db.001", O_RDWR|O_LARGEFILE) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x401ff000
close(3)                                = 0
open("/var/lib/rpm/__db.002", O_RDWR|O_CREAT|O_LARGEFILE, 0) = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 655360, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x40201000
close(3)                                = 0
munmap(0x40201000, 655360)              = 0
unlink("/var/lib/rpm/__db.002")         = 0
munmap(0x401ff000, 8192)                = 0
unlink("/var/lib/rpm/__db.001")         = 0
open("/var/lib/rpm", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(0x3, 0x805b510, 0x1000, 0x805b510) = 536
getdents64(0x3, 0x805b510, 0x1000, 0x805b510) = 0
close(3)                                = 0
unlink("/var/lib/rpm/__db_lock.share")  = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db_log.share")   = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db_mpool.share") = -1 ENOENT (No such file or directory)
unlink("/var/lib/rpm/__db_txn.share")   = -1 ENOENT (No such file or directory)
munmap(0x402a1000, 4096)                = 0
_exit(0)                                = ?

--Boundary_(ID_yLborKId603phi6RRTkhkA)--
