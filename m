Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbRFAEoy>; Fri, 1 Jun 2001 00:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263372AbRFAEoo>; Fri, 1 Jun 2001 00:44:44 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:2575 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263366AbRFAEod>;
	Fri, 1 Jun 2001 00:44:33 -0400
Message-ID: <3B17207E.BDC70E6A@candelatech.com>
Date: Thu, 31 May 2001 21:56:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John William <jw2357@hotmail.com>
CC: linux-kernel@vger.kernel.org, jalvo@mbay.net
Subject: Re: Abysmal RECV network performance
In-Reply-To: <F30K3zrwz4kgNr4zCcT0000a5e3@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John William wrote:
> 
> >I've seen many reports like this where the NIC is invalidly in
> >full-duplex more while the router is in half-duplex mode.
> 
> [root@copper diag]# ./tulip-diag eth1 -m
> tulip-diag.c:v2.08 5/15/2001 Donald Becker (becker@scyld.com)
> http://www.scyld.com/diag/index.html
> Index #1: Found a Lite-On 82c168 PNIC adapter at 0xfe00.
> Port selection is MII, full-duplex.
> Transmit started, Receive started, full-duplex.
>   The Rx process state is 'Waiting for packets'.
>   The Tx process state is 'Idle'.
>   The transmit threshold is 512.
> MII PHY found at address 1, status 0x782d.
> MII PHY #1 transceiver registers:
>    1000 782d 7810 0000 01e1 41e1 0001 0000
>    0000 0000 0000 0000 0000 0000 0000 0000
>    0000 0000 4000 0000 38c8 0010 0000 0002
>    0001 0000 0000 0000 0000 0000 0000 0000.
> [root@copper diag]# ./mii-diag eth1
> Basic registers of MII PHY #1:  1000 782d 7810 0000 01e1 41e1 0001 0000.
> The autonegotiated capability is 01e0.
> The autonegotiated media type is 100baseTx-FD.
> Basic mode control register 0x1000: Auto-negotiation enabled.
> You have link beat, and everything is working OK.
> Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD
> 10baseT.
>    End of basic transceiver informaion.
> 
> On the NetGear switch, I have indicator lights for 100baseT-FD on both
> connections used for testing. So it appears to me that everything is working
> correctly (hardware).
> 
> I keep coming back to a problem with the kernel, or that somehow I have two
> cards (FA310 and 3CSOHO) defective in almost exactly the same way, but only
> on receive. If it were a hardware problem, why would I only get poor
> performance in one direction and not both?
> 
> Does anyone have network performance numbers for a comparable machine (P-90
> class)? I'm thinking I should expect 50-70Mbps on a PCI 10/100 ethernet card
> from a P-90 class machine, right?

Depends on what is driving it...  An application I built can only push about
80 Mbps bi-directional on PII 550Mhz machines.  It is not the most efficient program in
the world, but it isn't too bad either...

I missed the rest of this thread, so maybe you already mentioned it, but
what is the bottleneck?  Is your CPU running at 100%?

Greatly increasing the buffers both in the drivers and in the sockets
does wonders for higher-speed connections, btw.

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
