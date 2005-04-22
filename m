Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVDVOlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVDVOlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVDVOlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 10:41:07 -0400
Received: from vega.lnet.lut.fi ([157.24.109.150]:41482 "EHLO vega.lnet.lut.fi")
	by vger.kernel.org with ESMTP id S261948AbVDVOkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 10:40:49 -0400
Date: Fri, 22 Apr 2005 17:40:47 +0300
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rth@twiddle.net,
       adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
Message-ID: <20050422144047.GY607@vega.lnet.lut.fi>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de> <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422112030.GW607@vega.lnet.lut.fi>
User-Agent: Mutt/1.3.28i
From: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 02:20:30PM +0300, Tomi Lapinlampi wrote:
> 
> Actually, I was able to get a clean compile with the patch from
> http://marc.theaimsgroup.com/?l=linux-alpha&m=111392038121433&w=2

Hi again,

Although the tgafb driver compiles with the above patch, it shows
similar behaviour as before: The kernel loads, the monitor comes alive
but the screen stays completely blank.
The last kernel that worked was 2.6.8.1. I've tested with 2.6.{9,10,11}

Here's more info on the system... The dmesg entry (booting with serial console)

Linux version 2.6.12-rc3 (lapinlam@raato) (gcc version 3.3.5 (Debian 1:3.35
Booting on Alcor variation Alcor using machine vector Alcor from MILO
Major Options: LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ
Command line: ro root=/dev/sdb1 console=ttyS0,38400n8
memcluster 0, usage 1, start        0, end      161
memcluster 1, usage 0, start      161, end    32651
memcluster 2, usage 1, start    32651, end    32768
freeing pages 161:384
freeing pages 838:32651
reserving pages 838:839
2048K Bcache detected; load hit latency 24 cycles, load miss latency 88 cycles
pci: cia revision 1
Built 1 zonelists
Kernel command line: ro root=/dev/sdb1 console=ttyS0,38400n8
PID hash table entries: 1024 (order: 10, 32768 bytes)
Using epoch = 2000
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 253320k/261208k available (2077k kernel code, 6264k reserved, 683k data)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
EISA bus registered
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
PCI: Bridge: 0000:00:08.0
  IO window: 9000-9fff
  MEM window: 02200000-022fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:09.0
  IO window: disabled.
  MEM window: 02400000-027fffff
  PREFETCH window: disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Initializing Cryptographic API
Console: switching to colour frame buffer device 80x30
tgafb: DC21030 [TGA] detected, rev=0x03
tgafb: at PCI bus 0, device 7, function 0
fb0: Digital ZLXp-E1 frame buffer device at 0x8000000
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered

.....

lspci -v -v for the display adapter:

0000:00:07.0 Display controller: Digital Equipment Corporation DECchip 21030 [TGA] (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at 0000000008000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 0000000002300000 [disabled] [size=256K]

Any clues? It would be nice to get this working again. I'm willing to
test any patches you might have :)

Tomi

-- 
You can decide: live with free software or with only one evil company left?
