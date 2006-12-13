Return-Path: <linux-kernel-owner+w=401wt.eu-S964884AbWLMMDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWLMMDX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWLMMDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:03:23 -0500
Received: from fon.laterooms.com ([194.24.251.1]:49404 "EHLO pat.laterooms.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964867AbWLMMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:03:22 -0500
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:03:21 EST
Date: Wed, 13 Dec 2006 11:41:12 +0000
From: Gavin Hamill <gdh@acentral.co.uk>
To: linux-kernel@vger.kernel.org
Subject: tg3 + BCM5721 : eth1 detected yet 'No such device'
Message-Id: <20061213114112.4458474b.gdh@acentral.co.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I'm only able to use one of the two onboard Gig-eth NICs on this HP DL145 G2 with Debian etch (2.6.18-based) yet both are detected and shown by dmesg. The NIC marked as '2' on the back of the machine becomes eth0, whilst 'eth1' seems to vanish into the ether (if you'll excuse the pun).

tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 16
GSI 18 sharing vector 0xE1 and IRQ 18
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK1] -> GSI 16 (level, high) -> IRQ 225
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:17:08:92:37:6f
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]

ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 19
GSI 19 sharing vector 0xE9 and IRQ 19
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNK4] -> GSI 19 (level, high) -> IRQ 233
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:17:08:92:37:6e
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[76180000] dma_mask[64-bit]

hash:~# mii-tool eth0
eth0: negotiated 100baseTx-FD flow-control, link ok
hash:~# mii-tool eth1
SIOCGMIIPHY on 'eth1' failed: No such device

hash:~# ifconfig eth0 | head -1
eth0      Link encap:Ethernet  HWaddr 00:17:08:92:37:6F  
hash:~# ifconfig eth1 | head -1
eth1: error fetching interface information: Device not found

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)

02:00.0 0200: 14e4:1659 (rev 11)
03:00.0 0200: 14e4:1659 (rev 11)

Same behaviour with tg3 v3.66 directly from 
http://www.broadcom.com/docs/driver_download/570x/linux-3.66d.zip

Same behaviour also with Ubuntu dapper (2.6.15).

SSH access to the machine is available if desired :)

Cheers,
Gavin.
