Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTE3Nl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTE3Nl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:41:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:23499 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263673AbTE3Nlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:41:53 -0400
X-From-Line: linux-kernel@gitteundmarkus.de Fri May 30 13:52:54 2003
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Subject: Re: [PATCH] SG_IO readcd and various bugs
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20030530130230.GD813@suse.de> <878ysopmus.fsf@gitteundmarkus.de>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Fri, 30 May 2003 15:52:40 +0200
In-Reply-To: <878ysopmus.fsf@gitteundmarkus.de> (Markus Plail's message of
 "Fri, 30 May 2003 15:47:55 +0200")
Message-ID: <874r3cpmmv.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Relays-Trusted: 
X-Spam-Relays-Untrusted: [ ip=212.227.126.233 rdns=pop.kundenserver.de helo=
 by=localhost ident= ] [ ip=212.227.126.161 rdns=
 helo=mrelayng.kundenserver.de by=mxng10.kundenserver.de ident= ] [
 ip=217.225.97.102 rdns= helo=localhost.localdomain
 by=mrelayng.kundenserver.de ident= ]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Markus Plail wrote:

> The patch makes readcd work just fine here :-) Many thanks!

Just realized that C2 scans don't yet work.

regards
Markus

[15:49:37]-[Fri May 30]-[/home/plail]
[root@plailis_lfs]strace /opt/schily/bin/readcd dev=/dev/hdb -c2scan
execve("/opt/schily/bin/readcd", ["/opt/schily/bin/readcd", "dev=/dev/hdb", "-c2scan"], [/* 45 vars */]) = 0
brk(0)                                  = 0x806a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=66034, ...}) = 0
old_mmap(NULL, 66034, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\10\332"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5021367, ...}) = 0
old_mmap(NULL, 1215588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40028000
mprotect(0x40146000, 44132, PROT_NONE)  = 0
old_mmap(0x40146000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11d000) = 0x40146000
old_mmap(0x4014d000, 15460, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014d000
close(3)                                = 0
munmap(0x40017000, 66034)               = 0
brk(0)                                  = 0x806a000
brk(0x806a0a8)                          = 0x806a0a8
brk(0x806b000)                          = 0x806b000
brk(0x806d000)                          = 0x806d000
open("/dev/hdb", O_RDWR|O_NONBLOCK)     = 3
fcntl64(3, F_GETFL)                     = 0x8802 (flags O_RDWR|O_NONBLOCK|O_LARGEFILE)
fcntl64(3, F_SETFL, O_RDWR|O_LARGEFILE) = 0
ioctl(3, 0x5382, 0xbffff164)            = 0
ioctl(3, 0x5386, 0xbffff160)            = 0
ioctl(3, 0x2282, 0xbffff168)            = 0
ioctl(3, 0x5382, 0xbffff104)            = 0
ioctl(3, 0x5386, 0xbffff100)            = 0
ioctl(3, 0x2201, 0xbffff018)            = 0
fstat64(3, {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 64), ...}) = 0
ioctl(3, 0x2272, 0xbffff338)            = 0
ioctl(3, 0x2272, 0xbffff338)            = 0
ioctl(3, 0x2275, 0xbffff334)            = -1 EINVAL (Invalid argument)
ioctl(3, 0x2272, 0xbffff334)            = 0
ioctl(3, 0x2272, 0xbffff318)            = 0
ioctl(3, 0x2272, 0xbffff314)            = 0
old_mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40151000
geteuid32()                             = 0
getuid32()                              = 0
getuid32()                              = 0
setreuid32(0xffffffff, 0)               = 0
gettimeofday({1054302587, 28334}, NULL) = 0
ioctl(3, 0x2285, 0xbffff0fc)            = 0
gettimeofday({1054302587, 29005}, NULL) = 0
gettimeofday({1054302587, 29274}, NULL) = 0
ioctl(3, 0x2285, 0xbffff13c)            = 0
...
...[snip]...
...
ioctl(3, 0x2285, 0xbfffee8c)            = 0
gettimeofday({1054302587, 141430}, NULL) = 0
write(2, "Read  speed:  8310 kB/s (CD  47x"..., 44Read  speed:  8310 kB/s (CD  47x, DVD  6x).
) = 44
write(2, "Write speed:  2770 kB/s (CD  15x"..., 44Write speed:  2770 kB/s (CD  15x, DVD  2x).
) = 44
rt_sigaction(SIGINT, {0x8049d48, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x8049d48, [TERM], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
gettimeofday({1054302587, 143382}, NULL) = 0
ioctl(3, 0x2285, 0xbffff28c)            = 0
gettimeofday({1054302587, 144030}, NULL) = 0
gettimeofday({1054302587, 144315}, NULL) = 0
ioctl(3, 0x2285, 0xbffff25c)            = 0
gettimeofday({1054302587, 150267}, NULL) = 0
gettimeofday({1054302587, 150526}, NULL) = 0
ioctl(3, 0x2285, 0xbffff25c)            = 0
gettimeofday({1054302587, 151355}, NULL) = 0
write(2, "Capacity: 49843 Blocks = 99686 k"..., 61Capacity: 49843 Blocks = 99686 kBytes = 97 MBytes = 102 prMB
) = 61
write(2, "Sectorsize: 2048 Bytes\n", 23Sectorsize: 2048 Bytes
) = 23
gettimeofday({1054302587, 152679}, NULL) = 0
ioctl(3, 0x2285, 0xbfffedfc)            = 0
gettimeofday({1054302587, 156396}, NULL) = 0
gettimeofday({1054302587, 156644}, NULL) = 0
ioctl(3, 0x2285, 0xbfffec7c)            = 0
...
...[snip]...
...
ioctl(3, 0x2285, 0xbfffefcc)            = 0
gettimeofday({1054302587, 244917}, NULL) = 0
write(2, "Copy from SCSI (0,0,0) disk to f"..., 48Copy from SCSI (0,0,0) disk to file '/dev/null'
) = 48
open("/dev/null", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 4
fcntl64(4, F_GETFL)                     = 0x8001 (flags O_WRONLY|O_LARGEFILE)
fstat64(4, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbfffedb8) = -1 ENOTTY (Inappropriate ioctl for device)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
_llseek(4, 0, [0], SEEK_CUR)            = 0
munmap(0x40017000, 4096)                = 0
write(2, "end:     49843\n", 15end:     49843
)        = 15
gettimeofday({1054302587, 248522}, NULL) = 0
) = 232, "addr:        0 cnt: 48\r", 23addr:        0 cnt: 48
gettimeofday({1054302587, 249061}, NULL) = 0
ioctl(3, 0x2285, 0xbfffef6c)            = 0
gettimeofday({1054302587, 259824}, NULL) = 0
write(2, "/opt/schily/bin/readcd: Success."..., 352/opt/schily/bin/readcd: Success. read_cd: scsi sendcmd: no error
CDB:  BE 00 00 00 00 00 00 00 30 FA 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70
Sense Key: 0x0 No Additional Sense, Segment 0
Sense Code: 0x00 Qual 0x00 (no additional sense information) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 127008
cmd finished after 0.010s timeout 40s
) = 352
write(2, "/opt/schily/bin/readcd: Success."..., 57/opt/schily/bin/readcd: Success. Cannot read source disk
) = 57
write(2, "/opt/schily/bin/readcd: Retrying"..., 48/opt/schily/bin/readcd: Retrying from sector 0.
) = 48
write(2, ".", 1.)                        = 1
gettimeofday({1054302587, 262470}, NULL) = 0
ioctl(3, 0x2285, 0xbfffcf4c)            = 0
gettimeofday({1054302587, 263143}, NULL) = 0
gettimeofday({1054302587, 263402}, NULL) = 0


