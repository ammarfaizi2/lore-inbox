Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277756AbRJZGUL>; Fri, 26 Oct 2001 02:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277797AbRJZGUB>; Fri, 26 Oct 2001 02:20:01 -0400
Received: from arabuusi.tky.hut.fi ([130.233.24.169]:30871 "HELO
	arabuusi.tky.hut.fi") by vger.kernel.org with SMTP
	id <S277756AbRJZGTq>; Fri, 26 Oct 2001 02:19:46 -0400
To: linux-kernel@vger.kernel.org
Subject: HPT366 problems continued
Message-ID: <1004077903.3bd9034f7360f@mail.arabuusimiehet.com>
Date: Fri, 26 Oct 2001 09:31:43 +0300 (EEST)
From: Janne Liimatainen <jannel@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a dual P2 with 82441FX Natoma chipset and I have problems with getting 
DMA on with a HPT366 controller. Autodma etc is on and I have tried different 
PCI slots. Kernel is 2.4.9. Ideas? Thanks!

This is what I get now:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
HPT366: IDE controller on PCI bus 00 dev 70
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
HPT366: simplex device:  DMA disabled
ide0: HPT366 Bus-Master DMA disabled (BIOS)
HPT366: IDE controller on PCI bus 00 dev 71
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
HPT366: simplex device:  DMA disabled
ide1: HPT366 Bus-Master DMA disabled (BIOS)
hda: Maxtor 4D080H4, ATA DISK drive
hdc: Maxtor 4D080H4, ATA DISK drive
ide0 at 0xf0d0-0xf0d7,0xf0de on irq 9
ide1 at 0xf0c8-0xf0cf,0xf0da on irq 9
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63

and

00:0e.0 Unknown mass storage controller: HighPoint Technologies, Inc. 
HPT366/370 UltraDMA 66/100 IDE Controller (rev 01)
        Flags: bus master, medium devsel, latency 120, IRQ 9
        I/O ports at f0d0 [size=8]
        I/O ports at f0dc [size=4]
        I/O ports at e800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:0e.1 Unknown mass storage controller: HighPoint Technologies, Inc. 
HPT366/370 UltraDMA 66/100 IDE Controller (rev 01)
        Flags: bus master, medium devsel, latency 120, IRQ 9
        I/O ports at f0c8 [size=8]
        I/O ports at f0d8 [size=4]
        I/O ports at e400 [size=256]

and

# /sbin/hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


--
  -Janne
