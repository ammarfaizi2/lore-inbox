Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130839AbQLHMNY>; Fri, 8 Dec 2000 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130901AbQLHMNO>; Fri, 8 Dec 2000 07:13:14 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:13064 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130839AbQLHMNI>;
	Fri, 8 Dec 2000 07:13:08 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Fri, 8 Dec 2000 12:41:56 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18pre21: iput: device 08:0x inode xy still has aliases!
CC: hulinsky@fel.cvut.cz
X-mailer: Pegasus Mail v3.40
Message-ID: <F1344A81978@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  one of my friends uses 2.2.18-pre21 (packaged by Debian...) and
when he run tripwire, he got:

iput: device 08:07 inode 47215 still has aliases!
iput: device 08:07 inode 47592 still has aliases!
iput: device 08:07 inode 110279 still has aliases!
iput: device 08:02 inode 62928 still has aliases!
iput: device 08:02 inode 34036 still has aliases!
iput: device 08:02 inode 33863 still has aliases!
iput: device 08:02 inode 3518 still has aliases!
iput: device 08:02 inode 64494 still has aliases!
iput: device 08:02 inode 62928 still has aliases!
iput: device 08:02 inode 109302 still has aliases!
iput: device 08:02 inode 34834 still has aliases!
iput: device 08:02 inode 33928 still has aliases!
iput: device 08:02 inode 16601 still has aliases!
iput: device 08:02 inode 3333 still has aliases!
iput: device 08:02 inode 107577 still has aliases!
iput: device 08:02 inode 2457 still has aliases!
iput: device 08:02 inode 16908 still has aliases!
iput: device 08:02 inode 95410 still has aliases!
iput: device 08:02 inode 110990 still has aliases!
iput: device 08:02 inode 78678 still has aliases!
iput: device 08:02 inode 30685 still has aliases!
iput: inode 08:02/30685 count wrapped

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2               964532    487668    427868  53% /
/dev/sda1                31077      2103     27370   7% /boot
/dev/sda6               482217        13    457305   0% /tmp
/dev/sda7              2213668    147208   1954008   7% /var

Abit BE6-II, one year old, both of these devices are ext2.

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0f.0 SCSI storage controller: Adaptec 7892A (rev 02)
00:11.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)

(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI
0/15/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
scsi : 1 host.
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 15.
  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.80
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 8515173 [4157 MB] [4.2
GB]
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >

When he rerun 'tripwire' (witout reboot), he was awarded by 

iput: inode 00:00/0 count wrapped

Tripwire itself finished without any complaints.
                                                Thanks,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
