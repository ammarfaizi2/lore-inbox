Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272075AbTGYN5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272076AbTGYN5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:57:45 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:21264
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272075AbTGYN5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:57:37 -0400
Message-ID: <3F213D6C.1060706@rogers.com>
Date: Fri, 25 Jul 2003 10:23:40 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
References: <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <3F213961.3090501@rogers.com> <20030725134755.GC1512@phunnypharm.org>
In-Reply-To: <20030725134755.GC1512@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Fri, 25 Jul 2003 10:12:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying both patches and enabling ieee1394 excessive debugging in 
xconfig:


root@localhost linux # rmmod raw1394
root@localhost linux # rmmod ohci1394
root@localhost linux # rmmod ieee1394
root@localhost linux # make modules modules_install

...

   CC [M]  drivers/ieee1394/ieee1394_core.o
drivers/ieee1394/ieee1394_core.c: In function `handle_packet_response':
drivers/ieee1394/ieee1394_core.c:618: warning: too many arguments for format
   CC [M]  drivers/ieee1394/ieee1394_transactions.o
   CC [M]  drivers/ieee1394/nodemgr.o
   LD [M]  drivers/ieee1394/ieee1394.o
   CC [M]  drivers/ieee1394/ohci1394.o
   CC [M]  drivers/ieee1394/video1394.o
   CC [M]  drivers/ieee1394/raw1394.o

...

root@localhost linux # modprobe ieee1394
root@localhost linux # modprobe ohci1394
root@localhost linux # modprobe raw1394
root@localhost linux # dmesg

...

ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Remapped memory spaces reg 0xd093f800
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394_0: 4 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 060050c5:000001ce
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=1 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[cfffc800-cfffcfff]  Max 
Packet=[2048]
ohci1394_0: request csr_rom address: cce13000
ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: IntEvent: 00010000
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8c56 received
ieee1394: Including SelfID 0x568c7f80
ohci1394_0: SelfID for this node is 0x807f8c56
ohci1394_0: SelfID complete
ohci1394_0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... 
irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ieee1394: Initiating ConfigROM request for node 00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 dee10404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00160 ffc00000 00000000 dee10404
ieee1394: TLABEL: Checking for tlabel 0
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 dee10404
ieee1394: send packet local: ffc00540 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: received packet: ffc00540 ffc0ffff f0000400
ieee1394: send packet local: ffc00560 ffc00000 00000000 dee10404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00560 ffc00000 00000000 dee10404
ieee1394: TLABEL: Checking for tlabel 1
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 dee10404
ieee1394: send packet local: ffc00940 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: received packet: ffc00940 ffc0ffff f0000400
ieee1394: send packet local: ffc00960 ffc00000 00000000 dee10404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00960 ffc00000 00000000 dee10404
ieee1394: TLABEL: Checking for tlabel 2
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 dee10404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394_0: Starting transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 
data=0x1F0000C0 ctx=0
ieee1394: TLABEL: not pending or no response expected, returning
raw1394: /dev/raw1394 device initialized
root@localhost linux #



