Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTABVye>; Thu, 2 Jan 2003 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTABVx0>; Thu, 2 Jan 2003 16:53:26 -0500
Received: from smtp-101.nerim.net ([62.4.16.101]:27147 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S267309AbTABVwb>;
	Thu, 2 Jan 2003 16:52:31 -0500
Message-ID: <3E14B698.8030107@inet6.fr>
Date: Thu, 02 Jan 2003 23:00:56 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Cc: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1041536269.24901.47.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happy new year everybody


Alan Cox wrote:

>It got CRC errors, not suprisingly and will drop back. Nevertheless it
>shouldnt have gotten this wrong, so more info would be good.
>  
>

I'm wondering some things about IDE 40/80 pin cables since some time ago :
- somehow the circuitry can make the difference between 40 and 80 pin 
(probably some pins are shorted or not by the cables or some 
cable-type-dependent impedance between wires is mesured) and set a bit 
for us to use.
- most probably the same circuitry can't verify the length of the cables 
or their overall quality but I'm unsure.

#1 How is the 40/80 pin detection done at the hardware level ?
#2 Are there any other cable-quality hardware tests done by the chipsets 
? How ?

I've encountered a barebone design (Mocha P4, uses 2.5" drives) where 
the IDE cable was 40-pin but :
- has a single drive connector instead of the common two,
- its length is only around 10 or 15 cm.
A buyer contacted me for SiS IDE driver directions on this platform and 
confirmed this at least for his purchase.

#3 Is the above cable electrically able to sustain 66+ UDMA transfers 
(could I hack a driver in order to bypass the 80pin cable detection and 
make it work properly) ?
#4 Are the electrical specs for 66+ UDMA transfers public (couldn't find 
by googling) ? Where can we find them ?
Here I mean some really basic specs (max Resistance/Capacity/Inductance 
between wires, max signal propagation delays and so on) and not general 
high level specs (material, connector design, length ranges allowed in 
the general 80-pin, 2 drives case).

Any hints on these Andre ?

LB.

