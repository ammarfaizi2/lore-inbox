Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310159AbSCAB0p>; Thu, 28 Feb 2002 20:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSCABYH>; Thu, 28 Feb 2002 20:24:07 -0500
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:48007 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S310291AbSCABU1>; Thu, 28 Feb 2002 20:20:27 -0500
Date: Thu, 28 Feb 2002 17:20:58 -0800 (PST)
From: Daniel Bertrand <d.bertrand@ieee.org>
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
In-Reply-To: <20020228.170317.70477069.davem@redhat.com>
X-X-Sender: d_bertra@kilrogg
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, Rui Sousa <rui.p.m.sousa@clix.pt>,
        german@piraos.com, jcm@netcabo.pt, linux-kernel@vger.kernel.org,
        emu10k1-devel <emu10k1-devel@lists.sourceforge.net>,
        steve@math.upatras.gr, d.bertrand@ieee.org, dledford@redhat.com
Message-id: <Pine.LNX.4.44.0202281710290.3717-100000@kilrogg>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like the bug is from pushing the 64bit dma_handle on a 32bit va_arg 
list. Its fixed in CVS, and at least one person has reported success.


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

