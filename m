Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135987AbREIJzi>; Wed, 9 May 2001 05:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135986AbREIJz3>; Wed, 9 May 2001 05:55:29 -0400
Received: from mail.scs.ch ([212.254.229.5]:8721 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S135987AbREIJzL>;
	Wed, 9 May 2001 05:55:11 -0400
Message-ID: <3AF91451.1B989742@scs.ch>
Date: Wed, 09 May 2001 11:56:33 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alexander.eichhorn@rz.tu-ilmenau.de
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <Pine.LNX.3.95.1010507145625.6441A-100000@chaos.analogic.com> <3AF82D3E.C916B055@rz.tu-ilmenau.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> considered to be in the "window of scarcity" (today we have 100MBit
> Ethernets and 133++MB/s PCI). Tomorrow our operating system concepts
> have to cope with 1, 10, ?? Gigabit Ethernets, Infiniband ,
> ... who knows.

We had to write our own RPC mechanism because with the standard-stacks
we had no chance of achieving our goals. We would have loved to use
tcp/ip but it was not possible with Linux 2.2. 
Today we achieve almost 200MB/s over our RPC stack and this with the
CPU's almost idle. With TCP/IP and Gig-E we only came up to 60-70MB/s
and then the system was completely busy and unresponsive (Linux 2.4 is
supposed to be better but I doubt that we get a CPU load this low
without zerocopy networking).

We would like to look at the zerocopy ideas of Linux 2.4 and try to
implement our RPC mechanism over zerocopy-TCP (if something like this
exists). We just started with this idea and don't know exactly where to
start yet (we are looking for something like a de-facto zerocopy
standard for sockets)... Any ideas are welcome.

	Reto
