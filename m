Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRIJL0q>; Mon, 10 Sep 2001 07:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270585AbRIJL0i>; Mon, 10 Sep 2001 07:26:38 -0400
Received: from p3EE0E924.dip.t-dialin.net ([62.224.233.36]:1030 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S270646AbRIJL01> convert rfc822-to-8bit;
	Mon, 10 Sep 2001 07:26:27 -0400
Message-ID: <3B9CA37F.22D7B20@baldauf.org>
Date: Mon, 10 Sep 2001 13:26:55 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: [OOPS] at smbfs umount in linux-2.4.10-pre5
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this oops just happened now when trying to unmount an smbfs
mount entry

router|13:15:49|~> dmesg |ksymoops -m
/usr/src/linux/System.map
ksymoops 2.4.1 on i586 2.4.10-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre4/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): mismatch on symbol packet_socks_nr
, af_packet says c52a6d48,
/lib/modules/2.4.10-pre4/kernel/net/packet/af_packet.o says
c52a6b24.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/packet/af_packet.o entry

Warning (compare_maps): mismatch on symbol icmpv6_socket  ,
ipv6 says c52400a0,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523de20.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol
icmpv6_statistics  , ipv6 says c523ffa0,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523dd20.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_dev_count
, ipv6 says c523fc00,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523d980.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_ifa_count
, ipv6 says c523fc04,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523d984.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_protos  ,
ipv6 says c523ff20,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523dca0.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inetsw6  , ipv6
says c523fba0,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523d920.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ip6_ra_chain  ,
ipv6 says c523fe40,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523dbc0.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ipv6_statistics
, ipv6 says c523fd80,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523db00.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw_v6_htable  ,
ipv6 says c523fea0,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523dc20.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol rt6_stats  , ipv6
says c523fd4c,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523dacc.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp_stats_in6  ,
ipv6 says c523fe60,
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o says
c523dbe0.  Ignoring
/lib/modules/2.4.10-pre4/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol floppy  , floppy
says c51033b8,
/lib/modules/2.4.10-pre4/kernel/drivers/block/floppy.o says
c5102738.  Ignoring
/lib/modules/2.4.10-pre4/kernel/drivers/block/floppy.o entry

Unable to handle kernel NULL pointer dereference at virtual
address 00000008
c013033e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013033e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: c4202000   edx:
c14cfa20
esi: c227fc00   edi: c529a140   ebp: c227fc44   esp:
c4203f20
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 7077, stackpage=c4203000)
Stack: c227fccc c227fc00 c529a140 c227fc44 c52970ea c227fccc
c227fccc c227fc00
       c4231a40 c0134a24 c227fc00 c113a420 c227fc00 c024ebd4
08054418 c529a250
       c0133a3b c227fc00 c1137f34 c113a420 c4203f98 00000000
c013940f c113a420
Call Trace: [<c529a140>] [<c52970ea>] [<c0134a24>]
[<c529a250>] [<c0133a3b>]
   [<c013940f>] [<c0134e28>] [<c0122011>] [<c0134e60>]
[<c0106b63>]
Code: 8b 6b 08 8b 73 0c 8b 7d 08 ff 4b 14 0f 94 c0 84 c0 0f
84 9c

>>EIP; c013033e <fput+6/c0>   <=====
Trace; c529a140 <[smbfs]smb_sops+0/40>
Trace; c52970ea <[smbfs]smb_put_super+26/a8>
Trace; c0134a24 <kill_super+a4/148>
Trace; c529a250 <[smbfs]smb_fs_type+0/30>
Trace; c0133a3b <__mntput+37/40>
Trace; c013940f <path_release+27/2c>
Trace; c0134e28 <sys_umount+c0/ec>
Trace; c0122011 <sys_munmap+35/54>
Trace; c0134e60 <sys_oldumount+c/10>
Trace; c0106b63 <system_call+33/40>
Code;  c013033e <fput+6/c0>
00000000 <_EIP>:
Code;  c013033e <fput+6/c0>   <=====
   0:   8b 6b 08                  mov    0x8(%ebx),%ebp
<=====
Code;  c0130341 <fput+9/c0>
   3:   8b 73 0c                  mov    0xc(%ebx),%esi
Code;  c0130344 <fput+c/c0>
   6:   8b 7d 08                  mov    0x8(%ebp),%edi
Code;  c0130347 <fput+f/c0>
   9:   ff 4b 14                  decl   0x14(%ebx)
Code;  c013034a <fput+12/c0>
   c:   0f 94 c0                  sete   %al
Code;  c013034d <fput+15/c0>
   f:   84 c0                     test   %al,%al
Code;  c013034f <fput+17/c0>
  11:   0f 84 9c 00 00 00         je     b3 <_EIP+0xb3>
c01303f1 <fput+b9/c0>


13 warnings issued.  Results may not be reliable.
router|13:16:35|~>

Here is what I can find at the syslog:

