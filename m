Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSFXHsf>; Mon, 24 Jun 2002 03:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSFXHse>; Mon, 24 Jun 2002 03:48:34 -0400
Received: from web21006.mail.yahoo.com ([216.136.227.60]:23939 "HELO
	web21006.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317430AbSFXHsc>; Mon, 24 Jun 2002 03:48:32 -0400
Message-ID: <20020624074834.36579.qmail@web21006.mail.yahoo.com>
Date: Mon, 24 Jun 2002 00:48:34 -0700 (PDT)
From: Zak Shaf <zak_shaf@yahoo.com>
Subject: slimscsi 1480 on dell inspiron 5000, crashing
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As per the instructions in PCMCIA-HOMTO, after
recompiling the latest kernel with SCSI options, and
installing the modules from the latest pcmcia-cs
package, my machine appears to detect the scsi
controller and the devices on them.

However, there are two aspects which are worrisome. In
my dmesg, I get an error message -
"aic7xxx: PCI6:0:0 MEM region 0x60050000 unavailable.
Cannot map device."

and the machine crashes frequently, after kernel goes
into panic.

any hints/pointers would be much appreciated.
zak

ps: the complete dmesg relevant dmesg output is
attached below.

Linux version 2.5.0 (zak@puma) (gcc version 2.95.3
20010315 (release)) #2 Sun Ju
n 23 14:03:45 EDT 2002
...PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 00:04.1
PCI: Sharing IRQ 11 with 01:00.0
PCI: Cannot allocate resource region 4 of device
00:07.1
Limiting direct PCI/PCI transfers.
...
maestro: version 0.15 time 13:59:10 Jun 23 2002
PCI: Found IRQ 5 for device 00:08.0
PCI: Sharing IRQ 5 with 00:07.2
PCI: Sharing IRQ 5 with 00:10.0
...
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 00:04.1
PCI: Sharing IRQ 11 with 01:00.0

  TI 1225 rev 01 PCI-to-CardBus at slot 00:04, mem
0x10000000
    host opts [0]: [ring] [serial pci & irq] [pci irq
11] [lat 168/32] [bus 2/5]
    host opts [1]: [ring] [serial pci & irq] [pci irq
11] [lat 168/32] [bus 6/9]
    ISA irqs (scanned) = 3,4,7,10 PCI status changes
cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5257
cs: cb_alloc(bus 6): vendor 0x9004, device 0x6075
3c59x.c:v0.99Q 5/16/2000 Donald Becker,
becker@scyld.com
  http://www.scyld.com/network/vortex.html
cs: cb_config(bus 2)
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
  fn 0 bar 1: io 0x200-0x27f
  fn 0 bar 2: mem 0x60021000-0x6002107f
  fn 0 bar 3: mem 0x60020000-0x6002007f
  fn 0 rom: mem 0x60000000-0x6001ffff
  irq 11
cs: cb_enable(bus 2)  bridge mem map 0 (flags 0x1):
0x60000000-0x60021fff
vortex_attach(device 02:00.0)
eth0: 3Com 3CCFE575CT Tornado CardBus at 0x200, 
00:01:02:7b:2f:1b, IRQ 11
  product code 'ZW' rev 10.0 date 10-17-00
eth0: CardBus functions mapped 60020000->c8c81000.
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 7809.
  Enabling bus-master transmits and whole-frame
receives.
ROM image dump:
  image 0: 0x000000-0x0001ff, signature PCIR
  image 1: 0x000200-0x0003ff, signature PCIR
SCSI subsystem driver Revision: 1.00
cs: cb_config(bus 6)
  fn 0 bar 1: io 0x800-0x8ff
  fn 0 bar 2: mem 0x60050000-0x60050fff
  fn 0 rom: mem 0x60040000-0x6004ffff
  irq 11
cs: cb_enable(bus 6)
  bridge io map 0 (flags 0x21): 0x800-0x8ff
  bridge mem map 0 (flags 0x1): 0x60040000-0x60050fff
apa1480_attach(device 06:00.0)
aic7xxx: PCI6:0:0 MEM region 0x60050000 unavailable.
Cannot map device.
ahc_pci:6:0:0: Host Adapter Bios disabled.  Using
default SCSI device parameters

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER,
Rev 6.2.4
        <Adaptec 1480A Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7,
3/253 SCBs

  Vendor: Nikon     Model: LS-2000           Rev: 1.31
  Type:   Scanner                            ANSI SCSI
revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 2,
lun 0,  type 6
spurious 8259A interrupt: IRQ7.



__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
