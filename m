Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbTFLMmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbTFLMmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:42:49 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:2675 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264751AbTFLMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:42:46 -0400
Date: Thu, 12 Jun 2003 08:56:30 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.70-bk16: nfs crash
To: linux-kernel@vger.kernel.org
Message-id: <20030612125630.GA19842@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=qMm9M+Fa2AknHoGS;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

running 2.5.70-bk16, i got this error and hang.  sysrq worked for
reboot, etc.

it apparently crashed when it mounted an nfs export from a 2.4.18 box,
and tried to mv a file.  i doubt it matters, but the nic is an
orinoco_cs wireless card.  thanks.

Jun 12 02:00:04 density kernel: Unable to handle kernel NULL pointer derefe=
rence at virtual address 00000000
Jun 12 02:00:04 density kernel: printing eip:
Jun 12 02:00:04 density kernel: c0169ef1
Jun 12 02:00:04 density kernel: *pde =3D 00000000
Jun 12 02:00:04 density kernel: Oops: 0002 [#1]
Jun 12 02:00:04 density kernel: CPU:    0
Jun 12 02:00:04 density kernel: EIP:    0060:[<c0169ef1>]    Not tainted
Jun 12 02:00:04 density kernel: EFLAGS: 00010246
Jun 12 02:00:04 density kernel: EIP is at d_move+0x51/0x250
Jun 12 02:00:04 density kernel: eax: 00000000   ebx: cd5e6960   ecx: cd5e69=
d0   edx: 00000000
Jun 12 02:00:04 density kernel: esi: cd2b4440   edi: cfdb4af4   ebp: cd087e=
4c   esp: cd087e20
Jun 12 02:00:04 density kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 02:00:04 density kernel: Process mv (pid: 4960, threadinfo=3Dcd08600=
0 task=3Dd41681a0)
Jun 12 02:00:04 density kernel: Stack: cdf4a508 cd5e69dc 0000000e cdf4a508 =
cd087e70 00000014 d8bf416d cdf4a6a0=20
Jun 12 02:00:04 density kernel: cd087e70 cd2b4440 cdf4a614 cd087ebc d8bf1ce=
7 cd5e6960 cd2b4440 cdf4a614=20
Jun 12 02:00:04 density kernel: cd087ea0 00000001 00000108 d78f0c98 73666e2=
e 30303030 31313030 30303030=20
Jun 12 02:00:04 density kernel: Call Trace:
Jun 12 02:00:04 density kernel: [<d8bf416d>] nfs_zap_caches+0x5d/0xd0 [nfs]
Jun 12 02:00:04 density kernel: [<d8bf1ce7>] nfs_sillyrename+0x197/0x220 [n=
fs]
Jun 12 02:00:04 density kernel: [<d8bf259c>] nfs_rename+0x20c/0x2b0 [nfs]
Jun 12 02:00:04 density kernel: [<c0161f50>] vfs_rename_other+0xc0/0x120
Jun 12 02:00:04 density kernel: [<d8bf2390>] nfs_rename+0x0/0x2b0 [nfs]
Jun 12 02:00:04 density kernel: [<c016213d>] vfs_rename+0x18d/0x3a0
Jun 12 02:00:04 density kernel: [<c01624f3>] sys_rename+0x1a3/0x1d0
Jun 12 02:00:04 density kernel: [<c01093cb>] syscall_call+0x7/0xb
Jun 12 02:00:04 density kernel:=20
Jun 12 02:00:04 density kernel: Code: 89 02 74 03 89 50 04 c7 43 70 00 01 1=
0 00 c7 41 04 00 02 20=20
Jun 12 02:00:04 density kernel: <6>note: mv[4960] exited with preempt_count=
 5
Jun 12 02:00:04 density kernel: bad: scheduling while atomic!
Jun 12 02:00:04 density kernel: Call Trace:
Jun 12 02:00:04 density kernel: [<c0116d32>] schedule+0x3c2/0x3d0
Jun 12 02:00:04 density kernel: [<c01d5576>] __copy_from_user_ll+0x66/0x70
Jun 12 02:00:04 density kernel: [<c0135a06>] unlock_page+0x16/0x50
Jun 12 02:00:04 density kernel: [<c0137e95>] generic_file_aio_write_nolock+=
0x5f5/0xba0
Jun 12 02:00:04 density kernel: [<c01384b8>] generic_file_write_nolock+0x78=
/0x90
Jun 12 02:00:04 density kernel: [<c0225658>] vt_console_print+0x1e8/0x2f0
Jun 12 02:00:04 density kernel: [<c011a8de>] __call_console_drivers+0x5e/0x=
60
Jun 12 02:00:04 density kernel: [<c011a9b5>] call_console_drivers+0x65/0x120
Jun 12 02:00:04 density kernel: [<c01385b5>] generic_file_write+0x55/0x70
Jun 12 02:00:04 density kernel: [<c01af270>] reiserfs_file_write+0x50/0x652
Jun 12 02:00:04 density kernel: [<c02465f2>] vgacon_scroll+0x192/0x250
Jun 12 02:00:04 density kernel: [<c0245243>] vgacon_cursor+0xe3/0x1e0
Jun 12 02:00:04 density kernel: [<c0121ae1>] mod_timer+0x131/0x190
Jun 12 02:00:04 density kernel: [<c0132ea0>] check_free_space+0x100/0x190
Jun 12 02:00:04 density kernel: [<c022638b>] poke_blanked_console+0x6b/0x80
Jun 12 02:00:04 density kernel: [<c022567d>] vt_console_print+0x20d/0x2f0
Jun 12 02:00:04 density kernel: [<c01162e9>] try_to_wake_up+0xa9/0x150
Jun 12 02:00:04 density kernel: [<c0116dba>] default_wake_function+0x2a/0x30
Jun 12 02:00:04 density kernel: [<c013346a>] do_acct_process+0x27a/0x290
Jun 12 02:00:04 density kernel: [<c0114820>] do_page_fault+0x0/0x4cd
Jun 12 02:00:04 density kernel: [<c01334b9>] acct_process+0x39/0x61
Jun 12 02:00:04 density kernel: [<c011c81d>] do_exit+0x8d/0x460
Jun 12 02:00:04 density kernel: [<c0114820>] do_page_fault+0x0/0x4cd
Jun 12 02:00:04 density kernel: [<c0109c01>] die+0xe1/0xf0
Jun 12 02:00:04 density kernel: [<c011494f>] do_page_fault+0x12f/0x4cd
Jun 12 02:00:04 density kernel: [<d8c12988>] nfs_procedures+0x108/0x1b0 [nf=
s]
Jun 12 02:00:04 density kernel: [<d8babc70>] rpc_run_timer+0x0/0x80 [sunrpc]
Jun 12 02:00:04 density kernel: [<c0114820>] do_page_fault+0x0/0x4cd
Jun 12 02:00:04 density kernel: [<c0109575>] error_code+0x2d/0x38
Jun 12 02:00:04 density kernel: [<c0169ef1>] d_move+0x51/0x250
Jun 12 02:00:04 density kernel: [<d8bf416d>] nfs_zap_caches+0x5d/0xd0 [nfs]
Jun 12 02:00:04 density kernel: [<d8bf1ce7>] nfs_sillyrename+0x197/0x220 [n=
fs]
Jun 12 02:00:04 density kernel: [<d8bf259c>] nfs_rename+0x20c/0x2b0 [nfs]
Jun 12 02:00:04 density kernel: [<c0161f50>] vfs_rename_other+0xc0/0x120
Jun 12 02:00:04 density kernel: [<d8bf2390>] nfs_rename+0x0/0x2b0 [nfs]
Jun 12 02:00:04 density kernel: [<c016213d>] vfs_rename+0x18d/0x3a0
Jun 12 02:00:04 density kernel: [<c01624f3>] sys_rename+0x1a3/0x1d0
Jun 12 02:00:04 density kernel: [<c01093cb>] syscall_call+0x7/0xb
Jun 12 02:00:04 density kernel:=20

some info about the build environment:
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6Hh+CGPRljI8080RAiqqAJwL2IbQAPWtWO9zPhhBkHPcuF2P1wCfY0qU
JX91e9CQhSyJd9OyZBZRoEk=
=di4m
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
