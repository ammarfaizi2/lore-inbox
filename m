Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319201AbSIGQdd>; Sat, 7 Sep 2002 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSIGQdd>; Sat, 7 Sep 2002 12:33:33 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:57230 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S319201AbSIGQd3>; Sat, 7 Sep 2002 12:33:29 -0400
Date: Sat, 7 Sep 2002 11:37:49 -0500
From: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi oops
Message-ID: <20020907163749.GA5985@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kernel 2.4.20-pre5-ac4 with the latest ACPI patches gives me an oops any
time I try to access the CD-ROM:

Note this also happened with pre4-ac1 so I don't think it's due to the
latest IDE merge in pre5-ac4.

p  7 11:12:24 localhost kernel: kernel BUG at /home/src/linux-2.4.20-pre5-a=
c4-acpi-tosh3kdsdt/include/linux/blkdev.h:153!
Sep  7 11:12:24 localhost kernel: invalid operand: 0000
Sep  7 11:12:24 localhost kernel: CPU:    0
Sep  7 11:12:24 localhost kernel: EIP:    0010:[<c01e6887>]    Tainted: P=
=20
Sep  7 11:12:24 localhost kernel: EFLAGS: 00010206
Sep  7 11:12:24 localhost kernel: eax: 00000059   ebx: c16cd000   ecx: dd37=
c2a0   edx: 00000001
Sep  7 11:12:24 localhost kernel: esi: c035c6b4   edi: dd37c2a0   ebp: 0000=
0000   esp: d7d21cc0
Sep  7 11:12:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 11:12:24 localhost kernel: Process wine (pid: 28825, stackpage=3Dd7d=
21000)
Sep  7 11:12:24 localhost kernel: Stack: 00000000 c16ca000 c01f11b0 0000000=
0 d7d21cd0 d7d21cd0 c16cd000 c035c6b4=20
Sep  7 11:12:24 localhost kernel:        dd37c2a0 00000000 c01e6b9f c035c6b=
4 dd37c2a0 dd37c2a0 00000000 c035c6b4=20
Sep  7 11:12:24 localhost kernel:        00000000 00000000 c035c764 0000000=
3 c035c6b4 c035c764 dd37c2a0 dd372000=20
Sep  7 11:12:24 localhost kernel: Call Trace:    [<c01f11b0>] [<c01e6b9f>] =
[<c01e7019>] [<e08f49bd>] [<c01e0b11>]
Sep  7 11:12:24 localhost kernel:   [<c01e0e35>] [<c01e140a>] [<c01f11b0>] =
[<e08f572b>] [<c01eb08c>] [<c01f11b0>]
Sep  7 11:12:24 localhost kernel:   [<c01f2b7c>] [<e1b9bda0>] [<c01d2fae>] =
[<c011adc9>] [<c0139a69>] [<c01283a7>]
Sep  7 11:12:24 localhost kernel:   [<c0127df6>] [<c0128744>] [<c013b975>] =
[<c0128b6c>] [<c0128a70>] [<c0135d76>]
Sep  7 11:12:24 localhost kernel:   [<c0135ccc>] [<c0106cb3>]
Sep  7 11:12:24 localhost kernel: Code: 0f 0b 99 00 c0 1a 28 c0 ba ff ff ff=
 ff 31 c0 85 d2 8b 5c 24=20

>>EIP; c01e6887 <ide_build_sglist+47/1a0>   <=3D=3D=3D=3D=3D
Trace; c01f11b0 <scsi_old_done+0/650>
Trace; c01e6b9f <ide_build_dmatable+5f/190>
Trace; c01e7019 <__ide_dma_read+29/110>
Trace; e08f49bd <[ide-cd]cdrom_decode_status+10d/250>
Trace; c01e0b11 <start_request+181/1e0>
Trace; c01e0e35 <ide_do_request+275/2c0>
Trace; c01e140a <ide_do_drive_cmd+da/110>
Trace; c01f11b0 <scsi_old_done+0/650>
Trace; e08f572b <[ide-cd]cdrom_pc_intr+1b/200>
Trace; c01eb08c <scsi_dispatch_cmd+24c/310>
Trace; c01f11b0 <scsi_old_done+0/650>
Trace; c01f2b7c <scsi_request_fn+31c/360>
Trace; e1b9bda0 <END_OF_CODE+f5861/????>
Trace; c01d2fae <generic_unplug_device+1e/30>
Trace; c011adc9 <__run_task_queue+49/60>
Trace; c0139a69 <block_sync_page+19/20>
Trace; c01283a7 <generic_file_readahead+117/160>
Trace; c0127df6 <___wait_on_page+86/b0>
Trace; c0128744 <do_generic_file_read+2f4/430>
Trace; c013b975 <blkdev_open+25/30>
Trace; c0128b6c <generic_file_read+7c/130>
Trace; c0128a70 <file_read_actor+0/80>
Trace; c0135d76 <sys_read+96/f0>
Trace; c0135ccc <sys_llseek+cc/e0>
Trace; c0106cb3 <system_call+33/38>
Code;  c01e6887 <ide_build_sglist+47/1a0>
00000000 <_EIP>:
Code;  c01e6887 <ide_build_sglist+47/1a0>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01e6889 <ide_build_sglist+49/1a0>
   2:   99                        cltd  =20
