Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbTCRIKC>; Tue, 18 Mar 2003 03:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbTCRIKC>; Tue, 18 Mar 2003 03:10:02 -0500
Received: from 210-54-226-35.dialup.xtra.co.nz ([210.54.226.35]:260 "EHLO
	riven.neverborn.ORG") by vger.kernel.org with ESMTP
	id <S262230AbTCRIJt>; Tue, 18 Mar 2003 03:09:49 -0500
Date: Wed, 19 Mar 2003 08:20:34 +1200
From: "leon j. breedt" <ljb@neverborn.org>
To: linux-kernel@vger.kernel.org
Subject: ASUS P4PE IDE problems in 2.4.21-pre5
Message-ID: <20030318202034.GA14818@riven.neverborn.ORG>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi!

i'm seeing some worrying things in my log files since
yesterday, i'm wondering if this is indicative of impending
hardware failure, or something else.

my hardware is the ASUS P4PE motherboard with the Intel ICH4 IDE
chipset (PIIX in kernel config), and:

hda: WDC WD800JB-00CRA1, ATA DISK drive
hdb: IC35L080AVVA07-0, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive

hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(100)
hdb: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, UDMA(100)
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)

on the harddisk drives i run hdparm at bootup:

hdparm -d1 -c1 /dev/hd{a,b}

performance has been satisfactory, until today.

i experienced slowdowns when starting applications, compiling,
etc, that i haven't before.

looking at the logs, i found the following errors:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 0

then:

hda: dma_timer_expiry: dma status == 0x64
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=70)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

hdb: dma_timer_expiry: dma status == 0x64
hdb: lost interrupt
hdb: dma_intr: bad DMA status (dma_stat=70)
hdb: dma_intr: status=0x50 { DriveReady SeekComplete }

it is these last two that concern me the most, as i also saw
an EXT3 error message which seems to be associated with filesystem
corruption after the hda error:

EXT3-fs warning (device ide0(3,7)): ext3_unlink: Deleting nonexistent file (377645), 0
EXT3-fs warning (device ide0(3,7)): ext3_unlink: Deleting nonexistent file (295073), 0

i've also had these problems crop up on every single machine i've
owned since my first one, and each time the messages got progressively
more frequent...so i'm rather paranoid now...and annoyed, since i
specifically bought decent (in my book) brand components for this system
to avoid exactly this kind of error.

are these drives about to choke? i can't think of a reason why,
because the drives don't run hot, they're fairly decently cooled,
although i may move them further away from each other if the
problem persists, since the case isn't brilliant for cooling, due
to its midi size.

any suggestions? should i start backing up now?
please CC me in your replies.

thanks in advance,
leon.

- -- 
in the beginning, was the code.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+d3+SRWcl5mzp4f4RAofbAKDHYgLOjVuLNy9UT9awbn059T1aOQCeJL9y
UApwF7Bx48bUgar3GxuhOdQ=
=ymh7
-----END PGP SIGNATURE-----
