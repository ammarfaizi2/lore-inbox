Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284488AbRLEQze>; Wed, 5 Dec 2001 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284489AbRLEQzY>; Wed, 5 Dec 2001 11:55:24 -0500
Received: from casbah.gatech.edu ([130.207.165.18]:62870 "EHLO
	casbah.gatech.edu") by vger.kernel.org with ESMTP
	id <S284488AbRLEQzH>; Wed, 5 Dec 2001 11:55:07 -0500
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
From: Rob Myers <rob.myers@gtri.gatech.edu>
To: Michael Clark <michael@metaparadigm.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@redhat.com>
In-Reply-To: <3C0E3120.2000504@metaparadigm.com>
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com>
	<1007501048.14051.28.camel@ransom> <3C0D7CEA.2050307@metaparadigm.com>
	<3C0E194B.2BB7E289@mandrakesoft.com>  <3C0E3120.2000504@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 11:56:59 -0500
Message-Id: <1007571419.14051.38.camel@ransom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 09:37, Michael Clark wrote:
> Problem solved. New patch attached.

ns83820-optical-0.13c.patch works, too.  although you forgot to bump the
version letter to c. ;)  the versions in the dmesg output below are
correct.  (i tested the p2b-d with v0.13c and the cur-dls with v0.13b)

i wonder what implications there are that its trying to do 64bit pci on
the p2b-d board?

thanks again michael, jeff, and ben!

rob.

asus p2b-d dmesg output: (32bit pci slot / redhat 7.2 / 2.4.9 stock
kernel)
eth1: enabling 64 bit PCI.
eth1: enabling optical transceiver
eth1: ns83820.c v0.13c: DP83820 00:40:f4:29:ea:d7 pciaddr=0xe1000000
irq=12 rev 0x103
eth1: link now 1000F mbps, full duplex and up.

asus p2b-d dmesg output: (same 32bit pci slot / 2.4.16)
eth1: enabling 64 bit PCI.
eth1: enabling optical transceiver
eth1: ns83820.c v0.13c: DP83820 00:40:f4:29:ea:d7 pciaddr=0xe1000000
irq=12 rev 0x103
eth1: link now 1000F mbps, full duplex and up.

tyan cur-dls dmesg output: (64bit pci slot / 2.4.16)
eth2: enabling 64 bit PCI.
eth2: enabling optical transceiver
eth2: ns83820.c v0.13b: DP83820 00:40:f4:29:ea:d7 pciaddr=0xf8800000
irq=21 rev 0x103
eth2: link now 1000F mbps, full duplex and up.

tyan cur-dls dmesg output: (32bit pci slot / 2.4.16)
eth2: disabling 64 bit PCI.
eth2: enabling optical transceiver
eth2: ns83820.c v0.13b: DP83820 00:40:f4:29:ea:d7 pciaddr=0xfc000000
irq=17 rev 0x103
eth2: link now 1000F mbps, full duplex and up.



