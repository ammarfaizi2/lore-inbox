Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSHPK2v>; Fri, 16 Aug 2002 06:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSHPK2v>; Fri, 16 Aug 2002 06:28:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27152
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318287AbSHPK2u>; Fri, 16 Aug 2002 06:28:50 -0400
Date: Fri, 16 Aug 2002 03:23:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Part 2: Re: 2.5.31 boot failure on pdc20267
In-Reply-To: <22A03733B17@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208160317280.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr,

Try reading the entire document first before commenting and showing why
people should not believe you.

The author went through great lengths to explain and capture what
SFF-8038i defined.  The object is to show the difference.

Now carefully look and see that BAR4 in d1510 is not the same as 
BAR 4 for SFF-8038i.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 16 Aug 2002, Petr Vandrovec wrote:

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

