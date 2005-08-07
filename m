Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVHGCMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVHGCMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 22:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHGCMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 22:12:21 -0400
Received: from laska.dorms.spbu.ru ([195.19.252.72]:12516 "EHLO
	laska.dorms.spbu.ru") by vger.kernel.org with ESMTP
	id S1750740AbVHGCMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 22:12:21 -0400
Date: Sun, 7 Aug 2005 06:12:10 +0400
From: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>
To: linux-kernel@vger.kernel.org
Subject: e100, eepro100 modules -- can't up an interface (2.6.13-rc3 and
 above)
Message-ID: <20050807061210.6e97265b@laska>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.

I can't up my network interface. This problem appear in 2.6.13-rc3 and
still exist. This is the part of strace for "ifconfig eth0 <ip> netmask
<mask>".
==========================================================================
uname({sys="Linux", node="laska", ...}) = 0 access("/proc/net",
R_OK)               = 0 access("/proc/net/unix", R_OK)          = 0
socket(PF_FILE, SOCK_DGRAM, 0)          = 3
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
access("/proc/net/if_inet6", R_OK)      = -1 ENOENT (No such file or
directory) access("/proc/net/ax25", R_OK)          = -1 ENOENT (No such
file or directory) access("/proc/net/nr", R_OK)            = -1 ENOENT
(No such file or directory) access("/proc/net/ipx", R_OK)           = -1
ENOENT (No such file or directory) access("/proc/net/appletalk",
R_OK)     = -1 ENOENT (No such file or directory) access("/proc/net/x25",
R_OK)           = -1 ENOENT (No such file or directory) ioctl(4,
SIOCSIFADDR, 0xbfa53de0)       = 0 ioctl(4, SIOCGIFFLAGS,
0xbfa53d10)      = 0 ioctl(4, SIOCSIFFLAGS, 0xbfa53d10)      = -1 ENOSYS
(Function not implemented) dup(2)                                  = 5
fcntl64(5, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(5, {st_mode=S_IFCHR|0720, st_rdev=makedev(136, 0), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f35000 _llseek(5, 0, 0xbfa53b9c, SEEK_CUR)     = -1 ESPIPE (Illegal
seek) write(5, "SIOCSIFFLAGS: Function not imple"..., 39) = 39
close(5)                                = 0
munmap(0xb7f35000, 4096)                = 0
ioctl(4, SIOCSIFNETMASK, 0xbfa53de0)    = 0
exit_group(0)                           = ?
============================================================================
PS: I have 2 ethernet cards: e100 and via-rhine. The problem appear only
for e100.

PPS: please CC me, as I am not in list

Mikhail Kshevetskiy
