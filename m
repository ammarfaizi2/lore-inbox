Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSKYO2d>; Mon, 25 Nov 2002 09:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKYO2d>; Mon, 25 Nov 2002 09:28:33 -0500
Received: from ns.ithnet.com ([217.64.64.10]:518 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263544AbSKYO2c>;
	Mon, 25 Nov 2002 09:28:32 -0500
Date: Mon, 25 Nov 2002 15:35:46 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Richard Mueller <mueller@teamix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] D-Link DFE-580TX: Only 3 Ports working
Message-Id: <20021125153546.0d35a18a.skraw@ithnet.com>
In-Reply-To: <140282249663.20021125161149@teamix.net>
References: <140282249663.20021125161149@teamix.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002 16:11:49 +0100
Richard Mueller <mueller@teamix.net> wrote:

> Hello kernel-developers (esp. Donald ;) )
> 
> I am experiencing very strange problems with the
> "D-Link DFE-580TX 4 port Server Adapter" in our enviroment.
> 
> The kernel can only use the first three Ports. The forth Port
> is detected but reports some problems with the MII-Transciever.
> 
> It should not be a NIC-hardwareproblem (used a second one - same
> problems).
> 
> But read with your own eyes:
> 
> host:~# cat /proc/version
> Linux version 2.4.20-rc2 (root@host) (gcc version 2.95.4 20011002 (Debian
> prerelease)) #3 SMP Mon Nov 25 14:20:56 CET 2002
> 
> host:~# dmesg |grep eth
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:20:ED:18:22:55, IRQ 30.
> eth1: OEM i82557/i82558 10/100 Ethernet, 00:20:ED:18:22:54, IRQ 29.
> eth2: D-Link DFE-580TX 4 port Server Adapter at 0xb800, 00:05:5d:64:9f:9d,
> IRQ 21. eth2: MII PHY found at address 1, status 0x782d advertising 01e1.
> eth3: D-Link DFE-580TX 4 port Server Adapter at 0xb400, 00:05:5d:64:9f:9c,
> IRQ 20. eth3: MII PHY found at address 1, status 0x782d advertising 01e1.
> eth4: D-Link DFE-580TX 4 port Server Adapter at 0xb000, 00:05:5d:64:9f:9b,
> IRQ 21. eth4: MII PHY found at address 1, status 0x782d advertising 01e1.
> eth5: D-Link DFE-580TX 4 port Server Adapter at 0xbe00, 00:00:00:00:00:00,
> IRQ 20. eth5: No MII transceiver found, aborting.  ASIC status ffffffff

I have the same card, but used only 3 ports up to now, just tried the 4th - it
worked.

<6>eth0: D-Link DFE-580TX 4 port Server Adapter at 0xb800, 00:05:5d:5e:93:5c,
IRQ 9.
<6>eth0: MII PHY found at address 1, status 0x782d advertising 01e1.
<6>eth1: D-Link DFE-580TX 4 port Server Adapter at 0xb400, 00:05:5d:5e:93:5d,
IRQ 11.
<6>eth1: MII PHY found at address 1, status 0x782d advertising 01e1.
<6>eth2: D-Link DFE-580TX 4 port Server Adapter at 0xb000, 00:05:5d:5e:93:5e,
IRQ 10.
<6>eth2: MII PHY found at address 1, status 0x782d advertising 01e1.
<6>eth3: D-Link DFE-580TX 4 port Server Adapter at 0xa800, 00:05:5d:5e:93:5f,
IRQ 5.
<6>eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.

Is it possible that you ran out of pci config space, i/o space? I don't quite
understand why your 4th port moved to 0xbe00 (after 3rd is 0xb000) ...
Can you play with the pci slots a bit (exchanging the cards)?

-- 
Regards,
Stephan

