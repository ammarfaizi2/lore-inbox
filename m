Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRALPe5>; Fri, 12 Jan 2001 10:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRALPer>; Fri, 12 Jan 2001 10:34:47 -0500
Received: from ega010000096.lancs.ac.uk ([148.88.153.219]:18948 "EHLO
	egb070000014.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129763AbRALPef>; Fri, 12 Jan 2001 10:34:35 -0500
Date: Fri, 12 Jan 2001 15:32:28 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux booting from HD on Promise Ultra ATA 100
Message-ID: <Pine.LNX.4.21.0101121523040.4379-100000@egb070000014.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm having difficulty booting from the Promise controller. Here is the
story:

I originally had my system setup with all drives working off the
mainsboard IDE controller (Intel 82371AB PIIX4). The setup was

/dev/hda - ST310232A, FwRev=3.09  (Seagate)
/dev/hdb - 927308, FwRev=RA530JNO (Maxtor) * Linux installed here
/dev/hdc - CD-532E-B (Teach CDROM)
/dev/hdd - CD-RW4224A (Smart & Friendly CDRW).

Well I got an Promise Ultra ATA 100 controller card. Went over to
linux-ide.org and get the patches for kernel-2.2.16. Took a pristine
kernel-2.2.16 and patched it and then compiled it on a RedHat 6.2
system. I then made a bootdisk with this new kernel.

So then I installed the drives in this order:

(Mainsboard controller)
primary master - ST310232A (Seagate)
primary slave - none
secondary master - CDROM
secondary slave - CDRW

(Promise controller)
primary slave - IBM-DLTA-307045 (IBM)
primary slave - 927308 (Maxtor) * Linux install here
secondary master - none
secondary slave - none

The system boots if I use the bootdisk and tell it "linux
root=/dev/hdf3".  I edited the lilo.conf and the fstab for the new
setup. I can log in and do my business with my the linux partition but
when I tried to use lilo to setup the MBR on the first disk (mainsboard) I
got this:

warning: BIOS Drive 0x82 may not be accessible.

Is there some settings that I need to give to the lilo to boot?

Stephen

- -- 
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org
Filter: gpg4pine 4.0 (http://azzie.robotics.net)

iD8DBQE6XyOTI7ZT+dSlizsRAu3BAKCdtwlgiJ9+isy9NOlltIs+logHMgCfViiy
ofYOmWxhH6Qt8FDeoJNZvsg=
=+RwL
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