Code;  c01e688a <ide_build_sglist+4a/1a0>
   3:   00 c0                     add    %al,%al
Code;  c01e688c <ide_build_sglist+4c/1a0>
   5:   1a 28                     sbb    (%eax),%ch
Code;  c01e688e <ide_build_sglist+4e/1a0>
   7:   c0 ba ff ff ff ff 31      sarb   $0x31,0xffffffff(%edx)
Code;  c01e6895 <ide_build_sglist+55/1a0>
   e:   c0 85 d2 8b 5c 24 00      rolb   $0x0,0x245c8bd2(%ebp)

Sep  7 11:12:40 localhost kernel: Unable to handle kernel paging request at=
 virtual address 002fab1f
Sep  7 11:12:40 localhost kernel: c01141e2
Sep  7 11:12:40 localhost kernel: *pde =3D 00000000
Sep  7 11:12:40 localhost kernel: Oops: 0000
Sep  7 11:12:40 localhost kernel: CPU:    0
Sep  7 11:12:40 localhost kernel: EIP:    0010:[<c01141e2>]    Tainted: P=
=20
Sep  7 11:12:40 localhost kernel: EFLAGS: 00010002
Sep  7 11:12:40 localhost kernel: eax: c167f248   ebx: d7d21ef8   ecx: 002f=
ab1f   edx: 00000000
Sep  7 11:12:40 localhost kernel: esi: 00000000   edi: c167f248   ebp: d729=
1ea8   esp: d7291e94
Sep  7 11:12:40 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 11:12:40 localhost kernel: Process tcsh (pid: 28828, stackpage=3Dd72=
91000)
Sep  7 11:12:40 localhost kernel: Stack: 00000286 00000003 00000000 d41cd48=
0 bfff44e0 c1326894 c01250ce c1326894=20
Sep  7 11:12:40 localhost kernel:        d5bed4e0 d41cd480 bfff44e0 0000000=
1 c0125966 d41cd480 d5bed4e0 bfff44e0=20
Sep  7 11:12:40 localhost kernel:        d24f1fd0 0f82a045 00000000 0003000=
2 00000000 00000000 00000000 00000000=20
Sep  7 11:12:40 localhost kernel: Call Trace:    [<c01250ce>] [<c0125966>] =
[<c0112f39>] [<c01b955c>] [<c01bb0e6>]
Sep  7 11:12:40 localhost kernel:   [<c0120353>] [<c0112e20>] [<c0106da4>]
Sep  7 11:12:40 localhost kernel: Code: 8b 01 85 45 f0 74 e9 6a 00 51 e8 bf=
 f7 ff ff 5a 85 c0 59 74=20

>>EIP; c01141e2 <__wake_up+32/60>   <=3D=3D=3D=3D=3D
Trace; c01250ce <do_wp_page+4e/220>
Trace; c0125966 <handle_mm_fault+106/150>
Trace; c0112f39 <do_page_fault+119/42b>
Trace; c01b955c <tty_check_change+3c/70>
Trace; c01bb0e6 <tiocspgrp+66/90>
Trace; c0120353 <sys_rt_sigaction+93/f0>
Trace; c0112e20 <do_page_fault+0/42b>
Trace; c0106da4 <error_code+34/3c>
Code;  c01141e2 <__wake_up+32/60>
00000000 <_EIP>:
Code;  c01141e2 <__wake_up+32/60>   <=3D=3D=3D=3D=3D
   0:   8b 01                     mov    (%ecx),%eax   <=3D=3D=3D=3D=3D
Code;  c01141e4 <__wake_up+34/60>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c01141e7 <__wake_up+37/60>
   5:   74 e9                     je     fffffff0 <_EIP+0xfffffff0> c01141d=
2 <__wake_up+22/60>
Code;  c01141e9 <__wake_up+39/60>
   7:   6a 00                     push   $0x0
Code;  c01141eb <__wake_up+3b/60>
   9:   51                        push   %ecx
Code;  c01141ec <__wake_up+3c/60>
   a:   e8 bf f7 ff ff            call   fffff7ce <_EIP+0xfffff7ce> c01139b=
0 <try_to_wake_up+0/150>
Code;  c01141f1 <__wake_up+41/60>
   f:   5a                        pop    %edx
Code;  c01141f2 <__wake_up+42/60>
  10:   85 c0                     test   %eax,%eax
