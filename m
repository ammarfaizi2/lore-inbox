Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282839AbRLBLth>; Sun, 2 Dec 2001 06:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282842AbRLBLtZ>; Sun, 2 Dec 2001 06:49:25 -0500
Received: from cs182193.pp.htv.fi ([213.243.182.193]:3968 "EHLO
	cs182193.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S282839AbRLBLtS>; Sun, 2 Dec 2001 06:49:18 -0500
Message-ID: <3C0A1529.5D22EDDF@welho.com>
Date: Sun, 02 Dec 2001 13:48:57 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16: TCP shutdown generating infinite ACK storm
In-Reply-To: <1007290602.1892.2.camel@ixodes.goop.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> I'm looking at my box and a server at Tom's Hardware pounding each other
> with packets.  It looks like Linux has got confused about sequence
> numbers (or maybe the other end is confused?).

Yes, it does look like a sequence synchronization problem.

> Naturally, this looks bad.  After a while it seemed to stop of its own
> accord, I presume when something timed out of LAST_ACK.  While it was
> happening, there were two sockets ixising to ad.tomshardware.com:
> 
> tcp        1      1 ixodes.goop.org:33674   ad.tomshardware.co:http LAST_ACK
> tcp        1      1 ixodes.goop.org:33708   ad.tomshardware.co:http LAST_ACK
> 
> I'm using 2.4.16 with no particularly special patches.  The gateway
> machine is another 2.4.16 box doing NAT with ipchains emulation.
> 
> Any other info needed?

If you can repeat this, you please run tcpdump with the -vv option in
order to get it to display the sequence numbers on ack packets as well.
It would also be good to see the last few packets of the connection (at
least the FIN packets).

BR,

	MikaL
