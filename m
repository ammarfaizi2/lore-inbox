Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSGINX2>; Tue, 9 Jul 2002 09:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGINX1>; Tue, 9 Jul 2002 09:23:27 -0400
Received: from [62.70.58.70] ([62.70.58.70]:390 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315267AbSGINXX>;
	Tue, 9 Jul 2002 09:23:23 -0400
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: panic at boot with 2.5.25 with Jens's IDE patch
Date: Tue, 9 Jul 2002 15:26:14 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QBHZV0BL8LWE7BB57X6E"
Message-Id: <200207091526.14703.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QBHZV0BL8LWE7BB57X6E
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi all

running (or trying to boot) 2.5.25, I get this little, cute panic :-)

Attached is .config.gz in case anyone would want to see it.

please tell me if more info is needed.

roy
--
ksymoops 2.4.5 on i686 2.4.19-pre10-ac2.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.19-pre10-ac2/ (default)
     -m System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 1c9f9490
c0158a1f
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0158a1f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 1c9f9490   ebx: 00000006   ecx: 00000006   edx: 00000000
esi: 00000000   edi: ffffffff   ebp: f72641c0   esp: f7687ddc
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 c03a6900 c0347908 c010a62c f7686000 c03c73a0 c03b1aca f76=
86000=20
       c01090d9 000f417f 00000005 000003fd c03c73a0 c03c73a0 00000005 c03=
c7320=20
       00000018 00000018 ffffffef c0202d85 00000010 00000202 c0207848 c03=
c73a0=20
Call Trace: [<c010a62c>] [<c01090d9>] [<c0202d85>] [<c0207848>] [<c01194c=
6>]=20
   [<c0137549>] [<c013b84b>] [<c014b93a>] [<c013f543>] [<c0158e5d>]=20
[<c022a233>]
   [<c023aacf>] [<c0158fab>] [<c0152100>] [<c022b7b8>] [<c0105000>]=20
[<c0105029>]
   [<c0105000>] [<c01070d6>] [<c0105020>]=20
Code: 8b 34 90 8b 84 24 24 01 00 00 8b 48 20 85 c9 74 0d 8b 2c 91=20


>>EIP; c0158a1f <driverfs_create_partitions+2f/200>   <=3D=3D=3D=3D=3D

>>eax; 1c9f9490 Before first symbol
>>edi; ffffffff <END_OF_CODE+3fc11503/????>
>>ebp; f72641c0 <END_OF_CODE+36e756c4/????>
>>esp; f7687ddc <END_OF_CODE+372992e0/????>

Trace; c010a62c <do_IRQ+9c/b0>
Trace; c01090d9 <apic_timer_interrupt+21/28>
Trace; c0202d85 <serial_in+25/30>
Trace; c0207848 <serial_console_write+168/1e0>
Trace; c01194c6 <__call_console_drivers+46/60>
Trace; c0137549 <mempool_free+49/50>
Trace; c013b84b <invalidate_inode_buffers+b/50>
Trace; c014b93a <clear_inode+7a/b0>
Trace; c013f543 <bdput+93/a0>
Trace; c0158e5d <check_partition+1ad/1e0>
Trace; c022a233 <ide_raw_taskfile+13/20>
Trace; c023aacf <write_cache+5f/80>
Trace; c0158fab <grok_partitions+db/130>
Trace; c0152100 <load_elf_interp+20/2f0>
Trace; c022b7b8 <ide_geninit+68/90>
Trace; c0105000 <_stext+0/0>
Trace; c0105029 <init+9/140>
Trace; c0105000 <_stext+0/0>
Trace; c01070d6 <kernel_thread+26/30>
Trace; c0105020 <init+0/140>

Code;  c0158a1f <driverfs_create_partitions+2f/200>
00000000 <_EIP>:
Code;  c0158a1f <driverfs_create_partitions+2f/200>   <=3D=3D=3D=3D=3D
   0:   8b 34 90                  mov    (%eax,%edx,4),%esi   <=3D=3D=3D=3D=
=3D
Code;  c0158a22 <driverfs_create_partitions+32/200>
   3:   8b 84 24 24 01 00 00      mov    0x124(%esp,1),%eax
Code;  c0158a29 <driverfs_create_partitions+39/200>
   a:   8b 48 20                  mov    0x20(%eax),%ecx
Code;  c0158a2c <driverfs_create_partitions+3c/200>
   d:   85 c9                     test   %ecx,%ecx
Code;  c0158a2e <driverfs_create_partitions+3e/200>
   f:   74 0d                     je     1e <_EIP+0x1e> c0158a3d=20
<driverfs_create_partitions+4d/200>
Code;  c0158a30 <driverfs_create_partitions+40/200>
  11:   8b 2c 91                  mov    (%ecx,%edx,4),%ebp

 <0>Kernel panic: Attempted to kill init!
--=20
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_QBHZV0BL8LWE7BB57X6E
Content-Type: application/x-gzip;
  name=".config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=".config.gz"

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

--------------Boundary-00=_QBHZV0BL8LWE7BB57X6E--

