Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbRBJRbT>; Sat, 10 Feb 2001 12:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRBJRbJ>; Sat, 10 Feb 2001 12:31:09 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:648 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129596AbRBJRbB>; Sat, 10 Feb 2001 12:31:01 -0500
Message-ID: <3A8579C9.5511286F@didntduck.org>
Date: Sat, 10 Feb 2001 12:26:33 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IRQ conflicts
In-Reply-To: <3A85726E.A66A56A0@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> I'm having problems with 2.4.2-pre3 and IRQ conflicts.  Last kernel that
> I tried and worked without conflict was 2.4.0-test11.  Here are the
> relevant messages that I get:

I enabled more debug messages, so here is the updated messages.  I also
noticed that ACPI is trying to use IRQ 9, which the soundblaster is also
trying to use.

PCI: BIOS32 Service Directory structure at 0xc00fb020
PCI: BIOS32 Service Directory entry at 0xfb4a0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=02
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/0597] 000600 00
Found 00:08 [1106/8598] 000604 01
Found 00:38 [1106/0586] 000601 00
Found 00:39 [1106/0571] 000101 00
PCI: IDE base address fixup for 00:07.1
Found 00:3b [1106/3040] 000604 00
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
Found 00:40 [102b/0519] 000300 00
Found 00:48 [1113/1211] 000200 00
Found 00:50 [10ec/8139] 000200 00
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdec0
00:07 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:09 slot=02 0:02/deb8 1:03/deb8 2:05/deb8 3:01/deb8
00:0a slot=03 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:0b slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:07 slot=00 0:00/deb8 1:00/deb8 2:00/deb8 3:00/deb8
00:01 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource e0000000-e3ffffff (f=1208, d=0, p=0)
PCI: Resource 0000e400-0000e40f (f=101, d=0, p=0)
PCI: Resource e4000000-e4003fff (f=200, d=0, p=0)
PCI: Resource e5000000-e57fffff (f=1208, d=0, p=0)
PCI: Resource 0000e800-0000e8ff (f=101, d=0, p=0)
PCI: Resource e7000000-e70000ff (f=200, d=0, p=0)
PCI: Resource 0000ec00-0000ecff (f=101, d=0, p=0)
PCI: Resource e7001000-e70010ff (f=200, d=0, p=0)
PCI: Sorting device list...
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: Card 'Rockwell K56Flex Plug & Play Modem'
isapnp: 2 Plug & Play cards detected total
DMI 2.1 present.
25 structures occupying 843 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 02/26/99
System Vendor: System Manufacturer.
Product Name: Product Name.
Version SYS-xxxxxx.
Serial Number Serial Number xxxxxx.
Board Vendor: First International Computer, Inc..
Board Name: PA-2013.
Board Version: PCB 2.X.
Asset Tag: Asset Tag Number xxxxxx.
8139too Fast Ethernet driver 0.9.13 loaded
IRQ for 00:09.0:0 -> PIRQ 02, mask deb8, excl 0c20 -> newirq=11 -> got
IRQ 11
PCI: Found IRQ 11 for device 00:09.0
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xc4800000,
00:e0:29:6e:11:da, IRQ 11
IRQ for 00:0a.0:0 -> PIRQ 03, mask deb8, excl 0c20 -> newirq=5 -> got
IRQ 10
PCI: Found IRQ 10 for device 00:0a.0
IRQ routing conflict in pirq table for device 00:0a.0
eth1: RealTek RTL8139 Fast Ethernet at 0xc4802000, 00:48:54:67:17:e9,
IRQ 5
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB32 PnP detected
sb: ISAPnP reports 'Creative SB32 PnP' at i/o 0x220, irq 9, dma 1, 5
sb: Interrupt test on IRQ9 failed - Probable IRQ conflict
sb: 1 Soundblaster PnP card(s) found.
ISAPnP reports AWE32 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM2048k)>
ACPI: Core Subsystem version [20010208]
ACPI: SCI (IRQ9) allocation failed
ACPI: Subsystem enable failed
Trying to free free IRQ9

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
