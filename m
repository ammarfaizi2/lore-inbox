Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRKHSCr>; Thu, 8 Nov 2001 13:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRKHSBL>; Thu, 8 Nov 2001 13:01:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51217 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277230AbRKHSAE>; Thu, 8 Nov 2001 13:00:04 -0500
Message-ID: <3BEAC6E4.7722DB17@zip.com.au>
Date: Thu, 08 Nov 2001 09:54:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt <madmatt@bits.bris.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: My 3c980 is misdetected
In-Reply-To: <Pine.LNX.4.21.0111080916480.20023-100000@bits.bris.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> 
> More NIC-related queries,
> 
> Under the 2.4.13 kernel, the 3c59x.o driver misdetects my 3c980 as a 3c982
> (the dual port version of what I assume is the same card):
> 
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 00:09.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xdc00. Vers LK1.1.16
> 
> Here is the output of lspci -v:
> 
> 00:09.0 Ethernet controller: 3Com Corporation: Unknown device 9805 (rev 78)
>         Subsystem: 3Com Corporation: Unknown device 1000
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at dc00 [size=128]
>         Memory at db000000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
> 
> It all seems to work fine, but I was wondering if this might cause a
> hiccup anywhere? 2.2.19 identified my card correctly, and I have some
> earlier 3c980 models in another box still running 2.2.19, which get
> detected correctly too:
> 

No, that's OK - it's just the identification string which is
incorrect.  I was "updating" the ID strings from the latest Becker
driver and one of us got it wrong...
