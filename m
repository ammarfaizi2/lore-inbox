Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVDNLkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDNLkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 07:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDNLkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 07:40:45 -0400
Received: from v6.netlin.pl ([62.121.136.6]:47364 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261328AbVDNLkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 07:40:15 -0400
Message-ID: <425E5682.6060606@pointblue.com.pl>
Date: Thu, 14 Apr 2005 13:39:46 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] on usb removal, and minicom closing 2.6.11.7
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9254059EB35316E12E31682"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9254059EB35316E12E31682
Content-Type: multipart/mixed;
 boundary="------------020002000105000906000806"

This is a multi-part message in MIME format.
--------------020002000105000906000806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

So,

I plugged in e680 motorola phone, played a bit with minicom on
/dev/ttyACM0, and when I closed minicom, got this oops. USB is useless,
got to reboot computer to use it again!
it's vanilla 2.6.11.7

oops attached.



--------------020002000105000906000806
Content-Type: text/plain;
 name="oops.back.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.back.txt"

ksymoops 2.4.9 on i686 2.6.11.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11.7/ (default)
     -m /boot/System.map-2.6.11.7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01efc59>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.11.7)
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c17d3df8
esi: 00000001   edi: 00000000   ebp: c74a9d70   esp: c74a9d64
ds: 007b   es: 007b   ss: 0068
Stack: c03a38e0 c17d3dd4 d269e378 c74a9d94 c01efcda c17d3df8 c041e888 d4b03d2c
       00000001 c03a38e0 c17d3dd4 d269e378 c74a9dd8 c025f75c c17d3df8 000000d0
       d269e360 d5efc829 c74a9dc4 c01f3818 d5efc829 2a1037d7 00000000 d3481e6c
Call Trace:
 [<c010340f>] show_stack+0x7f/0xa0
 [<c01035a6>] show_registers+0x156/0x1d0
 [<c01037a8>] die+0xc8/0x150
 [<c0114d62>] do_page_fault+0x462/0x699
 [<c01030a7>] error_code+0x2b/0x30
 [<c01efcda>] kobject_get_path+0x1a/0x70
 [<c025f75c>] class_hotplug+0x6c/0x1b0
 [<c01f09bb>] kobject_hotplug+0x1cb/0x2b0
 [<c01f009b>] kobject_del+0x1b/0x30
 [<c025fc14>] class_device_del+0xa4/0xc0
 [<c025fc42>] class_device_unregister+0x12/0x20
 [<e0fcf529>] acm_tty_close+0xc9/0x110 [cdc_acm]
 [<c024921d>] release_dev+0x6ad/0x7f0
 [<c0249801>] tty_release+0x11/0x20
 [<c0154a9c>] __fput+0xec/0x120
 [<c01531d0>] filp_close+0x50/0x90
 [<c015325c>] sys_close+0x4c/0x70
 [<c0102e93>] syscall_call+0x7/0xb
Code: e6 89 34 24 e8 99 11 fa ff eb dc 8d b4 26 00 00 00 00 55 89 e5 8b 55 08 57 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 5f


>>EIP; c01efc59 <get_kobj_path_length+19/30>   <=====

>>ecx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>edx; c17d3df8 <pg0+13a0df8/3fbcb400>
>>ebp; c74a9d70 <pg0+7076d70/3fbcb400>
>>esp; c74a9d64 <pg0+7076d64/3fbcb400>

Trace; c010340f <show_stack+7f/a0>
Trace; c01035a6 <show_registers+156/1d0>
Trace; c01037a8 <die+c8/150>
Trace; c0114d62 <do_page_fault+462/699>
Trace; c01030a7 <error_code+2b/30>
Trace; c01efcda <kobject_get_path+1a/70>
Trace; c025f75c <class_hotplug+6c/1b0>
Trace; c01f09bb <kobject_hotplug+1cb/2b0>
Trace; c01f009b <kobject_del+1b/30>
Trace; c025fc14 <class_device_del+a4/c0>
Trace; c025fc42 <class_device_unregister+12/20>
Trace; e0fcf529 <pg0+20b9c529/3fbcb400>
Trace; c024921d <release_dev+6ad/7f0>
Trace; c0249801 <tty_release+11/20>
Trace; c0154a9c <__fput+ec/120>
Trace; c01531d0 <filp_close+50/90>
Trace; c015325c <sys_close+4c/70>
Trace; c0102e93 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01efc2e <create_dir+3e/50>
00000000 <_EIP>:
Code;  c01efc2e <create_dir+3e/50>
   0:   e6 89                     out    %al,$0x89
