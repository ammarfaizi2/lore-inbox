Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310331AbSCBHFP>; Sat, 2 Mar 2002 02:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310332AbSCBHEz>; Sat, 2 Mar 2002 02:04:55 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:21819 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S310331AbSCBHEq>; Sat, 2 Mar 2002 02:04:46 -0500
Date: Fri, 01 Mar 2002 22:38:51 -0800 (PST)
From: Daniel Bertrand <d.bertrand@ieee.org>
Subject: 64bit dma_addr_t (was: Emu10k1 SPDIF ...)
In-Reply-To: <20020228.170317.70477069.davem@redhat.com>
X-X-Sender: d_bertra@kilrogg
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0203012156540.5276-100000@kilrogg>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry to beat a dead horse, but wouldn't it be better if sizes didn't
change within the same CPU arch? I don't see how binary-only modules can
ever work reliably if the size of types change depending on people's
.config file. (not that I use any binary-only modules :-).

Is this a common thing done in the kernel? For dma_addr_t, why not just
have it always be 64bit?


On Thu, 28 Feb 2002, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Fri, 1 Mar 2002 01:07:27 +0000 (GMT)
>    
>    The cast befor ethe cpu_to_ is safe if its 32bit I/O only. Maybe we should
>    have cpu_to_le_dma_addr_t 8)
> 
> Actually, the cast to 32-bit is safe if you've set your DMA mask
> properly :-)
> 

-- 
Daniel Bertrand


