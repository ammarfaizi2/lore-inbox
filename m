Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbRAaQkE>; Wed, 31 Jan 2001 11:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRAaQj5>; Wed, 31 Jan 2001 11:39:57 -0500
Received: from venus.postmark.net ([207.244.122.71]:15632 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S129996AbRAaQjq>; Wed, 31 Jan 2001 11:39:46 -0500
Message-ID: <20010131174231.12356.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox G450 problems with 2.4.0 and xfree
Date: Wed, 31 Jan 2001 17:41:39 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Petr,

 I think I might have something to add to this discussion, but then
again you probably know this already!

On Tue Jan 30 2001 Petr Vandrovec wrote:
> > > > Installed a Matrox G450 on my linux system. Now it has
> > > > problems booting. The kernel is compiled with framebuffer
> > > > support so is supposed to boot up with the Linux logo.
> > > > Unfortunately the systems hangs when the kernel switches to
> > > > the graphics mode. When I first boot into windoze and the
> > > > reboot to linux it works fine. So it looks like an
> > > > initialisation problem...

<snip>

> Windows drivers works around somehow, as after booting
> to Windows matroxfb works fine - but without Windows it is just
> pure luck.

 I have a similar problem to the one outlined above with kernel 2.4.x
(hardware details below).

 I don't have Windows installed on my machine, but I find that if I
cold boot to 2.2 (RH7) first and start up X (4.0.2 with Matrox driver
1.00.04 compiled in), I am then able to "shutdown -r now" and warm
restart to 2.4 with FB acceleration enabled. This generally works
fine
for me.

 The 2.2 kernel I have (2.2.16 Redhat 7.0 standard) does not have FB
enabled

 This isn't generally too much of a problem because 2.4.x is so
stable
I don't have to reboot for weeks!

> It looks like that if you compile 'agpgart' into kernel, chances
> that it will work are better, but I have also reports that it did
> not changed anything.

 I have agpgart compiled directly in (not as a module) to the kernel,
but this does not seem to relieve any of the cold boot problems :-(

 I'm willing to try out some patches if that would be useful.

Note: Please CC me as I'm not subscribed to l-k.


My hardware is:
  Matrox G450
  Duron 750
  128 Mb Ram
  Aopen AK33 m/b with VIA KT133 / 686A chipset

relevant lspci output:

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0641
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d8000000 (32-bit, prefetchable) [size=32M]
	Memory at da000000 (32-bit, non-prefetchable) [size=16K]
	Memory at db000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

    John
----------------
jbk@postmark.net


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
