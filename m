Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271970AbTG2TlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271997AbTG2TlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:41:25 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:6581 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271970AbTG2TlX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:41:23 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Tue, 29 Jul 2003 16:41:20 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
In-Reply-To: <89B48AF68E2@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.56.0307291628130.153@pervalidus.dyndns.org>
References: <89B48AF68E2@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Petr Vandrovec wrote:

> On 29 Jul 03 at 2:14, Frédéric L. W. Meunier wrote:
> > On Tue, 29 Jul 2003, Petr Vandrovec wrote:
> > > On Mon, Jul 28, 2003 at 08:34:40PM -0300, Frédéric L. W. Meunier wrote:
> >
> > Thanks. It worked (and I don't see any screen corruption).
> >
> > Maybe I'm missing something, but is there anything wrong with
> > video=matroxfb:vesa:0x1B5 ? I got
>
> I have no idea...
>
> > Kernel command line: BOOT_IMAGE=3 root=307 acpi=off noapic video=matroxfb:vesa:0x1B5
> > Console: colour VGA+ 80x25
> > matroxfb: Matrox G400 (AGP) detected
> > matroxfb: MTRR's turned on
> > matroxfb: 800x600x24bpp (virtual: 800x65536)
> > matroxfb: framebuffer at 0xD8000000, mapped to 0xe0805000, size 33554432
> > fb0: MATROX frame buffer device
> > fb0: initializing hardware
> > matroxfb: cannot set xres to 800, rounded up to 832
> > Console: switching to colour frame buffer device 100x37
> >  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
> > Console: switching to colour frame buffer device 100x37
>
> ... but it looks strange to me that you have two 'switching to...' lines.

I don't have two with your patch.

> Unless it gets proven that it is bug in kernel's matroxfb and not
> in generic fbcon (== if you'll send me a patch, I'll apply it; but do
> not expect that I'll hunt down bugs which do not occur with matroxfb-2.5.72
> addon), I recommend you applying
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz.
> It reinstates back fbcon layer I understand & trust...

2 other problems went away with your patch. When I reported no
screen corruption I was wrong since it messed everything
returning from XFree86, including getting a dump of a Windows
reboot. The other is the boot logo, which now appears.
