Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279412AbRKARdy>; Thu, 1 Nov 2001 12:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279420AbRKARdp>; Thu, 1 Nov 2001 12:33:45 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:16392 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S279412AbRKARdc>;
	Thu, 1 Nov 2001 12:33:32 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111011733.UAA26651@ms2.inr.ac.ru>
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
To: ak@suse.de (Andi Kleen)
Date: Thu, 1 Nov 2001 20:33:15 +0300 (MSK)
Cc: joris@deadlock.et.tudelft.nl, linux-kernel@vger.kernel.org
In-Reply-To: <p733d3yr2b1.fsf@amdsim2.suse.de> from "Andi Kleen" at Nov 1, 1 03:30:42 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > So... Shouldn't dev_queue_xmit_nit() also process ptype_base then ?
> 
> Interesting bug.

RTFM of the maillists, Andi.


Someone promised me to fix this in right way, but disappeared.

Generally packet sockets MUST NOT tap on output packets. No differences
of socket of another protocols. UDP does not tap output right?
What the hell packet socket should do this?
Snapping on output is feature which must be regulated by a separate option.
And to be honest I see no tragedy, if this option will not exist for sockets
bound to specific protocols.

Alexey
