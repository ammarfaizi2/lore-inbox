Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284688AbRLIXsv>; Sun, 9 Dec 2001 18:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLIXsm>; Sun, 9 Dec 2001 18:48:42 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:29458 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S284688AbRLIXsY>; Sun, 9 Dec 2001 18:48:24 -0500
Subject: Re: 2.4.16 / 2.4.17pre6 hang when loading agpgart
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Roel Teuwen <Roel.Teuwen@advalvas.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1007942424.342.0.camel@tux3>
In-Reply-To: <1007942424.342.0.camel@tux3>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Dec 2001 17:40:30 -0600
Message-Id: <1007941275.1507.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-09 at 18:00, Roel Teuwen wrote:
> On my HP Omnibook 4150, 2.4.16 and 2.4.17-pre6 hang on boot right after
> the messages below.
> I need to press the reset button and load a kernel without agpgart
> compiled in to boot. When compiled as a module, the machine hangs after
> printing these lines when loading the module.
> 
> "
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory : 96M
> agpgart: Detected Intel 440BX chipset
> "
> 
> I selected the agpgart "440BX" option in menuconfig.
> AGP information :
> 
> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev
> 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, 66Mhz, medium devsel, latency 128
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> 	Memory behind bridge: fe700000-fecfffff
> 	Prefetchable memory behind bridge: fd000000-fe3fffff

I had the same problem after upgrading the BIOS on a Trigem Napoli-2
mainboard with a 440BX (eMachine 500a). Tested with kernels 2.4.5-RH
through 2.4.13-ac7. With Bios image v1.12 it hangs with agpgart built in
or on module load exactly as you described, it also fails when I use
nvidia's NVdriver agp support. After upgrading to Bios 1.13 the problem
went away.

Something to check for anyway...

For completeness, my working setup displays the normal kernel apggart
info and shows this:

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fc600000-fe6fffff
        Prefetchable memory behind bridge: f0400000-f44fffff

Regards,
Reid

