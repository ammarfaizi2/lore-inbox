Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQKTRJu>; Mon, 20 Nov 2000 12:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQKTRJk>; Mon, 20 Nov 2000 12:09:40 -0500
Received: from wg.redhat.de ([193.103.254.4]:18239 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S129166AbQKTRJ1>;
	Mon, 20 Nov 2000 12:09:27 -0500
Date: Mon, 20 Nov 2000 17:39:26 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: <linux-kernel@vger.kernel.org>
Subject: de4x5 hangs in 2.4.0-test11-pre7
Message-ID: <Pine.LNX.4.30.0011201732020.16038-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The de4x5 driver crashed on me twice today (on a 2 CPU x86 box); The
network went down for no visible reason (nothing in syslog or on the console).

The network card is a
00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
        Subsystem: Compu-Shack: Unknown device 4235)
        Subsystem: Unknown device 4942:4c4c
        I/O ports at b800 [size=64]

Shutting down networking, removing the module and re-inserting it
produces:

eth0: DC21143 at 0xd000 (PCI bus 0, device 11), h/w address 00:00:cb:56:48:9b,
eth0: Using generic MII device control. If the board doesn't operate,
please mail the following dump to the author:

MII device address: 5
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f430
MII ANA: 1e1
MII ANC: 0
MII 16:  158
MII 17:  608
MII 18:  10

      and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
eth0: media is 100Mb/s.


and


eth0: DC21143 at 0xd000 (PCI bus 0, device 11), h/w address 00:00:cb:56:48:9b,
eth0: Using generic MII device control. If the board doesn't operate,
please mail the following dump to the author:

MII device address: 5
MII CR:  3000
MII SR:  7809
MII ID0: 15
MII ID1: f430
MII ANA: 1e1
MII ANC: 0
MII 16:  158
MII 17:  408
MII 18:  10

      and requires IRQ17 (provided by PCI BIOS).
de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
eth0: media is 100Mb/s.


LLaP
bero


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
