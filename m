Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSL3AnB>; Sun, 29 Dec 2002 19:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSL3AnB>; Sun, 29 Dec 2002 19:43:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20608
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264940AbSL3AnB>; Sun, 29 Dec 2002 19:43:01 -0500
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: khromy <khromy@lnuxlab.ath.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E0F5E2C.70F7D112@digeo.com>
References: <20021229202610.GA24554@lnuxlab.ath.cx> 
	<3E0F5E2C.70F7D112@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 01:32:26 +0000
Message-Id: <1041211946.1474.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 20:42, Andrew Morton wrote:
> gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
> afoul of the reduced memory reserves.  It deserved to.

ISA sound I/O. And yes it really does want the 128K if it can get it on
a slower box. It will try 128/64/32/.. so it gets less if there isnt any
DMA RAM around. All the sound works this way because few bits of sound
hardware, even in the PCI world, support scatter gather.

If the VM can't deal with it - we need to fix the VM. All these
allocations are blocking and can wait a long time.

Please direct any complaints to the hardware vendors. 

Alan

