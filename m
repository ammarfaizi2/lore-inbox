Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSKZRnD>; Tue, 26 Nov 2002 12:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266444AbSKZRnD>; Tue, 26 Nov 2002 12:43:03 -0500
Received: from ma-northadams1b-112.bur.adelphia.net ([24.52.166.112]:384 "EHLO
	ma-northadams1b-112.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S266443AbSKZRnB>; Tue, 26 Nov 2002 12:43:01 -0500
Date: Tue, 26 Nov 2002 12:50:19 -0500
From: Eric Buddington <eric@ma-northadams1b-112.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.49: "hdb: cannot handle device with more than 16 heads"
Message-ID: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.5.49, compiled for i386 with almost all modules using
gcc-3.2.  On my PII Omnibook 4100, the messages stop after the first
hda: message (where it would normally identify the drive). The same
problem existed in 2.4.48.

When booting on my Athlon (hda:Maxtor 5T040H4, hdb: Maxtor 90840D6), I
get the following boot messages:

pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
hdc: _NEC CD-RW NR-7800A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
hda: 8032MB, CHS=1024/255/63
hdb: 8008MB, CHS=1021/255/63
 hda:hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: cannot handle device with more than 16 heads - giving up
end_request: I/O error, dev hda, sector 16450552
Buffer I/O error on device hd(3,0), logical block 2056319
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: read_intr: status=0x59.
hda: read_intr: error=0x10.
hda: cannot handle device with more than 16 heads - giving up
end_request: I/O error, dev hda, sector 16450552
Buffer I/O error on device hd(3,0),
...
hdb: read_intr: status=0x59.
hdb: read_intr: error=0x10.
hdb: read_intr: status=0x59.
hdb: read_intr: error=0x10.
hdb: read_intr: status=0x59.
hdb: read_intr: error=0x10.
hdb: read_intr: status=0x59.
hdb: read_intr: error=0x10.
hdb: cannot handle device with more than 16 heads - giving up
end_request: I/O error, dev hdb, sector 16402361
Buffer I/O error on device hd(3,64), logical block 16402361
...

...and eventually panics for lack of a root fs.


-Eric