Code;  c01efc30 <create_dir+40/50>
   2:   34 24                     xor    $0x24,%al
Code;  c01efc32 <create_dir+42/50>
   4:   e8 99 11 fa ff            call   fffa11a2 <_EIP+0xfffa11a2>
Code;  c01efc37 <create_dir+47/50>
   9:   eb dc                     jmp    ffffffe7 <_EIP+0xffffffe7>
Code;  c01efc39 <create_dir+49/50>
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c01efc40 <get_kobj_path_length+0/30>
  12:   55                        push   %ebp
Code;  c01efc41 <get_kobj_path_length+1/30>
  13:   89 e5                     mov    %esp,%ebp
Code;  c01efc43 <get_kobj_path_length+3/30>
  15:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  c01efc46 <get_kobj_path_length+6/30>
  18:   57           push   %edi
Code;  c01efc47 <get_kobj_path_length+7/30>
  19:   56                        push   %esi
Code;  c01efc48 <get_kobj_path_length+8/30>
  1a:   be 01 00 00 00            mov    $0x1,%esi
Code;  c01efc4d <get_kobj_path_length+d/30>
  1f:   53                        push   %ebx
Code;  c01efc4e <get_kobj_path_length+e/30>
  20:   31 db                     xor    %ebx,%ebx
Code;  c01efc50 <get_kobj_path_length+10/30>
  22:   8b 3a                     mov    (%edx),%edi
Code;  c01efc52 <get_kobj_path_length+12/30>
  24:   b9 ff ff ff ff            mov    $0xffffffff,%ecx
Code;  c01efc57 <get_kobj_path_length+17/30>
  29:   89 d8                     mov    %ebx,%eax

This decode from eip onwards should be reliable

Code;  c01efc59 <get_kobj_path_length+19/30>
00000000 <_EIP>:
Code;  c01efc59 <get_kobj_path_length+19/30>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c01efc5b <get_kobj_path_length+1b/30>
   2:   f7 d1                     not    %ecx
Code;  c01efc5d <get_kobj_path_length+1d/30>
   4:   49                        dec    %ecx
Code;  c01efc5e <get_kobj_path_length+1e/30>
   5:   8b 52 24                  mov    0x24(%edx),%edx
Code;  c01efc61 <get_kobj_path_length+21/30>
   8:   8d 74 31 01               lea    0x1(%ecx,%esi,1),%esi
Code;  c01efc65 <get_kobj_path_length+25/30>
   c:   85 d2                     test   %edx,%edx
Code;  c01efc67 <get_kobj_path_length+27/30>
   e:   75 e7                     jne    fffffff7 <_EIP+0xfffffff7>
Code;  c01efc69 <get_kobj_path_length+29/30>
  10:   5b                        pop    %ebx
Code;  c01efc6a <get_kobj_path_length+2a/30>
  11:   89 f0                     mov    %esi,%eax
Code;  c01efc6c <get_kobj_path_length+2c/30>
  13:   5e                        pop    %esi
Code;  c01efc6d <get_kobj_path_length+2d/30>
  14:   5f                        pop    %edi


1 warning and 1 error issued.  Results may not be reliable.

--------------020002000105000906000806--

--------------enigB9254059EB35316E12E31682
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCXlaGi0HtPCVkDAURAte7AJ9wakHcpXZQCEnbYKihAVqAmC/cQQCffwKE
2cOrdoP+5QM8KyTZ2nnFkDQ=
=PCXv
-----END PGP SIGNATURE-----

--------------enigB9254059EB35316E12E31682--
