Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSH0Gwy>; Tue, 27 Aug 2002 02:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSH0Gwy>; Tue, 27 Aug 2002 02:52:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30220
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315167AbSH0Gwx>; Tue, 27 Aug 2002 02:52:53 -0400
Date: Mon, 26 Aug 2002 23:55:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: readsw/writesw readsl/writesl
In-Reply-To: <20020826.234323.39328052.davem@redhat.com>
Message-ID: <Pine.LNX.4.10.10208262355010.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, it was Ben H.

Cheers,

On Mon, 26 Aug 2002, David S. Miller wrote:

>    From: Andre Hedrick <andre@linux-ide.org>
>    Date: Mon, 26 Aug 2002 23:23:22 -0700 (PDT)
>    
>    Would you consider these for each arch as there are coresponding one for
>    IOMIO, and life would be better if we had a standard set for MMIO.
>    
>    Please consider the request.
> 
> I responded to the private email I got on this subject.
> I forget who asked me this, but they said they were working
> on this IDE stuff.
> 
> My response was that io_barrier() shall be defined on all
> platforms in asm/io.h and that you can then define your
> ide_read{l,w,b} as:
> 
> 	__raw_raw{l,w,b}(...);
> 	io_barrier();
> 
> So instead of having a million read* variations, we have one that is
> standard usage (little endian + I/O barrier) and then a raw variant
> where the cpu does nothing special and you have to byte-twiddle and
> barrier explicitly.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

