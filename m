Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281232AbRKZAeR>; Sun, 25 Nov 2001 19:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281270AbRKZAeI>; Sun, 25 Nov 2001 19:34:08 -0500
Received: from sis.com.tw ([203.67.208.3]:5530 "EHLO maillog.sis.com.tw")
	by vger.kernel.org with ESMTP id <S281232AbRKZAeA>;
	Sun, 25 Nov 2001 19:34:00 -0500
From: "kmliu" <kmliu@sis.com.tw>
To: "Nelson Lee" <nelson@sis.com.tw>, "Krzysztof Oledzki" <ole@ans.pl>
Cc: "JTLee" <jtlee@sis.com.tw>, <andre@linux-ide.org>,
        "charles" <charles@sis.com.tw>, <linux-kernel@vger.kernel.org>
Subject: RE: SiS601?!
Date: Mon, 26 Nov 2001 08:15:33 +0800
Message-ID: <NDBBJBFIOLNMNHAELGHFMEGNCJAA.kmliu@sis.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.33.0111240137010.21639-100000@dark.pcgames.pl>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id LAA18018


SiS406 seems too old to support it.

I do not have any idea about SiS406/SiS601.



-----Original Message-----
From: Krzysztof Oledzki [mailto:ole@ans.pl]
Sent: Saturday, November 24, 2001 8:46 AM
To: Nelson Lee
Cc: kmliu; linux-kernel@vger.kernel.org; ron; JasonTsai; charles; andre@linux-ide.org
Subject: Re: SiS601?!




On Fri, 23 Nov 2001, Nelson Lee wrote:

> ----- Original Message -----
> From: "kmliu" <kmliu@sis.com.tw>
> Sent: Friday, November 23, 2001 8:11 AM
>
> > Hi,
> >
> > We do not have any product which name is SiS601,
> >
> > The IDE controller is SiS5513, the north bridge is
> SiS620/530/630/540/550/635/735/730/740/640/645/640.
> >
> > Please make sure what is the name of the chipset.
> >
> > Nelson:
> >
> > Do we have SiS601 in notebook market?
> K.M.:
>
> No, we do not have.

Ok, let's try this:

$ lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 85C501/2
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
00:01.1 IDE interface: Silicon Integrated Systems [SiS] 85C601 (rev 01)
00:11.0 VGA compatible controller: Trident Microsystems TGUI 9660/968x/968x (rev d3)
00:13.0 PCMCIA bridge: Cirrus Logic CL 6729 (rev 07)

$ lspci -n
00:00.0 Class 0600: 1039:0406
00:01.0 Class 0601: 1039:0008 (rev 01)
00:01.1 Class 0101: 1039:0601 (rev 01)
00:11.0 Class 0300: 1023:9660 (rev d3)
00:13.0 Class 0605: 1013:1100 (rev 07)

$ lspci -v
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 85C501/2
        Flags: bus master, fast devsel, latency 0

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
        Flags: bus master, medium devsel, latency 0

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 85C601 (rev 01)
(prog-if 00 [])
        Flags: medium devsel, IRQ 14
        I/O ports at 0174
        I/O ports at 01f4
        I/O ports at 0374
        I/O ports at 03f4

00:11.0 VGA compatible controller: Trident Microsystems TGUI
9660/968x/968x (rev d3) (prog-if 00 [VGA])
        Flags: medium devsel
        Memory at fe400000 (32-bit, non-prefetchable)
        Memory at fedf0000 (32-bit, non-prefetchable)
        Memory at fe800000 (32-bit, non-prefetchable)

00:13.0 PCMCIA bridge: Cirrus Logic CL 6729 (rev 07)
        Flags: stepping, slow devsel
        I/O ports at 03e0

$ lspci -s 00:01.1 -vvvxxx
00:01.1 IDE interface: Silicon Integrated Systems [SiS] 85C601 (rev 01) (prog-if 00 [])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 0174
	Region 1: I/O ports at 01f4
	Region 2: I/O ports at 0374
	Region 3: I/O ports at 03f4
00: 39 10 01 06 01 00 00 02 01 00 01 01 00 00 80 00
10: 75 01 00 00 f5 01 00 00 75 03 00 00 f5 03 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00
40: f2 f2 f2 f2 00 f3 00 f3 88 00 00 00 00 00 80 00
50: 75 01 00 00 f5 01 00 00 75 03 00 00 f5 03 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 39 10 01 06 01 00 00 02 01 00 01 01 00 00 80 00
90: 75 01 00 00 f5 01 00 00 75 03 00 00 f5 03 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 39 10 01 06 01 00 00 02 01 00 01 01 00 00 80 00
d0: 75 01 00 00 f5 01 00 00 75 03 00 00 f5 03 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

So, you can see that this mus be an IDE interface, it has:
        Interrupt: pin A routed to IRQ 14
        Region 0: I/O ports at 0174
        Region 1: I/O ports at 01f4
        Region 2: I/O ports at 0374
        Region 3: I/O ports at 03f4

and according to lspci it is Silicon Integrated Systems [SiS] 85C601 (rev 01).


My notebook is ARISTO model FT-9000.


Best regards,


				Krzysztof Oledzki
ý:.žË›±Êâmçë¢kaŠÉb²ßìzwm…ébïîžË›±Êâmébžìÿ‘êçz_âžØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Þ—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨þ)ß£ømšSåy«­æ¶…­†ÛiÿÿðÃí»è®å’i
