Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbSKLSgp>; Tue, 12 Nov 2002 13:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSKLSgp>; Tue, 12 Nov 2002 13:36:45 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:50628
	"EHLO eumucln01.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S266712AbSKLSgm>; Tue, 12 Nov 2002 13:36:42 -0500
Message-ID: <3DD14B7D.8F599BA7@mscsoftware.com>
Date: Tue, 12 Nov 2002 19:42:05 +0100
From: Martin Knoblauch <"martin.knoblauch "@mscsoftware.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre10-ac2-mkn i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory performance on Serverworks GC-LE based system poor?
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.16.0.0; VDF: 6.16.0.17
	 at mailmuc has not found any known virus in this email.
X-MIMETrack: Itemize by SMTP Server on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 11/12/2002 07:38:58 PM,
	Serialize by Router on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 11/12/2002 07:39:05 PM,
	Serialize complete at 11/12/2002 07:39:05 PM
Content-Type: multipart/mixed;
 boundary="------------10E33BC4750B125B49E659C5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------10E33BC4750B125B49E659C5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

> Re: Memory performance on Serverworks GC-LE based system poor?
> 
>> 
> On Mon, 2002-11-11 at 00:51, Dave Jones wrote:
> > On Mon, Nov 11, 2002 at 01:30:13AM +0100, Martin Knoblauch wrote:
> >
> > > I have experienced extreme low STREAMS numbers (about 600 MB/sec for Triad)
> > > on two dual CPU systems based on the ServerWorks GC-LE chipset (SuperMicro
> > > P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR memory and
> > > were running kernel 2.4.18. I would usually expect STREAMS numbers of about
> > > 2000 MB/sec for this kind of systems.
> > >
> > > Does this ring any bells?
> >
> > ISTR serverworks LE errata with MTRRs and write-combining.
> > Whether this is biting you or not I can't say.
> 
> Write combining would really only bite graphics cards. The only other
> performance errata I know about affects the CIOB20 earlier revisions
> (vendor serverworks id 0x0006)
> 


 does anybody know what the following ServerWorks device ids are? I
could not find them in the include file:

0012
0000
0101

 Maybe their nonrecognition by the kernel is related to my problem?

Martin
--------------10E33BC4750B125B49E659C5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii;
 name="lspci.marge1"
Content-Disposition: inline;
 filename="lspci.marge1"

marge1$ lspci
00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
00:00.1 Host bridge: ServerWorks: Unknown device 0012
00:00.2 Host bridge: ServerWorks: Unknown device 0000
00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0225
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
02:02.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:02.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
marge1$ lspci -v
00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
        Flags: fast devsel

00:00.1 Host bridge: ServerWorks: Unknown device 0012
        Flags: fast devsel

00:00.2 Host bridge: ServerWorks: Unknown device 0000
        Flags: fast devsel

00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 18
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at c800 [size=256]
        Memory at fe7ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe7c0000 [disabled] [size=128K]
        Capabilities: <available only to root>

00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 17
        Memory at fe7fc000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ce80 [size=64]
        Memory at fe780000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fe770000 [disabled] [size=64K]
        Capabilities: <available only to root>

00:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at fe7fd000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at cf00 [size=64]
        Memory at fe7a0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fe7e0000 [disabled] [size=64K]
        Capabilities: <available only to root>

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: Unknown device d915:5539
        Flags: bus master, medium devsel, latency 64

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Flags: bus master, medium devsel, latency 64
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4
        I/O ports at 0170 [size=8]
        I/O ports at 0374
        I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fe7fe000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks: Unknown device 0225
        Subsystem: Unknown device d915:5539
        Flags: bus master, medium devsel, latency 0

00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: <available only to root>

00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: <available only to root>

02:02.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Unknown device d915:5539
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 30
        BIST result: 00
        I/O ports at e400 [disabled] [size=256]
        Memory at febfe000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: <available only to root>

02:02.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
        Subsystem: Unknown device d915:5539
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 31
        BIST result: 00
        I/O ports at e800 [disabled] [size=256]
        Memory at febff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: <available only to root>

marge1$ lspci -vn
00:00.0 Class 0600: 1166:0012 (rev 13)
        Flags: fast devsel

00:00.1 Class 0600: 1166:0012
        Flags: fast devsel

00:00.2 Class 0600: 1166:0000
        Flags: fast devsel

00:02.0 Class 0300: 1002:4752 (rev 27)
        Subsystem: 1002:0008
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 18
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at c800 [size=256]
        Memory at fe7ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe7c0000 [disabled] [size=128K]
        Capabilities: <available only to root>

00:04.0 Class 0200: 8086:1229 (rev 0d)
        Subsystem: 8086:1050
        Flags: bus master, medium devsel, latency 64, IRQ 17
        Memory at fe7fc000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ce80 [size=64]
        Memory at fe780000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fe770000 [disabled] [size=64K]
        Capabilities: <available only to root>

00:05.0 Class 0200: 8086:1229 (rev 0d)
        Subsystem: 8086:1050
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at fe7fd000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at cf00 [size=64]
        Memory at fe7a0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fe7e0000 [disabled] [size=64K]
        Capabilities: <available only to root>

00:0f.0 Class 0601: 1166:0201 (rev 93)
        Subsystem: d915:5539
        Flags: bus master, medium devsel, latency 64

00:0f.1 Class 0101: 1166:0212 (rev 93) (prog-if 8a [Master SecP PriP])
        Subsystem: 1166:0212
        Flags: bus master, medium devsel, latency 64
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4
        I/O ports at 0170 [size=8]
        I/O ports at 0374
        I/O ports at ffa0 [size=16]

00:0f.2 Class 0c03: 1166:0220 (rev 05) (prog-if 10)
        Subsystem: 1166:0220
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fe7fe000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Class 0600: 1166:0225
        Subsystem: d915:5539
        Flags: bus master, medium devsel, latency 0

00:11.0 Class 0600: 1166:0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: <available only to root>

00:11.2 Class 0600: 1166:0101 (rev 03)
        Flags: 66Mhz, medium devsel
        Capabilities: <available only to root>

02:02.0 Class 0100: 9005:00cf (rev 01)
        Subsystem: d915:5539
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 30
        BIST result: 00
        I/O ports at e400 [disabled] [size=256]
        Memory at febfe000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: <available only to root>

02:02.1 Class 0100: 9005:00cf (rev 01)
        Subsystem: d915:5539
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 31
        BIST result: 00
        I/O ports at e800 [disabled] [size=256]
        Memory at febff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: <available only to root>

marge1$ lspci -n
00:00.0 Class 0600: 1166:0012 (rev 13)
00:00.1 Class 0600: 1166:0012
00:00.2 Class 0600: 1166:0000
00:02.0 Class 0300: 1002:4752 (rev 27)
00:04.0 Class 0200: 8086:1229 (rev 0d)
00:05.0 Class 0200: 8086:1229 (rev 0d)
00:0f.0 Class 0601: 1166:0201 (rev 93)
00:0f.1 Class 0101: 1166:0212 (rev 93)
00:0f.2 Class 0c03: 1166:0220 (rev 05)
00:0f.3 Class 0600: 1166:0225
00:11.0 Class 0600: 1166:0101 (rev 03)
00:11.2 Class 0600: 1166:0101 (rev 03)
02:02.0 Class 0100: 9005:00cf (rev 01)
02:02.1 Class 0100: 9005:00cf (rev 01)

--------------10E33BC4750B125B49E659C5--

