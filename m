Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbRFWHnE>; Sat, 23 Jun 2001 03:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265665AbRFWHmz>; Sat, 23 Jun 2001 03:42:55 -0400
Received: from [12.36.4.15] ([12.36.4.15]:47347 "EHLO lydia")
	by vger.kernel.org with ESMTP id <S265659AbRFWHmf>;
	Sat, 23 Jun 2001 03:42:35 -0400
To: linux-kernel@vger.kernel.org
Subject: plain 2.2.X: no ide CD-RW?
From: soma@cs.unm.edu (Anil B. Somayaji)
Date: 23 Jun 2001 01:42:38 -0600
Message-ID: <ut2hex7ej69.fsf@lydia.adaptive.net>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

For a while now, I've been running a 2.4 kernel, but (for my research)
I need to now run a 2.2 kernel.  I was hoping to just run a stock
2.2.19, but I've found that I can't use my CD-RW drive, either as a
plain IDE cdrom, or as a scsi-emulated one.  (I have ide-scsi, ide-cd,
and scsi all as modules.)

When I try things as scsi-emulated CD-ROM, I get the following:

  Jun 22 19:58:15 lydia kernel: ide-scsi: The scsi wants to send us
     more data than expected - discarding data
  Jun 22 19:58:16 lydia last message repeated 83 times

Instead, if I try ide-cd, I get these messages:

  Jun 22 20:11:38 lydia kernel: hdc: status error: status=0x58 {
     DriveReady SeekComplete DataRequest }
  Jun 22 20:11:38 lydia kernel: hdc: drive not ready for command
  Jun 22 20:11:38 lydia kernel: hdc: status timeout: status=0xd0 { Busy }
  Jun 22 20:11:38 lydia kernel: hdc: DMA disabled
  Jun 22 20:11:38 lydia kernel: hdc: drive not ready for command
  Jun 22 20:11:38 lydia kernel: hdc: ATAPI reset complete
  Jun 22 20:11:48 lydia kernel: hdc: irq timeout: status=0x80 { Busy }
  Jun 22 20:11:48 lydia kernel: hdc: ATAPI reset complete
  Jun 22 20:11:59 lydia kernel: hdc: irq timeout: status=0x80 { Busy }
  Jun 22 20:11:59 lydia kernel: end_request: I/O error, dev 16:00
     (hdc), sector 64
  Jun 22 20:11:59 lydia kernel: hdc: status timeout: status=0x80 { Busy }
  Jun 22 20:11:59 lydia kernel: hdc: drive not ready for command

I have these problems with 2.2.1[7-9] & 2.2.20pre5.  However, if I add
one of the IDE patches, all is well.  2.4 kernels have never given me
these sorts of problems.

I have a 440LX motherboard (HP Pavilion 8260), hooked up to a Plextor
PX-W8432T 4/8/32 CD-RW, attached as /dev/hdc.  I also have an OnStream
DI-30 as /dev/hdd, and a Maxtor 91020D6 10G drive as /dev/hda.

I can live with just running an ide-patched kernel, but it seems very
odd that I can't even use the drive as an IDE CD-ROM drive with a
stock 2.2 kernel.  Is this a bug, or a limitation?  I'd be happy to
perform any tests to try and track this problem down.

Thanks!

  --Anil

- -- 
Anil Somayaji (soma@cs.unm.edu)
http://www.cs.unm.edu/~soma
+1 505 872 3150
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjs0SFkACgkQXOpXEmNZ3SeAtgCeL8j+ZvfANCB0acV6kL6AQFtB
GdUAnidlfYrkv1o+hSlO4kNoWUNXw43v
=RqEF
-----END PGP SIGNATURE-----
