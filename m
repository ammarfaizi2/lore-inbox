Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbTLHP2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTLHP2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:28:52 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:16474 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265423AbTLHP2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:28:49 -0500
Message-ID: <3FD498A0.9080802@yahoo.es>
Date: Mon, 08 Dec 2003 10:28:32 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.0-testX show stoppers
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7402A1DF11FA6EFC3DAC3F41"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7402A1DF11FA6EFC3DAC3F41
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am having some problems getting 2.6.0-test11 working on my 2 boxes.
I am hoping that someone here can provide me some insight so that I
can provide some useful info to help get these solved.

Any help would be appreciated.

-Roberto

Here goes:

Box 1:

Athlon XP 2500+, 1 GB RAM, 120 GB HDD
nVidia nForce2 chipset
ATI Radeon 9000 Pro w/ 128 MB

This machine just randomly and frequently locks up under any 2.6.x
kernel.  I can't find a particular pattern, but it happens every few
minutes (enough to make the machine unusable).  It is now running a
2.4.23 kernel.


Box 2:

Toshiba Satellite 2805-S401 (laptop)
P-III 700 MHz, 256 MB RAM, 40 GB HDD
Intel 440BX chipset
S3 Savage IX/MV 8 MB video

Problem: Every kernel after 2.6.0-test4 gives me a hard lock-up during
the boot sequence when PCMCIA services start.  No 2.4.x kernel ever did
this, and 2.6.0-test1 thru -test4 work fine.  I have narrowed the 
problem to the point where the yenta_socket socket module is inserted.
However, if I pass acpi=off as a kernel boot parameter, it does not lock
up.  Also, if I build PCMCIA support directly into the kernel,
everything works.  I am currently running 2.6.0-test11 with PCMCIA
built in (but I would like it to be modular).

I am also receiving the following errors on boot when my scripts
set up the parameters on my HDD and CD/DVD (this is also particular
to the post -test4 kernels):

hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: DMA disabled
hda: drive not ready for command
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
DataRequest }

But, eventhough it says DMA is disabled, it is still enabled.

# hdparm /dev/hda

/dev/hda:
  multcount    = 16 (on)
  IO_support   =  1 (32-bit)
  unmaskirq    =  1 (on)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 38760/16/63, sectors = 39070080, start = 0

--------------enig7402A1DF11FA6EFC3DAC3F41
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/1JivTfhoonTOp2oRAhrMAKDNWRo+NnBo4uJGxG3XFi5FvmSWzACeK2yt
cG+5BL0nOSdQHEJ1gVAbPLs=
=9wm9
-----END PGP SIGNATURE-----

--------------enig7402A1DF11FA6EFC3DAC3F41--

