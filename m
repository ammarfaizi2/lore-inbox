Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLLSb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLLSb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLLSb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:31:26 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:42478 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbVLLSbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:31:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=oXi8iEeu8WEt51BY6dDV1CV3yIRrR7rXg80jP7m91+S/VhoREC5I3PgnkxSJ7kUAESXSEY02MXFcgESMWt6E780mHD5KnHlMMhm7Z+C7k2dYcpj40f59v51z7YavaOc3LQ7iy3PQow212DCM8Mxo0rSFZRjuapTmv3m56csIBsM=
Message-ID: <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>
Date: Mon, 12 Dec 2005 19:31:23 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <439CBE49.2090901@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_28488_27664355.1134412283355"
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
	 <439CBE49.2090901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_28488_27664355.1134412283355
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/12/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jesper Juhl wrote:
> > In addition to the problem I reported earlier about 2.6.15-rc5-mm2
> > hanging at boot with vga=3D791 I've just discovered another problem.
> >
> > If I boot with vga=3Dnormal (which is aparently all that works), then I
> > can boot up to a nice lain text login and run startx, but if I then
> > switch away from X back to a text console with ctrl+alt+f6 or if I
> > shut down X, then I'm presented with a completely garbled text mode
> > screen - flashing coloured blocks all over, random bits of text at
> > random locations etc.
> >
> > Also, when starting X, just before the cursor appears I normally just
> > have a black screen. With this kernel I first get a short blink of a
> > garbled graphics mode screeen with either what looks like just random
> > pixels or sometimes with something that looks like a mangled snapshot
> > of my text mode console, or if I kill X with ctrl+alt+backspace and
> > then start it again (the garbled text mode console does work, although
> > I'm glad I know how to touch type ;) then I sometimes get what looks
> > like a snapshot of my previous X session with random pixels on top.
> > The garbled graphical screen stays for just a blink of an eye, then
> > it's replaced with the normal black screen and the mouse cursor.
> >
> > 2.6.15-rc5-git1 works perfectly without these issues.
>
> I cannot reproduce your problem...
>

It's completely reproducable here when booting the kernel with  vga=3Dnorma=
l
and then starting X with the attached xorg.conf using this grahics card :

# lspci -vvx
...
01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia
AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=3D8K]
        Expansion ROM at e7fe0000 [disabled] [size=3D128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit-
FW- Rate=3D<none>
00: 2b 10 27 05 07 00 b0 02 03 00 00 03 08 40 00 00
10: 08 00 00 e8 00 00 00 e5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 40 08
30: 00 00 fe e7 dc 00 00 00 00 00 00 00 04 01 10 20

note that if I use a fb console everything is fine, only when booting
initially with vga=3Dnormal is there a problem.


> If set, can you comment out Load "dri" and/or Load "glx" from your
> X config?
>
Both were set. Commenting out both didn't change a thing.


> Can you try another X driver, ie, vesa?
>
I'm already using the vesa driver. It seems to be the only Open Source
driver that'll work with this card, so i don't have any other to try.

> Also, these 2 patches are present in mm but not in Linus' tree.  Can
> you check which of these are the culprit, if any?
>
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6=
.15-rc2-mm1/broken-out/vgacon-fix-doublescan-mode.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6=
.15-rc2-mm1/broken-out/vgacon-workaround-for-resize-bug-in-some-chipsets.pa=
tch
>

Since this is 2.6.15-rc5-mm2 I grabbed these two instead:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.1=
5-rc5-mm2/broken-out/vgacon-fix-doublescan-mode.patch
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.1=
5-rc5-mm2/broken-out/vgacon-workaround-for-resize-bug-in-some-chipsets.patc=
h

Reverting both patches didn't fix the problem. Starting X then
switching back to a text mode console still results in a completely
messed up text console. X is fine, I can switch back to it no problem,
but text consoles go bye-bye...

Would there be any point in trying a kernel with just one of the
patches reverted?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_28488_27664355.1134412283355
Content-Type: application/octet-stream; name=xorg.conf
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xorg.conf"

Section "ServerLayout"
	Identifier     "X.org Configured"
	Screen      0  "Screen0" 0 0
#	Screen      1  "Screen1" RightOf "Screen0"
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	ModulePath   "/usr/X11R6/lib/modules"
	FontPath     "/usr/X11R6/lib/X11/fonts/misc/"
	FontPath     "/usr/X11R6/lib/X11/fonts/TTF/"
	FontPath     "/usr/X11R6/lib/X11/fonts/Type1/"
	FontPath     "/usr/X11R6/lib/X11/fonts/CID/"
	FontPath     "/usr/X11R6/lib/X11/fonts/75dpi/"
	FontPath     "/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection

Section "Module"
	Load  "record"
	Load  "extmod"
	Load  "dbe"
#	Load  "dri"
#	Load  "glx"
	Load  "xtrap"
	Load  "freetype"
	Load  "type1"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "kbd"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "Protocol" "ExplorerPS/2"
	Option	    "Device" "/dev/mouse"
	Option      "Buttons" "6"
	Option      "ZAxisMapping" "4 5"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "Monitor Model"
EndSection

#Section "Monitor"
#	Identifier   "Monitor1"
#	VendorName   "Monitor Vendor"
#	ModelName    "Monitor Model"
#EndSection

Section "Device"
	Identifier  "Card0"
	Driver      "vesa"
	VendorName  "Matrox Graphics, Inc."
	BoardName   "MGA Parhelia AGP"
	BusID       "PCI:1:5:0"
EndSection

#Section "Device"
#	Identifier  "Card1"
#	Driver      "mga"
#	VendorName  "Matrox Graphics, Inc."
#	BoardName   "MGA 2164W [Millennium II]"
#	BusID       "PCI:0:10:0"
#EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	Monitor    "Monitor0"
	DefaultDepth 24

	SubSection "Display"
		Viewport   0 0
		Depth     1
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     4
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     8
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     15
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     16
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     24
	EndSubSection
EndSection

#Section "Screen"
#	Identifier "Screen1"
#	Device     "Card1"
#	Monitor    "Monitor1"
#	DefaultDepth 24
#
#	SubSection "Display"
#		Viewport   0 0
#		Depth     1
#		EndSubSection
#		SubSection "Display"
#		Viewport   0 0
#		Depth     4
#	EndSubSection
#	SubSection "Display"
#		Viewport   0 0
#		Depth     8
#	EndSubSection
#	SubSection "Display"
#		Viewport   0 0
#		Depth     15
#	EndSubSection
#	SubSection "Display"
#		Viewport   0 0
#		Depth     16
#	EndSubSection
#	SubSection "Display"
#		Viewport   0 0
#		Depth     24
#	EndSubSection
#EndSection



------=_Part_28488_27664355.1134412283355--