Sep 10 13:08:40 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:40 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:41 router kernel: smb_retry: successful, new
pid=1078, generation=2
Sep 10 13:08:41 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:41 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:42 router kernel: smb_retry: successful, new
pid=1078, generation=3
Sep 10 13:08:42 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:42 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:42 router kernel: smb_retry: successful, new
pid=1078, generation=4
Sep 10 13:08:42 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:42 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:42 router kernel: smb_retry: successful, new
pid=1078, generation=5
Sep 10 13:08:42 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:42 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:42 router kernel: smb_retry: successful, new
pid=1078, generation=6
Sep 10 13:08:42 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:42 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:43 router kernel: smb_retry: successful, new
pid=1078, generation=7
Sep 10 13:08:43 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:43 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:43 router kernel: smb_retry: successful, new
pid=1078, generation=8
Sep 10 13:08:43 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:43 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:43 router kernel: smb_retry: successful, new
pid=1078, generation=9
Sep 10 13:08:43 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:43 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:44 router kernel: smb_lookup: find
//autoexec.bat failed, error=-5
Sep 10 13:08:44 router kernel: smb_retry: successful, new
pid=1078, generation=10
Sep 10 13:08:44 router kernel: smb_get_length: recv error =
512
Sep 10 13:08:44 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/mmx
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find
lib/libpthread.so.0 failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/mmx
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find
lib/libnsl.so.1 failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/mmx
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find
lib/libdl.so.2 failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/mmx
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find
lib/libc.so.6 failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find lib/mmx
failed, error=-5
Sep 10 13:08:45 router kernel: smb_lookup: find
lib/libm.so.6 failed, error=-5
Sep 10 13:08:46 router kernel: smb_lookup: find lib/bin
failed, error=-5
Sep 10 13:08:46 router kernel: smb_lookup: find lib/bin
failed, error=-5
Sep 10 13:08:47 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:47 router kernel: smb_lookup: find lib/i586
failed, error=-5
Sep 10 13:08:47 router kernel: smb_lookup: find lib/mmx
failed, error=-5
Sep 10 13:08:47 router kernel: smb_lookup: find
lib/libnss_compat.so.2 failed, error=-5
Sep 10 13:08:47 router kernel: smb_lookup: find lib/bin
failed, error=-5
Sep 10 13:08:48 router kernel: smb_lookup: find lib/bin
failed, error=-5
Sep 10 13:09:14 router kernel: smb_retry: successful, new
pid=1078, generation=11
Sep 10 13:09:14 router kernel: smb_get_length: recv error =
512
Sep 10 13:09:14 router kernel: smb_request: result -512,
setting invalid
Sep 10 13:09:52 router kernel: smb_dont_catch_keepalive: did
not get valid server!
Sep 10 13:09:52 router kernel: Unable to handle kernel NULL
pointer dereference at virtual address 00000008
Sep 10 13:09:52 router kernel:  printing eip:
Sep 10 13:09:52 router kernel: c013033e
Sep 10 13:09:52 router kernel: *pde = 00000000
Sep 10 13:09:52 router kernel: Oops: 0000
Sep 10 13:09:52 router kernel: CPU:    0
Sep 10 13:09:52 router kernel: EIP:    0010:[fput+6/192]
Sep 10 13:09:52 router kernel: EFLAGS: 00010286
Sep 10 13:09:52 router kernel: eax: 00000000   ebx:
00000000   ecx: c4202000   edx: c14cfa20
Sep 10 13:09:52 router kernel: esi: c227fc00   edi:
c529a140   ebp: c227fc44   esp: c4203f20
Sep 10 13:09:52 router kernel: ds: 0018   es: 0018   ss:
0018
Sep 10 13:09:52 router kernel: Process umount (pid: 7077,
stackpage=c4203000)
Sep 10 13:09:52 router kernel: Stack: c227fccc c227fc00
c529a140 c227fc44 c52970ea c227fccc c227fccc c227fc00
Sep 10 13:09:52 router kernel:        c4231a40 c0134a24
c227fc00 c113a420 c227fc00 c024ebd4 08054418 c529a250
Sep 10 13:09:52 router kernel:        c0133a3b c227fc00
c1137f34 c113a420 c4203f98 00000000 c013940f c113a420
Sep 10 13:09:52 router kernel: Call Trace:
[eepro100:__insmod_eepro100_S.bss_L16+508424/66207788]
[eepro100:__insmod_eepro100_S.bss_L16+496050/66220162]
[kill_super+164/328]
[eepro100:__insmod_eepro100_S.bss_L16+508696/66207516]
[__mntput+55/64]
Sep 10 13:09:52 router kernel:    [path_release+39/44]
[sys_umount+192/236] [sys_munmap+53/84]
[sys_oldumount+12/16] [system_call+51/64]
Sep 10 13:09:52 router kernel:
Sep 10 13:09:52 router kernel: Code: 8b 6b 08 8b 73 0c 8b 7d
08 ff 4b 14 0f 94 c0 84 c0 0f 84 9c

Trying to remount the same smb share at the same mount point
fails. Strace shows that the mount process is stuck in the
"mount" call. Also trying to mount the same samba share at
another mount point hangs.

Xuân.


