Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268337AbTCFU2O>; Thu, 6 Mar 2003 15:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268346AbTCFU2N>; Thu, 6 Mar 2003 15:28:13 -0500
Received: from starcraft.mweb.co.za ([196.2.45.78]:54697 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S268337AbTCFU17>; Thu, 6 Mar 2003 15:27:59 -0500
Date: Thu, 6 Mar 2003 22:38:37 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
Subject: Oops in dcache.h 2.5.64
Message-Id: <20030306223837.7237243d.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="BwR_Y5=.lsagRv+B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--BwR_Y5=.lsagRv+B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi

I got the folling oops this morning, please let me know if 
you need any other details.

Cheers

ksymoops 2.4.8 on i686 2.5.64.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.64/ (default)
     -m /boot/System.map-2.5.64 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
 kernel BUG at include/linux/dcache.h:266!
 invalid operand: 0000
 CPU:    0
 EIP:    0060:[sysfs_remove_dir+28/316]    Not tainted
 EIP:    0060:[<c0184adc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010246
 eax: 00000000   ebx: c4aa0184   ecx: 00000000   edx: 00000000
 esi: c541b94c   edi: 00000000   ebp: 00000000   esp: c5623ed8
 ds: 007b   es: 007b   ss: 0068
 Stack: c02ff751 c4aa0000 c03b5214 c4aa0184 c4aa0000 00000000 00000000 c01e22c3
        c4aa0184 c4aa0184 c01e22f3 c4aa0184 c5622000 c02aba5d c4aa0184 00000006
        c4aa0000 c5622000 c4aa0000 ceff9bbc c03ac700 c024874a c4aa0000 cffef2f0
 Call Trace: [addrconf_notify+113/224]  [kobject_del+19/48]  [kobject_unregister+19/48]  [unregister_netdevice+525/784]  [ppp_shutdown_interface+234/384]  [ppp_ioctl+2268/2320]  [dput+48/384]  [__fput+160/240]  [sys_ioctl+193/576]  [sys_close+98/160]  [syscall_call+7/11]
 Call Trace: [<c02ff751>]  [<c01e22c3>]  [<c01e22f3>]  [<c02aba5d>]  [<c024874a>]  [<c024609c>]  [<c0167350>]  [<c0151bd0>]  [<c0162901>]  [<c014ff62>]  [<c010b28f>]
 Code: 0f 0b 0a 01 61 db 34 c0 ff 06 83 4e 04 08 85 f6 0f 84 02 01


>>EIP; c0184adc <sysfs_remove_dir+1c/13c>   <=====

>>ebx; c4aa0184 <__crc_vfat_lookup+18570/1cd489>
>>esi; c541b94c <__crc_msdos_lookup+5ec5fc/98a7f6>
>>esp; c5623ed8 <__crc_msdos_lookup+7f4b88/98a7f6>

Trace; c02ff751 <addrconf_notify+71/e0>
Trace; c01e22c3 <kobject_del+13/30>
Trace; c01e22f3 <kobject_unregister+13/30>
Trace; c02aba5d <unregister_netdevice+20d/310>
Trace; c024874a <ppp_shutdown_interface+ea/180>
Trace; c024609c <ppp_ioctl+8dc/910>
Trace; c0167350 <dput+30/180>
Trace; c0151bd0 <__fput+a0/f0>
Trace; c0162901 <sys_ioctl+c1/240>
Trace; c014ff62 <sys_close+62/a0>
Trace; c010b28f <syscall_call+7/b>

Code;  c0184adc <sysfs_remove_dir+1c/13c>
00000000 <_EIP>:
Code;  c0184adc <sysfs_remove_dir+1c/13c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0184ade <sysfs_remove_dir+1e/13c>
   2:   0a 01                     or     (%ecx),%al
Code;  c0184ae0 <sysfs_remove_dir+20/13c>
   4:   61                        popa
Code;  c0184ae1 <sysfs_remove_dir+21/13c>
   5:   db 34 c0                  (bad)  (%eax,%eax,8)
Code;  c0184ae4 <sysfs_remove_dir+24/13c>
   8:   ff 06                     incl   (%esi)
Code;  c0184ae6 <sysfs_remove_dir+26/13c>
   a:   83 4e 04 08               orl    $0x8,0x4(%esi)
Code;  c0184aea <sysfs_remove_dir+2a/13c>
   e:   85 f6                     test   %esi,%esi
Code;  c0184aec <sysfs_remove_dir+2c/13c>
  10:   0f 84 02 01 00 00         je     118 <_EIP+0x118>


1 warning and 1 error issued.  Results may not be reliable.

--BwR_Y5=.lsagRv+B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z7HY+pvEqv8+FEMRAgtdAJ9aeIV03fj6FhidT5/rW57qYc801gCggWj5
CMLr4/FUKqHFxEfbXK0vbdo=
=SQOM
-----END PGP SIGNATURE-----

--BwR_Y5=.lsagRv+B--
