Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293663AbSB1Ty7>; Thu, 28 Feb 2002 14:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293692AbSB1TxA>; Thu, 28 Feb 2002 14:53:00 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:58635 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S293710AbSB1TvV>; Thu, 28 Feb 2002 14:51:21 -0500
Date: Thu, 28 Feb 2002 20:50:20 +0100 (CET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: rsousa@sophia-sousar2.nice.mindspeed.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: German Gomez Garcia <german@piraos.com>,
        =?ISO-8859-1?Q?Jos=E9?= Carlos Monteiro <jcm@netcabo.pt>,
        <linux-kernel@vger.kernel.org>,
        emu10k1-devel <emu10k1-devel@lists.sourceforge.net>,
        Steve Stavropoulos <steve@math.upatras.gr>,
        Daniel Bertrand <d.bertrand@ieee.org>, <dledford@redhat.com>
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
In-Reply-To: <E16g6XY-0004v8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202282042150.1215-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Alan Cox wrote:

It's true dma_addr_t does change from u32 to u64 and we do thinks like:

(32 bit pci register) = cpu_to_le32(dma_handle)

What is the correct way of doing this?

(32 bit pci register) = cpu_to_le32((u32)dma_handle)
?

Rui Sousa

> > The most bizzare is that in a machine with 192Mib of memory but with a=20
> > kernel compiled with HIGHMEM support I see the same type of problems.
> 
> Change of size in a structure or type ?
> 
> _______________________________________________
> Emu10k1-devel mailing list
> Emu10k1-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/emu10k1-devel
> 

