Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSHPJqa>; Fri, 16 Aug 2002 05:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318272AbSHPJqa>; Fri, 16 Aug 2002 05:46:30 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:8456 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318270AbSHPJq2>;
	Fri, 16 Aug 2002 05:46:28 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Fri, 16 Aug 2002 11:48:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.31 boot failure on pdc20267
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <22A03733B17@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 02 at 2:27, Andre Hedrick wrote:
> On Fri, 16 Aug 2002, Petr Vandrovec wrote:
> 
> > Yes. If you'll look at d1510r0c.pdf from ATA guys, you'll find that
> 
> BUZZIT!
> 
> That is an totally new transport protocol and if you research the pci
> device class you would know that it has nothing to do with the problem.
> If you guys are playing with ADMA on DMA Hosts, oh my!

No. It just reveals that you have no idea what you are talking about.
It was proven when you talked about EDD, and now it is proven again.
Table 3 of rev 0f, page 11:


Byte offset         Description              Attribute     Value
09h            Programming Interface Code  | See Table 4 | Defined in table 1
0Ah            Subclass code                 Read-only     01h - IDE
0Bh            Base class code               Read-only     01h - Mass Storage

and to your surprise, my IDE interface is:
00:1f.1 Class 0101: 8086:244b (rev 05) (prog-if 80 [Master])
so if this device should not have Class 0101, then there is certainly
some problem somewhere.
 
> The context of what is the EOT between the two HOST protocols has no
> meaning.

Yes? Then please tell me what chapter 6, PCI Compatibility and Native
Bus Master Adapters, pages 22-28 of rev 0c, talks about...

In rev 0f it is chapter 5, same name, PDF pages 19-26, document pages 10-17.
EOT is back here in this revision, so actually current standard is OK,
and Intel is misbehaving (or maybe just "extending" standard?).

And if you insist that this chapter does not describe UDMA busmastering
programming interface, then please point me to the correct document.
There is no other document with simillar name on the T13 web.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
