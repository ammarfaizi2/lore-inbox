Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRGEIeR>; Thu, 5 Jul 2001 04:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbRGEIeI>; Thu, 5 Jul 2001 04:34:08 -0400
Received: from imo-m06.mx.aol.com ([64.12.136.161]:33266 "EHLO
	imo-m06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S264864AbRGEId4>; Thu, 5 Jul 2001 04:33:56 -0400
From: Floydsmith@aol.com
Message-ID: <62.10c7258c.28758068@aol.com>
Date: Thu, 5 Jul 2001 04:33:44 EDT
Subject: Re: more can't setblk (size) with "mt" on a scsi emulated colorado 8 Gig drive
To: linux-tape@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More on "mt setblk" prob. under 2.4.5 with ide_scsi emulated HP 8Gig ide 
drive (the orginal prob. was reported for 2.2.18).
The "mt version" is:
mt-st v. 0.4

The output under 2.4.5 is:
localhost.localdomain:/root# mt -f /dev/st0 setblk 32768
st0: Block limits 2048 - 852220 bytes.
st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00: sns = 70 
 5ASC=26 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x10 0x00 0x00 0x00 0x00 
0x26
0x00 0x00 0x00 0x00 0x00 0x01 0x09 0x00 0x00 0x00 0x00
/dev/st0: Input/output error

This appears to be a problem with the scsi-ide emulation stuff not being able 
to cope with this ide drive.

Now, the (ONLY) reason I am using scsi emulation with this IDE drive is 
(athough it works find under 2.2.18 kerenel with respect to both reads anmd 
writes as a IDE dev if scsi emul. is not in config) but under "2.4.x" 
kernels, scsi emulation MUST be turned on and used to get the drive to "read" 
- it writes Ok in either event.

Floyd,
