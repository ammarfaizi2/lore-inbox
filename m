Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264868AbRF3ITb>; Sat, 30 Jun 2001 04:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264869AbRF3ITW>; Sat, 30 Jun 2001 04:19:22 -0400
Received: from mail.aslab.com ([205.219.89.194]:11352 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S264868AbRF3ITG>;
	Sat, 30 Jun 2001 04:19:06 -0400
Date: Sat, 30 Jun 2001 01:18:47 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Andries.Brouwer@cwi.nl
cc: Gunther.Mayer@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)V3
In-Reply-To: <UTC200106292040.WAA358371.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.04.10106300115030.7941-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I should have known that you (instructor of the current and previous
maintainer) would have the answer off the top ;-)
Therefore by your description it mys be set always but I guess it is a
DGD; however, I do want to know that it is now.

Oh, and now that Big Drive Technology has been annouced I should finally
send you the code for 48-bit, sorry about the delay.

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Fri, 29 Jun 2001 Andries.Brouwer@cwi.nl wrote:

>     Andre Hedrick wrote:
> 
>     > That is a legacy bit from ATA-2 but it is one of those things you cannot
>     > get rid of :-(
> 
>     in ANSI X3.279-1996, "AT Attachment Interface with Extensions (ATA-2)",
>     Approved September 11, 1996 , control register bit 3-7 are reserved.
> 
>     However ANSI X3.221-1994, "AT Attachment Interface for Disk Drives",
>     Approved May 12, 1994, bit3 is "1" and bits 4-7 are "x".
>     No further explanation.
> 
>     How far back must we go, to get the sense ?
> 
>     >   struct {
>     >           unsigned bit0           : 1;
>     >           unsigned nIEN           : 1;    /* device INTRQ to host */
>     >           unsigned SRST           : 1;    /* host soft reset bit */
>     >           unsigned bit3           : 1;    /* ATA-2 thingy */
>     >           unsigned reserved456    : 3;
>     >           unsigned HOB            : 1;    /* 48-bit address ordering */
>     >   } control_t;
>     > 
>     > once I add-in the real def of bit3 then I will not
>     > need to look it up again.
> 
> bit3: 0: drive has 1-8 heads
>       1: drive has more than 8 heads
> 
> (From old MFM/RLL times. In ATA-1 bit3 is set to 1.
> See also
> 	http://www.win.tue.nl/~aeb/linux/hdtypes/hdtypes-2.html
> .)
> 
> Andries
> 

