Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbSKSSB6>; Tue, 19 Nov 2002 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSKSSB6>; Tue, 19 Nov 2002 13:01:58 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:57830 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267025AbSKSSB4>;
	Tue, 19 Nov 2002 13:01:56 -0500
Date: Tue, 19 Nov 2002 10:08:31 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ian G Batten <I.G.Batten@ftel.co.uk>
Cc: David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: Orinoco pcmcia fails in 2.5.47, OK in 2.5.43
Message-ID: <20021119180831.GA24834@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian G Batten wrote :
> Booting 2.5.47 on a Fujitsu B110 laptop, 233 Pentium MMX, Yenta
> interface, I get this trace below.  It worked correctly under 2.5.43.
> 
> Nov 18 19:03:02 lifebook cardmgr[506]: shutting down socket 0 
> Nov 18 19:03:02 lifebook cardmgr[506]: executing: 'modprobe -r orinoco_cs'
> Nov 18 19:03:02 lifebook cardmgr[506]: executing: 'modprobe -r orinoco'
> Nov 18 19:03:02 lifebook cardmgr[506]: executing: 'modprobe -r hermes'
> Nov 18 19:03:02 lifebook kernel: bad: scheduling while atomic!
> Nov 18 19:03:02 lifebook kernel: Call Trace: [<c0114f9e>]  [<c0120e2f>]  [<c0120da0>]
> [<c0203894>]  [<c0205b6b>]  [<c02076ec>]  [<c017a580>]  [<c016ce6c>]  [<c016cecd>]
> [<c01714e8>]  [<c017154e>]  [<c0179f7e>]  [<c01718c1>]  [<c014177b>]  [<c0179f16>]
> [<c014177b>]  [<c0179f16>]  [<c0142ac4>]  [<c0179f7e>]  [<c01718c1>]  [<c017f9db>]
> [<c0171854>]  [<c0171865>]  [<c0115370>]  [<c017a983>]  [<c016e0c2>]  [<c0176763>]
> [<c0155032>]  [<c015608e>]  [<c0154806>]  [<c014acbd>]  [<c015372c>]  [<c015372c>]
> [<c014ada0>]  [<c014d10b>]  [<c014f3a7>]  [<c013f8f6>]  [<c0108d47>] 
> Nov 18 19:03:06 lifebook cardmgr[506]: initializing socket 0
> Nov 18 19:03:06 lifebook cardmgr[506]: socket 0: NETGEAR MA401 Wireless PC
> Nov 18 19:03:06 lifebook cardmgr[506]: executing: 'modprobe hermes'
> Nov 18 19:03:06 lifebook cardmgr[506]: + modprobe: Can't locate module hermes
> Nov 18 19:03:06 lifebook cardmgr[506]: modprobe exited with status 255
> Nov 18 19:03:06 lifebook cardmgr[506]: module /lib/modules/2.5.47/pcmcia/hermes.o not available 
> Nov 18 19:03:06 lifebook cardmgr[506]: executing: 'modprobe orinoco'
> Nov 18 19:03:06 lifebook cardmgr[506]: + modprobe: Can't locate module orinoco
> Nov 18 19:03:06 lifebook cardmgr[506]: modprobe exited with status 255
> Nov 18 19:03:06 lifebook cardmgr[506]: module /lib/modules/2.5.47/pcmcia/orinoco.o not available
> Nov 18 19:03:06 lifebook cardmgr[506]: executing: 'modprobe orinoco_cs'
> Nov 18 19:03:06 lifebook cardmgr[506]: + modprobe: Can't locate module orinoco_cs
> Nov 18 19:03:07 lifebook cardmgr[506]: modprobe exited with status 255 
> Nov 18 19:03:07 lifebook cardmgr[506]: module /lib/modules/2.5.47/pcmcia/orinoco_cs.o not available
> Nov 18 19:03:08 lifebook cardmgr[506]: get dev info on socket 0 failed: Resource temporarily unavailable  -

	David Gibson is the maintainer of Orinoco.
	But, to be fair, it looks like a module issue or generic
Pcmcia issue because the modules fails even before beeing loaded, so
it's hard to blame the modules. I don't know who is the *real*
maintainer of Pcmcia in 2.5.X, and for modules issues just look around
on LKML.
	Note that with 2.5.X, it's normal for the "insmod" of Pcmcia
modules to fail, but "modprobe" should pick properly the modules where
they are. Make sure the modules exist in /lib/modules/...

> I'm compiling 2.5.47 to get the latest IRDA bits.

	The individual patches are available on my web page, so you
can upgrade your older kernel.

> ian

	Good luck...

	Jean
