Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRKAS5C>; Thu, 1 Nov 2001 13:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279561AbRKAS4x>; Thu, 1 Nov 2001 13:56:53 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:52744 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S279556AbRKAS4r>;
	Thu, 1 Nov 2001 13:56:47 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111011856.VAA27068@ms2.inr.ac.ru>
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
To: ak@suse.de (Andi Kleen)
Date: Thu, 1 Nov 2001 21:56:34 +0300 (MSK)
Cc: ak@suse.de, joris@deadlock.et.tudelft.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20011101192153.A30903@wotan.suse.de> from "Andi Kleen" at Nov 1, 1 07:21:53 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> When you e.g. have a TCP sniffer it makes sense to only bind it to ETH_P_IP.

For what purpose? To add a small underdeveloped copy of BPF?

If it was an optimization I would understand this of course.
But you propose deoptimization. :-)


> Do you worry about the handling of hundreds of packet sockets? 

I worry about _one_ packet socket, which implements a protocol
in user space. And only about this. It is what packet sockets
are used for.

And I do want to see any refs to it in irrelevant place, which output path is.

To summarize: I wanted to see a patch allowing to detect that
nobody listens on outpu (or even splitting input and output ptype_all.)
So that it becomes possible to use ETH_P_ALL to listen
for all frames, but not to abuse output path.

Opposite is just non-sense with no applications.

Alexey
