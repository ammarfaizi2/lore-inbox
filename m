Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTDYSqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTDYSqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:46:06 -0400
Received: from grendel.firewall.com ([66.28.56.41]:46534 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S263639AbTDYSqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:46:03 -0400
Date: Fri, 25 Apr 2003 20:58:02 +0200
From: Marek Habersack <grendel@caudium.net>
To: linux-kernel@vger.kernel.org
Subject: Lost interrupts with IDE DMA on 2.5.x
Message-ID: <20030425185802.GA4391@thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

 I've recently added a second drive to my workstation and since then I'm
getting the following error from time to time:

  Apr 25 20:42:06 beowulf kernel: hda: dma_timer_expiry: dma status =3D=3D =
0x64
  Apr 25 20:42:06 beowulf kernel: hda: lost interrupt
  Apr 25 20:42:06 beowulf kernel: hda: dma_intr: bad DMA status (dma_stat=
=3D70)
  Apr 25 20:42:06 beowulf kernel: hda: dma_intr: status=3D0x50 { DriveReady=
=20
   SeekComplete }

Both drives are new Maxtors (60 and 40GB) on the VIA KT266 chipset (the mobo
is MSI K7T266 Pro2-A mobo):

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.36
South Bridge:                       VIA vt8233a
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xfc00
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       PIO       DMA
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns     330ns      90ns
Data Recovery:       30ns      30ns     270ns      30ns
Cycle Time:          15ns      15ns     600ns     120ns
Transfer Rate:  133.3MB/s 133.3MB/s   3.3MB/s  16.6MB/s

  Of course, when the above happens, all disk I/O freezes. The above happens
only when there's simultaneous activity on both devices. It doesn't happen
when the devices are on different IDE interfaces. The transfer is always
retried and completed successfully, so it's not a bad hdd and I can only
guess the problem is somewhere in the DMA/IRQ handling by the IDE driver. If
there's not enough information to diagnose/solve the problem, I can do more
tests (run with 2.4 for a while, run with the generic IDE drive etc.).

TIA,

marek

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qYU6q3909GIf5uoRAp/TAJ9m6hNzq0YXpuUjBrlFbfWbV66GxQCeJOES
eRKodoR7qZKTIWjmyuMjbg4=
=xxSW
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
