Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129652AbQK3HUF>; Thu, 30 Nov 2000 02:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129851AbQK3HT4>; Thu, 30 Nov 2000 02:19:56 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:11783 "EHLO
        smtp.lax.megapath.net") by vger.kernel.org with ESMTP
        id <S129652AbQK3HTx>; Thu, 30 Nov 2000 02:19:53 -0500
Message-ID: <3A25F803.6090609@megapathdsl.net>
Date: Wed, 29 Nov 2000 22:47:31 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12-pre3 -- Playing an audio CD halts with drive errors.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could be a CD scratch, but I don't think it is.
This is a brand new CD which I just opened.

After the errors from /var/log/messages, I include
info from hdparm -g -i.

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x50
ATAPI device hdc:
   Error: Illegal request -- (Sense key=0x05)
   Invalid field in command packet -- (asc=0x24, ascq=0x00)
   The failed "Play Audio MSF" packet command was:
   "47 00 00 00 02 00 3f 24 ff 00 00 00 "
   Error in command packet byte 8 bit 0
hdc: packet command error: status=0x41 { DriveReady Error }
hdc: packet command error: error=0x50
ATAPI device hdc:
   Error: Illegal request -- (Sense key=0x05)
   Invalid field in command packet -- (asc=0x24, ascq=0x00)
   The failed "Play Audio MSF" packet command was:
   "47 00 00 05 38 34 3f 24 ff 00 00 00 "
   Error in command packet byte 8 bit 0
Uniform CD-ROM driver unloaded
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
VFS: Disk change detected on device ide1(22,0)
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x50
ATAPI device hdc:
   Error: Illegal request -- (Sense key=0x05)
   Invalid field in command packet -- (asc=0x24, ascq=0x00)
   The failed "Play Audio MSF" packet command was:
   "47 00 00 00 02 00 3f 24 ff 00 00 00 "
   Error in command packet byte 8 bit 0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
snd: cs4231: port = 0x530, id = 0xa
snd: CS4231: VERSION (I25) = 0x3
snd: CS4231: ext version; rev = 0xe8, id = 0xe8
snd: CS4236: [0xf00] C1 (version) = 0xe8, ext = 0xe8
hdc: packet command error: status=0x41 { DriveReady Error }
hdc: packet command error: error=0x50
ATAPI device hdc:
   Error: Illegal request -- (Sense key=0x05)
   Invalid field in command packet -- (asc=0x24, ascq=0x00)
   The failed "Play Audio MSF" packet command was:
   "47 00 00 05 38 34 3f 24 ff 00 00 00 "
   Error in command packet byte 8 bit 0
hdc: packet command error: status=0x41 { DriveReady Error }
hdc: packet command error: error=0x50
ATAPI device hdc:
   Error: Illegal request -- (Sense key=0x05)
   Invalid field in command packet -- (asc=0x24, ascq=0x00)
   The failed "Play Audio MSF" packet command was:
   "47 00 00 0e 10 32 3f 24 ff 00 00 00 "
   Error in command packet byte 8 bit 0

hdparm -g -i /dev/hdc

/dev/hdc:
  HDIO_GET_MULTCOUNT failed: Invalid argument
  HDIO_GETGEO failed: Invalid argument

  Model=TOSHIBA CD-ROM XM-1702BC, FwRev=1854, SerialNo=ÿÿÿÿÿÿÿÿÿÿ
  Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
  BuffType=0(?), BuffSize=128kB, MaxMultSect=0
  DblWordIO=no, OldPIO=4, DMA=yes, OldDMA=2
  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
  tDMA={min:120,rec:120}, DMA modes: sword0 sword1 sword2 mword0 mword1 
*mword2
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
