Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269380AbRHCJ1U>; Fri, 3 Aug 2001 05:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHCJ1L>; Fri, 3 Aug 2001 05:27:11 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:5647 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S269380AbRHCJ0y>; Fri, 3 Aug 2001 05:26:54 -0400
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 3 Aug 2001 10:23:18 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: TCP zero-copy
CC: linux-kernel@vger.kernel.org
Message-ID: <3B6A7B96.1591.241743@localhost>
In-Reply-To: <15210.4821.318434.454971@pizda.ninka.net>
In-Reply-To: <663CE32D.1D4A9213.0F45C3B8@netscape.net>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this behaviour is only possible for cards which have the 
ability to dma what appears as a list of skb data fragments and 
also has the ability to checksum the data. Namely the Alteon, now 
3com, ACENIC and the sun hme device. 

Does this kernel modification completely remove the need for a 
copy/checksum of the data between user and kernel space on both
transmit and receive ?

I have written a driver for an Intel ixf1002 chip, which has some 
surrounding HW, and is capable of checksumming and processing 
dma in fragments. Is there any information on what changes I 
would have to make to the driver to support zerocopy/checksum ?  

Many Thanks

Simon.


> 
> hochakhung@netscape.net writes:
>  > Is there currently a stable implementation for zero copy on TCP
>  > stack for linux2.4? Would anyone please point me to the patch if
>  > there is any?  Thanks a lot
> 
> It is in the standard 2.4.x kernels these days, no patch is necessary.
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