Code;  c01141f4 <__wake_up+44/60>
  12:   59                        pop    %ecx
Code;  c01141f5 <__wake_up+45/60>
  13:   74 00                     je     15 <_EIP+0x15> c01141f7 <__wake_up=
+47/60>

Sep  7 11:12:40 localhost kernel:  <1>Unable to handle kernel paging reques=
t at virtual address 002fab1f
Sep  7 11:12:40 localhost kernel: c01141e2
Sep  7 11:12:40 localhost kernel: *pde =3D 00000000
Sep  7 11:12:40 localhost kernel: Oops: 0000
Sep  7 11:12:40 localhost kernel: CPU:    0
Sep  7 11:12:40 localhost kernel: EIP:    0010:[<c01141e2>]    Tainted: P=
=20
Sep  7 11:12:40 localhost kernel: EFLAGS: 00010002
Sep  7 11:12:40 localhost kernel: eax: c167f248   ebx: d7d21ef8   ecx: 002f=
ab1f   edx: 00000000
Sep  7 11:12:40 localhost kernel: esi: 00000000   edi: c167f248   ebp: cb93=
9ea8   esp: cb939e94
Sep  7 11:12:40 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 11:12:40 localhost kernel: Process tcsh (pid: 23683, stackpage=3Dcb9=
39000)
Sep  7 11:12:40 localhost kernel: Stack: 00000286 00000003 00000001 dd18d78=
0 bfff4ffc c1326894 c01250ce c1326894=20
Sep  7 11:12:40 localhost kernel:        dcae2a80 dd18d780 bfff4ffc 0000000=
1 c0125966 dd18d780 dcae2a80 bfff4ffc=20
Sep  7 11:12:40 localhost kernel:        cea9bfd0 0f82a065 cb938000 0000001=
1 d19556e4 cb939fa0 c0106b81 00000011=20
Sep  7 11:12:40 localhost kernel: Call Trace:    [<c01250ce>] [<c0125966>] =
[<c0106b81>] [<c0112f39>] [<c01b955c>]
Sep  7 11:12:40 localhost kernel:   [<c01bb0e6>] [<c01bb4e8>] [<c0106065>] =
[<c01425d3>] [<c0112e20>] [<c0106da4>]
Sep  7 11:12:40 localhost kernel: Code: 8b 01 85 45 f0 74 e9 6a 00 51 e8 bf=
 f7 ff ff 5a 85 c0 59 74=20

>>EIP; c01141e2 <__wake_up+32/60>   <=3D=3D=3D=3D=3D
Trace; c01250ce <do_wp_page+4e/220>
Trace; c0125966 <handle_mm_fault+106/150>
Trace; c0106b81 <do_signal+221/270>
Trace; c0112f39 <do_page_fault+119/42b>
Trace; c01b955c <tty_check_change+3c/70>
Trace; c01bb0e6 <tiocspgrp+66/90>
Trace; c01bb4e8 <tty_ioctl+258/370>
Trace; c0106065 <restore_sigcontext+115/140>
Trace; c01425d3 <sys_ioctl+223/230>
Trace; c0112e20 <do_page_fault+0/42b>
Trace; c0106da4 <error_code+34/3c>
Code;  c01141e2 <__wake_up+32/60>
00000000 <_EIP>:
Code;  c01141e2 <__wake_up+32/60>   <=3D=3D=3D=3D=3D
   0:   8b 01                     mov    (%ecx),%eax   <=3D=3D=3D=3D=3D
Code;  c01141e4 <__wake_up+34/60>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c01141e7 <__wake_up+37/60>
   5:   74 e9                     je     fffffff0 <_EIP+0xfffffff0> c01141d=
2 <__wake_up+22/60>
Code;  c01141e9 <__wake_up+39/60>
   7:   6a 00                     push   $0x0
Code;  c01141eb <__wake_up+3b/60>
   9:   51                        push   %ecx
Code;  c01141ec <__wake_up+3c/60>
   a:   e8 bf f7 ff ff            call   fffff7ce <_EIP+0xfffff7ce> c01139b=
0 <try_to_wake_up+0/150>
Code;  c01141f1 <__wake_up+41/60>
   f:   5a                        pop    %edx
Code;  c01141f2 <__wake_up+42/60>
  10:   85 c0                     test   %eax,%eax
Code;  c01141f4 <__wake_up+44/60>
  12:   59                        pop    %ecx
Code;  c01141f5 <__wake_up+45/60>
  13:   74 00                     je     15 <_EIP+0x15> c01141f7 <__wake_up=
+47/60>

