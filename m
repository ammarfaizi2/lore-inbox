Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAJHl4>; Wed, 10 Jan 2001 02:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbRAJHlr>; Wed, 10 Jan 2001 02:41:47 -0500
Received: from [213.97.45.174] ([213.97.45.174]:7155 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S129584AbRAJHl2>;
	Wed, 10 Jan 2001 02:41:28 -0500
Date: Wed, 10 Jan 2001 08:41:20 +0100 (CET)
From: Pau <linux4u@wanadoo.es>
To: <linux-kernel@vger.kernel.org>
Subject: xircom_tulip + NFS hanging interface
In-Reply-To: <20010109171107.A1470@lightside.2y.net>
Message-ID: <Pine.LNX.4.30.0101100835060.1297-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been getting problems all along the pre-2.4 series and 2.4 itself
when I use NFS to play mp3 files with xmms.

The message in the logs is:
tulip.c: outl_CSR6 too many attempts,csr5=0x60208100

After a few times the network stops working and it only recovers with the
following sequence of commands:

ifdown eth0 && ifup eth0 && ifconfig eth0 -promisc

Without ifconfig eth0 -promisc it still doesn't get any packet.
I have to stop and start the interface too ad -prmisc doesn't work alone.
So this is the only sequence that works.

The modules loaded are:
Module                  Size  Used by
nfs                    75136   1  (autoclean)
lockd                  49680   1  (autoclean) [nfs]
sunrpc                 59392   1  (autoclean) [nfs lockd]
ide-cd                 26608   0  (autoclean)
cdrom                  27104   0  (autoclean) [ide-cd]
rtc                     5520   0  (unused)
ipchains               32544   0  (unused)
apm                     9088   2
parport_pc             18880   1  (autoclean)
lp                      5200   0  (autoclean)
parport                27680   1  (autoclean) [parport_pc lp]
autofs                 10784   1  (autoclean)
xircom_tulip_cb        30832   1  (autoclean)
serial_cb               1360   0  (autoclean) (unused)
serial                 43344   0  (autoclean) [serial_cb]
isa-pnp                29040   0  (autoclean) [serial]
agpgart                16960   0  (unused)
maestro                26880   1
soundcore               3952   2  [maestro]
uhci                   18672   0  (unused)
usbcore                52304   2  [uhci]


Thanks for your help
Pau

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
