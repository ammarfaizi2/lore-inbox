Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161455AbWJ0EWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161455AbWJ0EWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWJ0EWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:22:48 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:49085 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161455AbWJ0EWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:22:47 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc* and oprofile issues
Date: Fri, 27 Oct 2006 06:23:11 +0200
User-Agent: KMail/1.9.5
Cc: oprofile-list@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2329980.Ly9JSC48hV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610270623.14741.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2329980.Ly9JSC48hV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I can't seem to get oprofile (0.9.2) working with current rc kernels an my=
=20
AMD64 platform. All works out of the box with 2.6.18 and earlier.

LC_ALL=3DC opcontrol -s
/usr/bin/opcontrol: line 994: /dev/oprofile/0/enabled: No such file or=20
directory
/usr/bin/opcontrol: line 994: /dev/oprofile/0/event: No such file or direct=
ory
/usr/bin/opcontrol: line 994: /dev/oprofile/0/count: No such file or direct=
ory
/usr/bin/opcontrol: line 994: /dev/oprofile/0/kernel: No such file or=20
directory
/usr/bin/opcontrol: line 994: /dev/oprofile/0/user: No such file or directo=
ry
/usr/bin/opcontrol: line 994: /dev/oprofile/0/unit_mask: No such file or=20
directory
Using 2.6+ OProfile kernel interface.
Using log file /var/lib/oprofile/oprofiled.log
Daemon started.
Profiler running.

ll /dev/oprofile/
insgesamt 0
drwxr-xr-x 1 root root 0 27. Okt 06:06 1
drwxr-xr-x 1 root root 0 27. Okt 06:06 2
drwxr-xr-x 1 root root 0 27. Okt 06:06 3
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 backtrace_depth
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 buffer
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 buffer_size
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 buffer_watershed
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 cpu_buffer_size
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 cpu_type
=2Drw-rw-rw- 1 root root 0 27. Okt 06:06 dump
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 enable
=2Drw-r--r-- 1 root root 0 27. Okt 06:06 pointer_size
drwxr-xr-x 1 root root 0 27. Okt 06:06 stats

So why isn't there a "0" directory?

If I try to use 1 by setting

CHOSEN_EVENTS_1=3DCPU_CLK_UNHALTED:100000:0:1:1
NR_CHOSEN=3D1

in daemonrc, I get:

No events given.

Am I doing something wrong or had the rc kernel something changed so that I=
=20
need trunk version of oprofile? Or is something broken in kernel module?

dmesg + .config
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-4.txt.bz2

cat /proc/interrupts for 2.6.19-rc1
http://www.prakash.gmxhome.de/linux/irqs19.txt

lspci can be found here:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D2

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2329980.Ly9JSC48hV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFQYmyxU2n/+9+t5gRAmq7AKDpyTELNhYy67vtR54kpGZVt2ik4ACfV39B
ITXR5ohFLWhd9/VgbyEQnEw=
=Ps8d
-----END PGP SIGNATURE-----

--nextPart2329980.Ly9JSC48hV--
