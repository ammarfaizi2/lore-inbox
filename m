Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130555AbQK1Et3>; Mon, 27 Nov 2000 23:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130810AbQK1EtJ>; Mon, 27 Nov 2000 23:49:09 -0500
Received: from ruddock-207.caltech.edu ([131.215.90.207]:49169 "EHLO
        agard.caltech.edu") by vger.kernel.org with ESMTP
        id <S130555AbQK1EtA>; Mon, 27 Nov 2000 23:49:00 -0500
Message-ID: <3A233409.CD297146@its.caltech.edu>
Date: Mon, 27 Nov 2000 20:26:49 -0800
From: James Lamanna <jlamanna@its.caltech.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fasttrak 100 configuration
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm trying to get the Promise Fasttrack 100 driver included
with 2.4.0-test10 to work on my system.
I have 2 45GB drives hooked up in RAID0.

I'm trying to install directly onto the drives, but I'm having
a couple problems.
It seems to detect the controller card and the drives, but
they are not assigned to any devices.

Any suggestions?
Thanks,
--James Lamanna

Here is some info:
dmesg:
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 88
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
    ide0: BM-DMA at 0x6400-0x6407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6408-0x640f, BIOS settings: hdc:DMA, hdd:pio
PDC20267: IDE controller on PCI bus 00 dev 58
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20267: neither IDE port enabled (BIOS)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          This line is interesting I thought...

/proc/pci:
Bus  0, device  11, function  0:
    RAID bus controller: Promise Technology, Inc. 20267 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0x9400 [0x9407].
      I/O at 0x9000 [0x9003].
      I/O at 0x8800 [0x8807].
      I/O at 0x8400 [0x8403].
      I/O at 0x8000 [0x803f].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd501ffff].
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20265 (rev
2).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0x7800 [0x7807].
      I/O at 0x7400 [0x7403].
      I/O at 0x7000 [0x7007].
      I/O at 0x6800 [0x6803].
      I/O at 0x6400 [0x643f].
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd481ffff].

/proc/ide/pdc202xx:
                                PDC20265 Chipset.
------------------------------- General Status 
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 5
Interrupt Check Status Polling Delay : 7
--------------- Primary Channel ---------------- Secondary Channel
-------------
                enabled                          enabled
66 Clocking     disabled                         disabled
           Mode PCI                         Mode PCI
                FIFO Empty                       FIFO Empty   
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               no              yes               no
DMA Mode:       NOTSET           NOTSET          NOTSET           
NOTSET
PIO Mode:       NOTSET            NOTSET           NOTSET           
NOTSET
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
