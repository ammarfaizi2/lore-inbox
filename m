Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVBIDVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVBIDVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 22:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVBIDVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 22:21:01 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:131 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261767AbVBIDUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 22:20:35 -0500
Message-ID: <42098178.9030707@tequila.co.jp>
Date: Wed, 09 Feb 2005 12:20:24 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: again cifs oops in 2.6.8.1
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I got again too cifs oops:

Feb  7 18:17:07 ramen kernel: c02180d4
Feb  7 18:17:07 ramen kernel: SMP
Feb  7 18:17:07 ramen kernel: Modules linked in: loop ntfs appletalk ipx
p8022 psnap llc usbcore
Feb  7 18:17:07 ramen kernel: CPU:    1
Feb  7 18:17:07 ramen kernel: EIP:    0060:[cifs_readdir+2401/3445]
Not tainted
Feb  7 18:17:07 ramen kernel: EFLAGS: 00010246   (2.6.8.1)
Feb  7 18:17:07 ramen kernel: EIP is at cifs_readdir+0x961/0xd75
Feb  7 18:17:07 ramen kernel: eax: c050c480   ebx: d3b79f4c   ecx:
f7db1340   edx: 91982a8e
Feb  7 18:17:07 ramen kernel: esi: 00000000   edi: e9048bce   ebp:
d3b79f68   esp: d3b79ee0
Feb  7 18:17:07 ramen kernel: ds: 007b   es: 007b   ss: 0068
Feb  7 18:17:07 ramen kernel: Process smbd (pid: 30224,
threadinfo=d3b78000 task=cbc4b290)
Feb  7 18:17:07 ramen kernel: Stack: d3b79f4c e70d41e0 cc0e8480 c050c480
d3b79fa0 c050c480 d3b79f34 d3b79f38
Feb  7 18:17:07 ramen kernel:        00000001 000003e9 e70d4000 91982a8e
c229ab00 dec6bb80 f7db1340 00000009
Feb  7 18:17:07 ramen kernel:        00004000 000c0451 00000000 4204f254
33390598 00000001 00000000 000a1800
Feb  7 18:17:07 ramen kernel: Call Trace:
Feb  7 18:17:07 ramen kernel:  [show_stack+128/150] show_stack+0x80/0x96
Feb  7 18:17:07 ramen kernel:  [show_registers+351/430]
show_registers+0x15f/0x1ae
Feb  7 18:17:07 ramen kernel:  [die+141/251] die+0x8d/0xfb
Feb  7 18:17:07 ramen kernel:  [do_page_fault+708/1390]
do_page_fault+0x2c4/0x56e
Feb  7 18:17:07 ramen kernel:  [error_code+45/56] error_code+0x2d/0x38
Feb  7 18:17:07 ramen kernel:  [vfs_readdir+150/177] vfs_readdir+0x96/0xb1
Feb  7 18:17:07 ramen kernel:  [sys_getdents64+109/166]
sys_getdents64+0x6d/0xa6
Feb  7 18:17:07 ramen kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  7 18:17:07 ramen kernel: Code: 8b 42 3c d1 e8 89 44 24 08 89 d0 83
c0 40 89 44 24 04 89 04
Feb  7 18:17:27 ramen kernel:  <3> CIFS VFS: Error 0xffffffec or on
cifs_get_inode_info in lookup