Sep  7 11:12:40 localhost kernel:  <1>Unable to handle kernel paging reques=
t at virtual address 002fab1f
Sep  7 11:12:40 localhost kernel: c01141e2
Sep  7 11:12:40 localhost kernel: *pde =3D 00000000
Sep  7 11:12:40 localhost kernel: Oops: 0000
Sep  7 11:12:40 localhost kernel: CPU:    0
Sep  7 11:12:40 localhost kernel: EIP:    0010:[<c01141e2>]    Tainted: P=
=20
Sep  7 11:12:40 localhost kernel: EFLAGS: 00010002
Sep  7 11:12:40 localhost kernel: eax: c167f248   ebx: d7d21ef8   ecx: 002f=
ab1f   edx: 00000000
Sep  7 11:12:40 localhost kernel: esi: 00000000   edi: c167f248   ebp: d687=
1ea8   esp: d6871e94
Sep  7 11:12:40 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 11:12:40 localhost kernel: Process Eterm (pid: 23651, stackpage=3Dd6=
871000)
Sep  7 11:12:40 localhost kernel: Stack: 00000286 00000003 00000001 dd18da0=
0 4018981c c111bb7c c01250ce c111bb7c=20
Sep  7 11:12:40 localhost kernel:        d9bb6ae0 dd18da00 4018981c 0000000=
1 c0125966 dd18da00 d9bb6ae0 4018981c=20
Sep  7 11:12:40 localhost kernel:        c9f20624 0574c065 000132f1 c0125bc=
c 0001ef80 c0275bc1 d5bedeb8 dd18d784=20
Sep  7 11:12:40 localhost kernel: Call Trace:    [<c01250ce>] [<c0125966>] =
[<c0125bcc>] [<c0275bc1>] [<c0112f39>]
Sep  7 11:12:40 localhost kernel:   [<c0115781>] [<c01305e7>] [<c0120353>] =
[<c0119d36>] [<c0112e20>] [<c0106da4>]
Sep  7 11:12:40 localhost kernel: Code: 8b 01 85 45 f0 74 e9 6a 00 51 e8 bf=
 f7 ff ff 5a 85 c0 59 74=20

>>EIP; c01141e2 <__wake_up+32/60>   <=3D=3D=3D=3D=3D
Trace; c01250ce <do_wp_page+4e/220>
Trace; c0125966 <handle_mm_fault+106/150>
Trace; c0125bcc <vm_enough_memory+2c/c0>
Trace; c0275bc1 <rb_insert_color+c1/f0>
Trace; c0112f39 <do_page_fault+119/42b>
Trace; c0115781 <copy_mm+281/300>
Trace; c01305e7 <__alloc_pages+67/2f0>
Trace; c0120353 <sys_rt_sigaction+93/f0>
Trace; c0119d36 <sys_wait4+396/3a0>
Trace; c0112e20 <do_page_fault+0/42b>
Trace; c0106da4 <error_code+34/3c>
Code;  c01141e2 <__wake_up+32/60>
00000000 <_EIP>:
Code;  c01141e2 <__wake_up+32/60>   <=3D=3D=3D=3D=3D
   0:   8b 01                     mov    (%ecx),%eax   <=3D=3D=3D=3D=3D
Code;  c01141e4 <__wake_up+34/60>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c01141e7 <__wake_up+37/60>
   5:   74 e9                     je     fffffff0 <_EIP+0xfffffff0> c01141d=
2 <__wake_up+22/60>
Code;  c01141e9 <__wake_up+39/60>
   7:   6a 00                     push   $0x0
Code;  c01141eb <__wake_up+3b/60>
   9:   51                        push   %ecx
Code;  c01141ec <__wake_up+3c/60>
   a:   e8 bf f7 ff ff            call   fffff7ce <_EIP+0xfffff7ce> c01139b=
0 <try_to_wake_up+0/150>
Code;  c01141f1 <__wake_up+41/60>
   f:   5a                        pop    %edx
Code;  c01141f2 <__wake_up+42/60>
  10:   85 c0                     test   %eax,%eax
Code;  c01141f4 <__wake_up+44/60>
  12:   59                        pop    %ecx
Code;  c01141f5 <__wake_up+45/60>
  13:   74 00                     je     15 <_EIP+0x15> c01141f7 <__wake_up=
+47/60>

Sep  7 11:15:48 localhost kernel: cpu: 0, clocks: 1328880, slice: 664440
Sep  7 11:15:57 localhost kernel: 8139too Fast Ethernet driver 0.9.26
Sep  7 11:15:58 localhost kernel: ac97_codec: AC97 Audio codec, id: CRY52(C=
irrus Logic CS4299=20

(Yes I know it's tainted, but it looks like clearly IDE's fault.  Poke me if
you want to see the same oops without me loading the NVidia driver.)

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj16K10ACgkQjwioWRGe9K1JCgCg1wAAmSIce5AzC+DIpHsmxBpZ
5DEAni4Zy26pxwGw7DaGrOf1+b297ibL
=sprK
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
