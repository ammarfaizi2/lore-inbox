Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSHUAPE>; Tue, 20 Aug 2002 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHUAPE>; Tue, 20 Aug 2002 20:15:04 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7430 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317506AbSHUAPD>; Tue, 20 Aug 2002 20:15:03 -0400
Date: Tue, 20 Aug 2002 17:18:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: GroundHog Day ?? {Re: 2.5.31 boot failure on pdc20267}
In-Reply-To: <22A03733B17@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208201716220.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr,

First an apology for the earlier pounce, please accept.
Second, we did this already and I think vger barfed.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On 20 Aug 2002, Petr Vandrovec wrote:

> On 16 Aug 02 at 2:27, Andre Hedrick wrote:
> > On Fri, 16 Aug 2002, Petr Vandrovec wrote:
> > 
> > > Yes. If you'll look at d1510r0c.pdf from ATA guys, you'll find that
> > 
> > BUZZIT!
> > 
> > That is an totally new transport protocol and if you research the pci
> > device class you would know that it has nothing to do with the problem.
> > If you guys are playing with ADMA on DMA Hosts, oh my!
> 
> No. It just reveals that you have no idea what you are talking about.
> It was proven when you talked about EDD, and now it is proven again.
> Table 3 of rev 0f, page 11:
> 
> 
> Byte offset         Description              Attribute     Value
> 09h            Programming Interface Code  | See Table 4 | Defined in table 1
> 0Ah            Subclass code                 Read-only     01h - IDE
> 0Bh            Base class code               Read-only     01h - Mass Storage
> 
> and to your surprise, my IDE interface is:
> 00:1f.1 Class 0101: 8086:244b (rev 05) (prog-if 80 [Master])
> so if this device should not have Class 0101, then there is certainly
> some problem somewhere.
>  
> > The context of what is the EOT between the two HOST protocols has no
> > meaning.
> 
> Yes? Then please tell me what chapter 6, PCI Compatibility and Native
> Bus Master Adapters, pages 22-28 of rev 0c, talks about...
> 
> In rev 0f it is chapter 5, same name, PDF pages 19-26, document pages 10-17.
> EOT is back here in this revision, so actually current standard is OK,
> and Intel is misbehaving (or maybe just "extending" standard?).
> 
> And if you insist that this chapter does not describe UDMA busmastering
> programming interface, then please point me to the correct document.
> There is no other document with simillar name on the T13 web.
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