Feb  9 07:59:17 ramen -- MARK --
Feb  9 08:05:22 ramen kernel: c02180d4
Feb  9 08:05:22 ramen kernel: SMP
Feb  9 08:05:22 ramen kernel: Modules linked in: loop ntfs appletalk ipx
p8022 psnap llc usbcore
Feb  9 08:05:22 ramen kernel: CPU:    1
Feb  9 08:05:22 ramen kernel: EIP:    0060:[cifs_readdir+2401/3445]
Not tainted
Feb  9 08:05:22 ramen kernel: EFLAGS: 00010246   (2.6.8.1)
Feb  9 08:05:22 ramen kernel: EIP is at cifs_readdir+0x961/0xd75
Feb  9 08:05:22 ramen kernel: eax: c050c480   ebx: d1371f4c   ecx:
f7db1340   edx: 9542b9d7
Feb  9 08:05:22 ramen kernel: esi: 00000000   edi: d0fcf1c6   ebp:
d1371f68   esp: d1371ee0
Feb  9 08:05:22 ramen kernel: ds: 007b   es: 007b   ss: 0068
Feb  9 08:05:22 ramen kernel: Process find (pid: 32008,
threadinfo=d1370000 task=daf5c330)
Feb  9 08:05:22 ramen kernel: Stack: d1371f4c e987cf28 c99ee080 c050c480
d1371fa0 c050c480 d1371f34 d1371f38
Feb  9 08:05:22 ramen kernel:        00000001 000003e9 e987c000 9542b9d7
d88c5100 d0fcfb80 f7db1340 0000002a
Feb  9 08:05:22 ramen kernel:        00004000 000ffaf5 00000000 4204f243
03b9aca0 00000001 00000000 00291802
Feb  9 08:05:22 ramen kernel: Call Trace:
Feb  9 08:05:22 ramen kernel:  [show_stack+128/150] show_stack+0x80/0x96
Feb  9 08:05:22 ramen kernel:  [show_registers+351/430]
show_registers+0x15f/0x1ae
Feb  9 08:05:22 ramen kernel:  [die+141/251] die+0x8d/0xfb
Feb  9 08:05:22 ramen kernel:  [do_page_fault+708/1390]
do_page_fault+0x2c4/0x56e
Feb  9 08:05:22 ramen kernel:  [error_code+45/56] error_code+0x2d/0x38
Feb  9 08:05:22 ramen kernel:  [vfs_readdir+150/177] vfs_readdir+0x96/0xb1
Feb  9 08:05:22 ramen kernel:  [sys_getdents64+109/166]
sys_getdents64+0x6d/0xa6
Feb  9 08:05:22 ramen kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  9 08:05:22 ramen kernel: Code: 8b 42 3c d1 e8 89 44 24 08 89 d0 83
c0 40 89 44 24 04 89 04


specs:

The box is a Debian/Testing with a self compiled 2.6.8.1

ramen:~# lsmod
Module                  Size  Used by
loop                   13704  4
ntfs                  131188  2
appletalk              34384  20
ipx                    28324  0
p8022                   2688  1 ipx
psnap                   3972  2 appletalk,ipx
llc                     6676  2 p8022,psnap
usbcore               102628  0

ramen:~# lspci
0000:00:00.0 Host bridge: ServerWorks CMIC-WS Host Bridge (GC-LE
chipset) (rev 13)
0000:00:00.1 Host bridge: ServerWorks CMIC-WS Host Bridge (GC-LE chipset)
0000:00:00.2 Host bridge: ServerWorks CMIC-LE
0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:00:04.0 System peripheral: Compaq Computer Corporation Integrated
Lights Out Controller (rev 01)
0000:00:04.2 System peripheral: Compaq Computer Corporation Integrated
Lights Out  Processor (rev 01)
0000:00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
0000:00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller
(rev 05)
0000:00:0f.3 Host bridge: ServerWorks CSB5 LPC bridge
0000:00:10.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:10.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:11.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:11.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:01:03.0 RAID bus controller: Compaq Computer Corporation Smart
Array 5i/532 (rev 01)
0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5703X Gigabit Ethernet (rev 02)
0000:02:02.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5703X Gigabit Ethernet (rev 02)
0000:03:01.0 RAID bus controller: Compaq Computer Corporation Smart
Array 64xx (rev 01)
0000:06:02.0 SCSI storage controller: Adaptec ASC-29320LP U320 (rev 03)
0000:06:1e.0 PCI Hot-plug controller: Compaq Computer Corporation PCI
Hotplug Controller (rev 14)

ramen:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
Configured with: ../src/configure -v
- --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr
- --mandir=/usr/share/man --infodir=/usr/share/info
- --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
- --with-system-zlib --enable-nls --without-included-gettext
- --enable-__cxa_atexit --enable-clocale=gnu --enable-debug
- --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-5)

I have an external SW Raid5 with XFS shared as NFS, samba and appletalk,
and internal HW RAID5 also XFS shared as NFS< samba and appletalk.

there is one external FS mounted via NFS and one via CIFS.

the CPU is a Xeon with HT enabled and SMP is compiled into the kernel
(for HT)

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCCYF3jBz/yQjBxz8RAqraAKCMScAmtC4au14WAw2F7q46N0b7OwCeI40Z
rZPO8ZArJ7E9pq4/HqlLBqY=
=847T
-----END PGP SIGNATURE-----
