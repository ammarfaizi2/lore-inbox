Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbRFADuo>; Thu, 31 May 2001 23:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263346AbRFADuf>; Thu, 31 May 2001 23:50:35 -0400
Received: from f30.law3.hotmail.com ([209.185.241.30]:50950 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263344AbRFADuY>;
	Thu, 31 May 2001 23:50:24 -0400
X-Originating-IP: [65.25.173.87]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: jalvo@mbay.net
Subject: Re: Abysmal RECV network performance
Date: Fri, 01 Jun 2001 03:50:18 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F30K3zrwz4kgNr4zCcT0000a5e3@hotmail.com>
X-OriginalArrivalTime: 01 Jun 2001 03:50:18.0321 (UTC) FILETIME=[F95A7410:01C0EA4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've seen many reports like this where the NIC is invalidly in
>full-duplex more while the router is in half-duplex mode.

[root@copper diag]# ./tulip-diag eth1 -m
tulip-diag.c:v2.08 5/15/2001 Donald Becker (becker@scyld.com)
http://www.scyld.com/diag/index.html
Index #1: Found a Lite-On 82c168 PNIC adapter at 0xfe00.
Port selection is MII, full-duplex.
Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 512.
MII PHY found at address 1, status 0x782d.
MII PHY #1 transceiver registers:
   1000 782d 7810 0000 01e1 41e1 0001 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0000 0000 4000 0000 38c8 0010 0000 0002
   0001 0000 0000 0000 0000 0000 0000 0000.
[root@copper diag]# ./mii-diag eth1
Basic registers of MII PHY #1:  1000 782d 7810 0000 01e1 41e1 0001 0000.
The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
Basic mode control register 0x1000: Auto-negotiation enabled.
You have link beat, and everything is working OK.
Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD 
10baseT.
   End of basic transceiver informaion.

On the NetGear switch, I have indicator lights for 100baseT-FD on both 
connections used for testing. So it appears to me that everything is working 
correctly (hardware).

I keep coming back to a problem with the kernel, or that somehow I have two 
cards (FA310 and 3CSOHO) defective in almost exactly the same way, but only 
on receive. If it were a hardware problem, why would I only get poor 
performance in one direction and not both?

Does anyone have network performance numbers for a comparable machine (P-90 
class)? I'm thinking I should expect 50-70Mbps on a PCI 10/100 ethernet card 
from a P-90 class machine, right?

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

