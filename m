Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUHNOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUHNOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUHNOZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:25:57 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:16776 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262932AbUHNOZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:25:33 -0400
Subject: No DMA Since 2.6.8 Upgrade
From: Nicolas BENOIT <nbenoit@tuxfamily.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-/JdXijfJFqO/GeR79JgN"
Message-Id: <1092493521.468.14.camel@brioche.gwened>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 16:25:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/JdXijfJFqO/GeR79JgN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I just upgraded to 2.6.8 and I can't enable DMA anymore.
It fails for all my devices, telling me that I don't have the
permission.

"HDIO_SET_DMA failed: Operation not permitted"

What's strange, is that I did not change anything in my new .config
file. (just enabled Message Signaled Interrupts )

I enabled "Use PCI DMA by default when available", but it doesn't change
anything.

My chipset is an Intel i875p, so I am using "Intel PIIXn chipsets
support"

This message comes with an strace dump of 'hdparm -d1 /dev/hda' and with
a dump of 'cat /proc/ide/hda/settings'

Greetings,
Nicolas


-- 
+-----------------------------------+
| Nicolas BENOIT                    |
| http://nbenoit.tuxfamily.org      |
|                                   |
|   .~.                             |
|   /V\          Gnu - Linux        |
|  // \\   http://www.slackware.com |
| /(   )\                           |
|  ^^-^^                            |
+-----------------------------------+

--=-/JdXijfJFqO/GeR79JgN
Content-Disposition: attachment; filename=cat_dump.txt
Content-Type: text/plain; name=cat_dump.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 1               0               2               rw
bios_cyl                19457           0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           0               0               70              rw
failures                0               0               65535           rw
init_speed              0               0               70              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               1               0               1               rw
using_dma               0               0               1               rw
wcache                  1               0               1               rw

--=-/JdXijfJFqO/GeR79JgN
Content-Disposition: attachment; filename=strace_dump.txt
Content-Type: text/plain; name=strace_dump.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

execve("/sbin/hdparm", ["hdparm", "-d1", "/dev/hda"], [/* 40 vars */]) = 0
brk(0)                                  = 0x8055000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=90489, ...}) = 0
old_mmap(NULL, 90489, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1250840, ...}) = 0
old_mmap(NULL, 1237892, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002d000
mprotect(0x40155000, 25476, PROT_NONE)  = 0
old_mmap(0x40155000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x128000) = 0x40155000
old_mmap(0x40159000, 9092, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40159000
close(3)                                = 0
munmap(0x40016000, 90489)               = 0
stat64("/dev/hda", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 0), ...}) = 0
open("/dev/hda", O_RDONLY|O_NONBLOCK)   = 3
fstat64(1, {st_mode=S_IFREG|0644, st_size=1240, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
ioctl(3, 0x326, 0x1)                    = -1 EPERM (Operation not permitted)
dup(2)                                  = 4
fcntl64(4, F_GETFL)                     = 0x8001 (flags O_WRONLY|O_LARGEFILE)
close(4)                                = 0
write(2, " HDIO_SET_DMA failed: Operation "..., 46 HDIO_SET_DMA failed: Operation not permitted
) = 46
ioctl(3, 0x30b, 0x8054638)              = 0
close(3)                                = 0
write(1, "\n/dev/hda:\n setting using_dma to"..., 65
/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  0 (off)
) = 65
munmap(0x40016000, 4096)                = 0
exit_group(0)                           = ?

--=-/JdXijfJFqO/GeR79JgN--

