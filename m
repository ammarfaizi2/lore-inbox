Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTH2LxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTH2LxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:53:14 -0400
Received: from mx0.gmx.net ([213.165.64.100]:16076 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S264546AbTH2LxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:53:08 -0400
Date: Fri, 29 Aug 2003 13:53:06 +0200 (MEST)
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Reiser4 snapshot problems
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005429946@gmx.net
X-Authenticated-IP: [217.80.179.206]
Message-ID: <4834.1062157986@www16.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am trying out Reiser4 snapshot from August 26th.
I've putted my kde cvs sources on the new partition and compile from reiser4
now.

After some time processes hang when accessing this disk. I cannot do
anything on it but I also don't get any errormessage.

Umount, bash autocomletion and things like that don't work. Normal df and
mount are working btw.

Here are the line from strace when I call ls:

open("/lib/libattr.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\r\0\000"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=10668, ...}) = 0
old_mmap(NULL, 13736, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401af000
old_mmap(0x401b2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x2000) = 0x401b2000
close(3)                                = 0
munmap(0x40014000, 94548)               = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) =
0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 9293
rt_sigaction(SIGRTMIN, {0x401676a0, [], SA_RESTORER, 0x4006cc38}, NULL, 8) =
0
rt_sigaction(SIGRT_1, {0x401676d8, [], SA_RESTORER, 0x4006cc38}, NULL, 8) =
0
rt_sigaction(SIGRT_2, {0x4016778c, [], SA_RESTORER, 0x4006cc38}, NULL, 8) =
0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [33], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff44c, 32, (nil), 0}) = 0
brk(0)                                  = 0x805a000
brk(0x807b000)                          = 0x807b000
brk(0)                                  = 0x807b000
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TIOCGWINSZ, {ws_row=50, ws_col=124, ws_xpixel=0, ws_ypixel=0}) = 0
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a
directory)
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=35, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3,
< hang >

Should I enable debugging to get some info ? What should I enable there ?

CONFIG_REISER4_FS=y
# CONFIG_REISER4_FS_SYSCALL is not set
CONFIG_REISER4_LARGE_KEY=y
# CONFIG_REISER4_CHECK is not set
CONFIG_REISER4_USE_EFLUSH=y
# CONFIG_REISER4_BADBLOCKS is not set

thanks
Felix

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

