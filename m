Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRKBCcU>; Thu, 1 Nov 2001 21:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279946AbRKBCcL>; Thu, 1 Nov 2001 21:32:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:24570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S279945AbRKBCby>;
	Thu, 1 Nov 2001 21:31:54 -0500
Message-ID: <3BE20453.22427ECB@gmx.de>
Date: Fri, 02 Nov 2001 03:26:27 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Joris van Rantwijk <joris@deadlock.et.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
In-Reply-To: <Pine.LNX.4.21.0111010944050.16656-100000@deadlock.et.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joris van Rantwijk wrote:
> 
> I'm trying to see outgoing network packets through the AF_PACKET
> interface. This works as long as I bind the packet socket with
> sll_protocol==htons(ETH_P_ALL).  I would expect that I can filter
> on IP packets by binding to sll_protocol==htons(ETH_P_IP), but when
> I try it I suddenly see only the incoming packets and no outgoing at all.

Deja vu? :-)  See this message:

---------------------
> Subject: Re: PF_PACKET, ETH_P_IP does not catch outgoing packets.
> From: kuznet@ms2.inr.ac.ru
> Date: Thu, 23 Dec 1999 20:41:11 +0300 (MSK)
>
> Hello!
>
> > do not receive outgoing packets.  Just changing the
> > protocol to ETH_P_ALL (or a later bind with that proto)
> > will get all packets.  Is this intentional?  (I don't think
> > so *g*) 
>
> Yes, sort of. It is planned flaw in design. 8) 
>
>
> > Any idea for a quick fix?
>
> No, it is not very easy. If it were easy, it would be made. 8)
> 
> The problem is that bound to protocol sockets are not
> checked at output at all, only ETH_P_ALL ones are checked.
> We could check all, but it affects performance, because
> true protocols (looking exactly as packet socket) really
> need not it. The direction of compromise is not evident.
>
> Someone promised to think on this and repair at the end of 2.1,
> I even reserved sockopt PACKET_RECV_OUTPUT to switch it on/off,
> but, alas, I did not receive any patches.
>
> Alexey
-----------------------

Two years nobody cared.  Seems the BPF is good enough...

Ciao, ET.
