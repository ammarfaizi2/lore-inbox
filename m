Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAOSTD>; Mon, 15 Jan 2001 13:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAOSSx>; Mon, 15 Jan 2001 13:18:53 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:42770 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129485AbRAOSSj>;
	Mon, 15 Jan 2001 13:18:39 -0500
Date: Mon, 15 Jan 2001 19:18:30 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Disk geometry changed after running linux
To: linux-kernel@vger.kernel.org
Message-id: <3A633EF6.44E5A2C@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a weird problem.

My HW :
MSI K7T Pro2 motherboard ( VIA KT133 chipset ,
 VT82C686A south bridge )
primary master IDE : Quantum Fireball lct20 , ATA-100 , 20 GB
secondary master : Teac CD532E-B

AWARD BIOS settings :
PM : type : AUTO , Access mode : AUTO
SM : type : AUTO , Access mode : AUTO
PS/SS: NONE/NONE

PM disk was set to LBA access mode on each boot.
I had one primary and one logical NTFS partition.


Then I installed linux ( "some" beta version , kernel
is some recent 2.4.0-testXX )

I didn't install any LILO boot sectors , but created a boot-floppy.

After the installation the disk ( win2000 ) would not boot.
It reports :
Read error on disk.
Press ctrl+alt+del to reboot.

If I run linux ( it work OK from the boot floppy ),
it reports the geometry as 3xxxx/??/??.
Thirty thousand and some cylinders , H and S are probably 16/63
( don't have it at hand ).

It should be two thousand something and 255/63, I think.

fdisk -l /dev/hda prints "Partition 1 does not end on cylinder boundary"
messages for the NTFS partitions ( hda1 and hda5 ). The linux ones are
OK.

The problem is that now the BIOS sets Access mode to LARGE.
I can workaround it by changing access mode in BIOS setup
from AUTO to LBA, but I want to know what made BIOS to default to
LARGE and how to fix it.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
