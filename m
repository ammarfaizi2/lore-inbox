Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSHAXu6>; Thu, 1 Aug 2002 19:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSHAXu6>; Thu, 1 Aug 2002 19:50:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60166 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317392AbSHAXu5>; Thu, 1 Aug 2002 19:50:57 -0400
Date: Thu, 1 Aug 2002 16:54:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Alexander Viro <viro@math.psu.edu>, Martin Dalecki <dalecki@cs.net.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE from current bk tree, UDMA and two channels...
In-Reply-To: <CF125D0F09@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0208011651200.1315-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, Petr Vandrovec wrote:
> 
> Just to correct you: it is normal magnetic disk with 512 byte sectors,
> from notebook. It works with 512B UDMA requests if we talk to the drive
> slowly, with pauses here and there. If we talk to it back-to-back, it
> dies.

Ugh.

You apparently use udma2 - can you try forcing it to udma0/1 or the other
DMA modes? It may just be that the drive simply cannot take udma2
reliably.

		Linus

