Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279640AbRKATs4>; Thu, 1 Nov 2001 14:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279631AbRKATsr>; Thu, 1 Nov 2001 14:48:47 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:6665 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S279640AbRKATsk>;
	Thu, 1 Nov 2001 14:48:40 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111011948.WAA27345@ms2.inr.ac.ru>
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
To: ak@suse.de (Andi Kleen)
Date: Thu, 1 Nov 2001 22:48:13 +0300 (MSK)
Cc: ak@suse.de, joris@deadlock.et.tudelft.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20011101202845.A10648@wotan.suse.de> from "Andi Kleen" at Nov 1, 1 08:28:45 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Just to have an symmetric API. Everything else is too ugly to explain 
> in manpages ;)

Explaining is easy. Blah-blah-blah... Sockets bound to ETH_P_ALL
are able to get copy of output packets which is useful f.e.
for packet sniffers (ref to [libpacp],[tcpdump]). In later kernels
this can be disabled with option PACKET_NOOUTPUT. When this option
is not supported user of packet socket bound to ETH_P_ALL has to filter
output packets at user level checking for pkt_type == PACKET_OUTPUT
or using an equivalent BPF applet.


> That would require changing/breaking PF_PACKET, no? 

No. Ideally the option could be PACKET_GRAB_OUTPUT and be disabled
by default (for symmetry :-)). But as soon as it was forgotten,
it has to be enabled by default.

Alexey
