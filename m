Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRJAOy2>; Mon, 1 Oct 2001 10:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275121AbRJAOyT>; Mon, 1 Oct 2001 10:54:19 -0400
Received: from f157.pav2.hotmail.com ([64.4.37.157]:49675 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275117AbRJAOyK>;
	Mon, 1 Oct 2001 10:54:10 -0400
X-Originating-IP: [204.178.20.13]
From: "murthy kn" <knmurthy30@hotmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Network Interface bonding and ARP
Date: Mon, 01 Oct 2001 20:24:33 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F157SL3Vt3mD0stdR8W0000779b@hotmail.com>
X-OriginalArrivalTime: 01 Oct 2001 14:54:33.0302 (UTC) FILETIME=[FB2B6F60:01C14A88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I have the following question on the interaction between 
bonding/etherchannel (bonding.c)
and the ARP cache.

1. Assume Machine B has N bonded Ethernet cards ( all of the them have the 
same IP address ).
Example Scenario : Etherchannel/trunking/bonding.

In this case, supposing a machine A does an ARP request for B, will it get 
all
the MAC addresses of the N cards.

Does the ARP cache store all the mappings.

2. If not, from what I understand, while doing certain types of scheduling 
(like Round Robin
implemented in bonding.c), we will need to send  packets to the same 
destination
in a round robin manner - first packet on first card, second on second and 
so on.

If the ARP cache stores only one MAC to IP mapping, we cannot send the 
packet
over the second card as the second card on the destination (machine B) will 
not receive
packets destined to first card (on machine B) because it is typically not in 
a
promiscuous mode.

How is this handled?

Kindly CC the replies to my account.

			Thanks,
			Murthy.


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

