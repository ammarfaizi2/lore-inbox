Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRHJI0B>; Fri, 10 Aug 2001 04:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRHJIZw>; Fri, 10 Aug 2001 04:25:52 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:9223 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S266040AbRHJIZk>;
	Fri, 10 Aug 2001 04:25:40 -0400
Message-ID: <3B737FE4.3D0998D3@yahoo.com>
Date: Fri, 10 Aug 2001 02:32:04 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.19 i586)
MIME-Version: 1.0
To: Riley Williams <rhw@MemAlpha.CX>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108042028320.16941-100000@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:

> One of my systems has SIX ethernet cards, these being three ISA and
> two PCI NE2000 clones and a DEC Tulip. Here's the relevant section of
> modules.conf on the system in question:
> 
>  Q> alias eth0 ne
>  Q> options eth0 io=0x340
>  Q> alias eth1 ne
>  Q> options eth1 io=0x320
>  Q> alias eth2 ne
>  Q> options eth2 io=0x2c0
>  Q> alias eth3 ne2k-pci
>  Q> alias eth4 ne2k-pci
>  Q> alias eth5 tulip

You have six drivers loaded, when you only need three (i.e.
io=0x340,0x320,0x2c0 for ne options etc. etc).  So you end
up wasting some memory, and a worse icache behaviour as well.
(the latter is probably a non-issue if you are happy with ISA)

Paul.


