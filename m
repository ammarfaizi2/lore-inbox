Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267626AbSLSMcz>; Thu, 19 Dec 2002 07:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267627AbSLSMcy>; Thu, 19 Dec 2002 07:32:54 -0500
Received: from diamond.madduck.net ([66.92.234.132]:9488 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP
	id <S267626AbSLSMcx>; Thu, 19 Dec 2002 07:32:53 -0500
Date: Thu, 19 Dec 2002 13:40:43 +0100
From: martin f krafft <madduck@debian.org>
To: linux-kernel@vger.kernel.org
Subject: 'D' processes on a healthy system?
Message-ID: <20021219124043.GA28617@fishbowl.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[please CC me on replies]

Hi folks,

I just pulled up a fresh, powerful, and errorfree server on Debian
woody, with some packages from testing. It's running a vanilla 2.4.19
kernel with the grsecurity 1.9.7d and freeswan 1.99 patches. This is
an AMD Athlon Duron 1.2 GHz with 512 Mb of SD-RAM and a 7,200 UPM HDD
by Maxtor. Reiserfs is used as filesystem.

I also have a machine that's about a year old, still running a vanilla
2.4.12 kernel without any patches. It's an AMD K6-2 500 MHz with 192
Mb of RAM and a 5,400 UPM Western Digital drive. ext2 is the
filesystem here.

When either machine becomes loaded, certain processes become unusable
for a couple of seconds. top shows me this:

19268 madduck   18   0  2208 2208  1076 D     1.3  0.4   0:00 sanitizer
    6 root       9   0     0    0     0 DW    0.3  0.0   1:10 kupdated
 8457 root      10   0  1156 1156   820 R     0.3  0.2   0:02 top
10843 postfix    9   0  1364 1364  1016 D     0.3  0.2   0:00 cleanup
 3156 madduck    0   0   636  636   540 D     0.1  0.1   0:00 procmail
28356 root       9   0   292  288   240 R     0.0  0.0   0:01 supervise
28706 root       9   0  2060 2036  1724 D     0.0  0.4   0:00 sshd
21395 root      15   0  1944 1944  1876 D     0.0  0.3   0:00 zsh

notice the number of processes in       ^
uninterruptible sleep mode in this column.

This was after i did something like:

  while true; do echo test | sendmail madduck; mailq; done

When this state is reached, programs like mutt take 7 minutes to open
a mailbox of 100 messages. With the server specs, this should not
happen.

I have memtest86'd the RAM and ran badblocks over all partitions
without finding anything.

My laptop, which is running Debian testing/unstable is not showing
this behaviour, and its load goes far higher at times. I also run
various other servers, partially on P5-120 systems, vanilla 2.4.xx
kernels and Debian testing, and there are no such problems there.

What is this an indication of? Hardware problems? Software problems?
Have you heard of this before? How can I fix it?

Thanks,

[Please CC me on replies]

--=20
 .''`.     martin f. krafft <madduck@debian.org>
: :'  :    proud Debian developer, admin, and user
`. `'`
  `-  Debian - when you have better things to do than fixing a system
=20
NOTE: The public PGP keyservers are broken!
Get my key here: http://people.debian.org/~madduck/gpg/330c4a75.asc

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Ab5LIgvIgzMMSnURAq8PAJ9fAhUmiVuyJr3vNlwTMtXiHqt+PQCgmiY5
xxKt5bssHrm8pYV+IK78j6U=
=TES5
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
