Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSL3Axv>; Sun, 29 Dec 2002 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSL3Axu>; Sun, 29 Dec 2002 19:53:50 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:21807 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S264931AbSL3Axt>;
	Sun, 29 Dec 2002 19:53:49 -0500
Date: Sun, 29 Dec 2002 20:20:45 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
Message-ID: <20021230012045.GA25428@lnuxlab.ath.cx>
References: <20021229202610.GA24554@lnuxlab.ath.cx> <3E0F5E2C.70F7D112@digeo.com> <1041211946.1474.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041211946.1474.31.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 01:32:26AM +0000, Alan Cox wrote:
> On Sun, 2002-12-29 at 20:42, Andrew Morton wrote:
> > gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
> > afoul of the reduced memory reserves.  It deserved to.
> 
> ISA sound I/O. And yes it really does want the 128K if it can get it on
> a slower box. It will try 128/64/32/.. so it gets less if there isnt any
> DMA RAM around. All the sound works this way because few bits of sound
> hardware, even in the PCI world, support scatter gather.

This is a PCI sound card.

  Bus  0, device  11, function  0:
      Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
