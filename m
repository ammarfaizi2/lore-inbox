Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271962AbRIDMnQ>; Tue, 4 Sep 2001 08:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRIDMnH>; Tue, 4 Sep 2001 08:43:07 -0400
Received: from [144.137.83.84] ([144.137.83.84]:54262 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S271962AbRIDMmw>;
	Tue, 4 Sep 2001 08:42:52 -0400
Message-ID: <3B94C8A9.EA7D4E72@eyal.emu.id.au>
Date: Tue, 04 Sep 2001 22:27:21 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v1.4d file/swap crypto package
In-Reply-To: <3B93B32A.69D25916@pp.inet.fi> <3B93EE69.5674035F@eyal.emu.id.au> <3B940291.C752F45B@pp.inet.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> 
> Eyal Lebedinsky wrote:
> > Jari Ruusu wrote:
> > > In short: If file and swap crypto is all you need, this package is a hassle
> > > free replacement for international crypto patch and HVR's crypto-api.
> >
> > 1) It claims to allow you to specify the kernel sources dir, but it then
> > runs 'depmod' without a nominated version which is only valid if you
> > are building for the running kernel. I now have it doing
> >         depmod -ae $(KERNELRELEASE)
> 
> I will fix that in next release. However, most systems (if not all) run
> depmod from bootup initialization scripts. Depmod from the Makefile is only
> needed when you intend to use the driver immediately without rebooting.

Problem is that one gets tons of errors due to the use of the wrong
kernel.
The exact way for doing it right is actually:
	depmod -ae $(KERNELRELEASE) -F $(LS)/System.map

> Loop-AES build instructions _require_ you to disable the loop driver in the
> kernel. If you have two loop.o drivers, you skipped some build instructions.

It is not in the kernel, it is in my /lib/modules as it was built
originally.
I want to keep it there while I play with the new module, and not lose
the
original. Naturally, just my preference, not everybodies.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
