Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136582AbREEAj7>; Fri, 4 May 2001 20:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREEAjt>; Fri, 4 May 2001 20:39:49 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:53386 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S136582AbREEAjm>; Fri, 4 May 2001 20:39:42 -0400
Date: Fri, 4 May 2001 17:39:35 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: How to debug a 2.4.4 tulip problem?
Message-ID: <Pine.LNX.4.33.0105041659020.21153-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm having a small intermittent problem with the tulip driver in linux
2.4.4, and I'm looking for some guidance on how to debug it.

What happens is that on one of my boxes the card ocasionally gets wedged.
That is, network traffic gets painfully slow, e.g. pinging another host on
the same segment causes each ping to take (almost exactly) 1 second,
rather than the usual 200 usecs or so.  Executing ifup/ifdown unwedges the
card.

Some relevant details about this box:
 eth0: Lite-On 82c168 PNIC rev 32 at 0xb800, 00:C0:F0:2D:3D:8A, IRQ 17.
 MSI-6321 motherboard (VIA Apollo Pro)

Now I have a similar box that I think does not show the problem (not 100%
sure).  It has:
 eth0: Lite-On 82c168 PNIC rev 33 at 0xe800, 00:A0:CC:3F:33:32, IRQ 18.
 Tekram P6B40D-A5 motherboard (Intel 440BX)

As a wild guess, it seems like when the card is wedged, some interrupt is
getting lost, so that the transmit or send doesn't occur until a timer
times out.  Perhaps there is a bug in rev 32 of this card that is not in
rev 33.

What information should I gather when the card is wedged to aid in
debugging?  Is 'lspci -xxx' enough?  Any suggestions would be welcome.

Cheers,
Wayne

