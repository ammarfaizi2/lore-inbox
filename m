Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbSKOXW0>; Fri, 15 Nov 2002 18:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSKOXWZ>; Fri, 15 Nov 2002 18:22:25 -0500
Received: from fantomas.webnet.pl ([195.205.113.35]:24193 "EHLO
	fantomas.webnet.pl") by vger.kernel.org with ESMTP
	id <S266930AbSKOXWV>; Fri, 15 Nov 2002 18:22:21 -0500
Message-ID: <3DD58343.6030306@wfmh.org.pl>
Date: Sat, 16 Nov 2002 00:29:07 +0100
From: Miloslaw Smyk <thorgal@wfmh.org.pl>
Organization: W.F.M.H.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021109
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Ian Chilton <ian@ichilton.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Anyone use HPT366 + UDMA in Linux?
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <1037371184.19971.0.camel@irongate.swansea.linux.org.uk> <3DD571F1.3010502@wfmh.org.pl> <20021115225137.GB6625@buzz.ichilton.co.uk>
In-Reply-To: <20021115225137.GB6625@buzz.ichilton.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ian Chilton wrote:

> I booed 2.4.19 with HPT366 compiled in and i have not got it to fall
> over yet :)
> 
> HPT366: onboard version of chipset, pin1=1 pin2=2
> HPT366: IDE controller on PCI bus 00 dev 98
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
> HPT366: IDE controller on PCI bus 00 dev 99
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
>     ide1: BM-DMA at 0xc000-0xc007, BIOS settings: hdc:pio, hdd:pio
> hda: IBM-DTLA-307045, ATA DISK drive
> ide0 at 0xac00-0xac07,0xb002 on irq 15
> hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
> UDMA(44)

Your IBM-DTLA-307045 is on ATA100 and ATA66 bad_drives lists and is properly 
downgraded to UDMA3. Mine however (IC35L040AVER07-0), despite also being 
present on those lists, is recognized as UDMA5 by hpt366.c newer than 0.18. 
That may be the culprit.

Cheers,
Milek
-- 
mailto:thorgal@wfmh.org.pl    |  "Man in the Moon and other weird things" -
http://wfmh.org.pl/~thorgal/  |  see it at http://wfmh.org.pl/~thorgal/Moon/
        PLEASE UPDATE YOUR ADDRESSBOOK WITH MY NEW EMAIL ADDRESS.


