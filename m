Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRABCVd>; Mon, 1 Jan 2001 21:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRABCVX>; Mon, 1 Jan 2001 21:21:23 -0500
Received: from ool-18bfe8a9.dyn.optonline.net ([24.191.232.169]:44422 "EHLO
	optonline.net") by vger.kernel.org with ESMTP id <S129655AbRABCVJ>;
	Mon, 1 Jan 2001 21:21:09 -0500
From: Les Schaffer <schaffer@optonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14929.13173.272621.321333@optonline.net>
Date: Mon, 1 Jan 2001 20:48:37 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: ne2000 (ISA) & test11+
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: Les Schaffer <schaffer@optonline.net>
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: [V?bWTh\+_V")"gXxY9KGQozO(|>ggwp;\Ds6@YGoS$wreQaSLmhWUp%V;okpj4C^i$FQWK
 Q:/luO.Zh=VP"U5M.%m1cK:v9DgiQp^JK47nxE^=e3~HPoLmY,igNBZo)LUT3a2CFm*chsyaq7~=dU
 _IX>v[h$BZsa*yn5;?{|3Z@ZI@FL(e`-@wq`f?~{1){A%o:/t"39M@}ER]6.62NbfxrD%!{9!So^\9
 c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Second: I'm having problems loading my ne2000 (ISA) card as a module

ditto for myself since i started using new SMP machine sometime around
2.4.0-test8 or so.

the modprobe works the second time (and subsequently) when i run it by
hand after boot scripts finish.

i've tried all kinds of combinations of insmod/modprobe/isapnp etc
with no luck. wouldnt mind tracking this annoyance down.

boot log:

Jan  1 08:03:18 localhost kernel: isapnp: Scanning for Pnp cards...
Jan  1 08:03:18 localhost kernel: isapnp: Card 'NDC Plug & Play Ethernet Card'
Jan  1 08:03:18 localhost kernel: isapnp: 1 Plug & Play card detected total
Jan  1 08:03:18 localhost kernel: ne.c: No NE*000 card found at i/o = 0x220
[snip eth0]
Jan  1 08:03:18 localhost kernel: ne.c: No NE*000 card found at i/o = 0x220
Jan  1 08:03:18 localhost kernel: ne.c: No NE*000 card found at i/o = 0x220
[snip sound card / parallel port ]
Jan  1 08:03:21 localhost kernel: ne.c: No NE*000 card found at i/o = 0x220
Jan  1 08:03:21 localhost insmod: /lib/modules/2.4.0-test12/kernel/drivers/net/ne.o: init_module: No such device or address
Jan  1 08:03:21 localhost insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
Jan  1 08:03:21 localhost insmod: /lib/modules/2.4.0-test12/kernel/drivers/net/ne.o: insmod eth1 failed
Jan  1 08:03:23 localhost kernel: ne.c: No NE*000 card found at i/o = 0x220
Jan  1 08:03:23 localhost insmod: /lib/modules/2.4.0-test12/kernel/drivers/net/ne.o: init_module: No such device or address
Jan  1 08:03:23 localhost insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
Jan  1 08:03:23 localhost insmod: /lib/modules/2.4.0-test12/kernel/drivers/net/ne.o: insmod eth1 failed
[finish boot]

then modprobe by hand:

Jan  1 08:03:59 localhost kernel: ne.c: ISAPnP reports Generic PNP at i/o 0x220, irq 5.
Jan  1 08:03:59 localhost kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Jan  1 08:03:59 localhost kernel: Last modified Nov 1, 2000 by Paul Gortmaker
Jan  1 08:03:59 localhost kernel: NE*000 ethercard probe at 0x220: 00 80 c6 f5 19 08
Jan  1 08:03:59 localhost kernel: eth1: NE2000 found at 0x220, using IRQ 5.

les schaffer

debian unstable 
SMP 

(speggy)/var/log/: lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 23)
[snip]

from e/tc/modules.conf:

alias eth1 ne
options ne irq=5 io=0x220
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
