Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbTHRL1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTHRL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:27:34 -0400
Received: from NeverAgain.DE ([217.69.76.1]:10142 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S271401AbTHRL1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:27:30 -0400
Date: Mon, 18 Aug 2003 13:27:17 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI related problems on an Acer TravelMate 800LCi
Message-ID: <20030818112717.GA1688@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I am encoutering ACPI related problems with 2.6.0-test3 and my Acer TravelM=
ate
800 LCi. Everytime I try to send it to suspend mode ('echo 3 > /proc/acpi/s=
leep'),=20
the following lines appears in syslog and the box does not suspend at all:

Aug 18 13:07:34 eurydice kernel: Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Aug 18 13:07:34 eurydice kernel: hda: start_power_step(step: 0)
Aug 18 13:07:34 eurydice kernel: hda: start_power_step(step: 1)
Aug 18 13:07:34 eurydice kernel: hda: complete_power_step(step: 1, stat: 50=
, err: 0)
Aug 18 13:07:34 eurydice kernel: hda: completing PM request, suspend
Aug 18 13:07:34 eurydice kernel: [ACPI Debug] String: >>>> _PTS ------------
Aug 18 13:07:34 eurydice kernel: [ACPI Debug] Integer: 0000000000000003
Aug 18 13:07:34 eurydice kernel: ACPI: don't know how to handle 3 state.
Aug 18 13:07:34 eurydice kernel: Back to C!
Aug 18 13:07:34 eurydice kernel: [ACPI Debug] String: >>>> _WAK ------------
Aug 18 13:07:34 eurydice kernel: [ACPI Debug] Integer: 0000000000000003
Aug 18 13:07:34 eurydice kernel: PCI: Setting latency timer of device 0000:=
00:1f.5 to 64
Aug 18 13:07:34 eurydice kernel: hda: Wakeup request inited, waiting for !B=
SY...
Aug 18 13:07:34 eurydice kernel: hda: start_power_step(step: 1000)
Aug 18 13:07:34 eurydice kernel: blk: queue dfd02c00, I/O limit 4095Mb (mas=
k 0xffffffff)
Aug 18 13:07:34 eurydice kernel: hda: completing PM request, resume
Aug 18 13:07:34 eurydice kernel: Restarting tasks... done

After doing the same command another time, I saw the following in syslog af=
ter
reboot (the box locked up hard when I tried to start X):

Aug 18 13:12:38 eurydice kernel: Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Aug 18 13:12:38 eurydice kernel: hda: start_power_step(step: 0)
Aug 18 13:12:38 eurydice kernel: hda: start_power_step(step: 1)
Aug 18 13:12:38 eurydice kernel: hda: complete_power_step(step: 1, stat: 50=
, err: 0)
Aug 18 13:12:38 eurydice kernel: hda: completing PM request, suspend
Aug 18 13:12:38 eurydice kernel: Debug: sleeping function called from inval=
id context at include/linux/rwsem.h:66
Aug 18 13:12:38 eurydice kernel: Call Trace:
Aug 18 13:12:38 eurydice kernel:  [__might_sleep+95/116] __might_sleep+0x5f=
/0x74
Aug 18 13:12:38 eurydice kernel:  [device_suspend+36/236] device_suspend+0x=
24/0xec
Aug 18 13:12:38 eurydice kernel:  [acpi_save_state_mem+105/109] acpi_save_s=
tate_mem+0x69/0x6d
Aug 18 13:12:38 eurydice kernel:  [acpi_system_save_state+104/138] acpi_sys=
tem_save_state+0x68/0x8a
Aug 18 13:12:38 eurydice kernel:  [acpi_suspend+111/191] acpi_suspend+0x6f/=
0xbf
Aug 18 13:12:38 eurydice kernel:  [acpi_system_write_sleep+239/293] acpi_sy=
stem_write_sleep+0xef/0x125
Aug 18 13:12:38 eurydice kernel:  [acpi_system_write_sleep+0/293] acpi_syst=
em_write_sleep+0x0/0x125
Aug 18 13:12:38 eurydice kernel:  [vfs_write+161/268] vfs_write+0xa1/0x10c
Aug 18 13:12:38 eurydice kernel:  [sys_write+63/93] sys_write+0x3f/0x5d
Aug 18 13:12:38 eurydice kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 18 13:12:38 eurydice kernel:
Aug 18 13:12:38 eurydice kernel: [ACPI Debug] String: >>>> _PTS ------------
Aug 18 13:12:38 eurydice kernel: [ACPI Debug] Integer: 0000000000000003
Aug 18 13:12:38 eurydice kernel: ACPI: don't know how to handle 3 state.
Aug 18 13:12:38 eurydice kernel: Back to C!
Aug 18 13:12:38 eurydice kernel: [ACPI Debug] String: >>>> _WAK ------------
Aug 18 13:12:38 eurydice kernel: [ACPI Debug] Integer: 0000000000000003
Aug 18 13:12:38 eurydice kernel: PCI: Setting latency timer of device 0000:=
00:1f.5 to 64
Aug 18 13:12:38 eurydice kernel: hda: Wakeup request inited, waiting for !B=
SY...
Aug 18 13:12:38 eurydice kernel: hda: start_power_step(step: 1000)
Aug 18 13:12:38 eurydice kernel: hda: completing PM request, resume
Aug 18 13:12:38 eurydice kernel: Restarting tasks... done

I would also have tried 2.6.0-test3-bk5 but somehow the ACPI menu disappear=
ed
with that version and .config does not even have something ACPI specific in=
 it.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/QLgVHPo+jNcUXjARAh+cAJ9lWOZnb7JYmKSJG/H3WpmpBsMkrACbBgU2
udP8RCN3u68t7DD5j0U2AEw=
=oDKd
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
