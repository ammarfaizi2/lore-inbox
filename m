Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUQmf>; Wed, 21 Feb 2001 11:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbRBUQmZ>; Wed, 21 Feb 2001 11:42:25 -0500
Received: from ptolemy.arc.nasa.gov ([128.102.112.134]:38785 "EHLO
	ptolemy.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S129051AbRBUQmK>; Wed, 21 Feb 2001 11:42:10 -0500
Date: Wed, 21 Feb 2001 08:42:12 -0800
From: Dan Christian <dac@ptolemy.arc.nasa.gov>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang on mount, 2.4.2-pre4, VIA
Message-ID: <20010221084211.A18740@ptolemy.arc.nasa.gov>
In-Reply-To: <20010220101622.A18117@ptolemy.arc.nasa.gov> <20010220192848.B6846@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220192848.B6846@suse.cz>; from vojtech@suse.cz on Tue, Feb 20, 2001 at 07:28:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more info.  I tried disabling the hdparm command, that didn't
make the 2.4.2-pre4 mount succesfully.

I tried 2.4.2-pre1 and that booted fine.

I'll try pre2 and pre3 versions when I get a chance (thursday night)
and see about turning up the log level, too.

Here is the info on PCI and the drives.  I edited out the sound, scsi,
usb, etc.

-Dan

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d4000000-d7ffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 21)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

/dev/hda:

 Model=Maxtor 51024U2, FwRev=DA620CQ0, SerialNo=K205799C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=19999728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 

/dev/hdb:

 Model=Maxtor 51536U3, FwRev=DA620CQ0, SerialNo=K3H4HFDC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=29888820
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 

-- 



On Tue, Feb 20, 2001 at 07:28:48PM +0100, Vojtech Pavlik wrote:
> On Tue, Feb 20, 2001 at 10:16:22AM -0800, Dan Christian wrote:
> 
> > Hello,
> >   I just tried upgrading to 2.4.2-pre4 from 2.4.1 and get a hang when
> > mounting the file systems.  I have the same problem with 2.4.1-ac18.
> > 
> > The system is a single processor P3 and uses a VIA chipset (Tyan
> > something-or-other).  DMA, multi-sector IO, and 32bit sync are enabled
> > using hdparm (just before the hang).

-- 
Dan Christian		(650) 604-4507		FAX 604-4036
NASA Ames Research Center, Mail Stop 269-3, Moffett Field, CA 94035
