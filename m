Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSIOq>; Tue, 19 Dec 2000 03:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLSIOf>; Tue, 19 Dec 2000 03:14:35 -0500
Received: from SMTP3.ANDREW.CMU.EDU ([128.2.10.83]:47813 "EHLO
	smtp3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S129289AbQLSIOR>; Tue, 19 Dec 2000 03:14:17 -0500
Date: Tue, 19 Dec 2000 02:43:35 -0500 (EST)
From: Ari Heitner <aheitner@andrew.cmu.edu>
Reply-To: Ari Heitner <aheitner@andrew.cmu.edu>
To: rsousa@grad.physics.sunysb.edu
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        emu10k1-devel@opensource.creative.com
Subject: emu10k1 broken in 2.2.18
Message-ID: <Pine.SOL.3.96L.1001219022620.533B-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan/Rui,

just built 2.2.18 (on a box that's been running 2.2.14 for a very very long
time, and loading an emu10k1 module from opensource.creative.com or wherever). 

was pleased to note that emu10k1 finally made it in. Compiled and built. Dmesg
indicated that things were detecting nicely, but attempts to play sound result
in 'Cannot open /dev/dsp!' (not a rights problem). I had heard a bit earlier
this evening on #debian that someone was complaining of similar problems on a
2.2.17->2.2.18 upgrade, so on a hunch i pulled down a 2.2.17 kernel, and make
oldconfig'd it with my 2.2.18 config.

dmesg again fine, this time it works :) so there does appear to be a problem
there.

templestowe:~$ dmesg |less
Linux version 2.2.17 (root@templestowe) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 Tue Dec 19 01:44:23 EST 2000
...
Creative EMU10K1 PCI Audio Driver, version 0.6, 01:45:48 Dec 19 2000
emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xe400-0xe41f, IRQ 10
...

machine is running debian sid. i'll be happy to do anything else anyone
suggests to play with this. I did diff out the source file by file in
drivers/sound/emu10k1 (my *god* since when did this driver need to be 8k+ lines
of code? i just wrote a kernel and filesystem for my CMU OS class [15-412] in
that many lines :)  ... and there's more than i'm prepared to deal with.

is this driver working for anyone else in 2.2.18? anyone recall the reasoning
behind this patch set (i may well have missed it going by on l-k)?

perhaps this is just a known problem by now but i haven't seen mention on l-k
so i'll risk the wrath of the appropriate gods.


Cheers,

Ari Heitner



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
