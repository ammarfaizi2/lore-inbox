Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSADTxC>; Fri, 4 Jan 2002 14:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288740AbSADTwV>; Fri, 4 Jan 2002 14:52:21 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:28149 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288735AbSADTvw>; Fri, 4 Jan 2002 14:51:52 -0500
Date: Fri, 4 Jan 2002 20:50:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104140538.A19746@thyrsus.com>
Message-ID: <Pine.GSO.3.96.1020104203829.829I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> My logic would then be: if the box has PCI, and DMI shows no ISA slots,
> and the motherboard is not on the exception list, then suppress ISA 
> questions.

 What about CONFIG_BLK_DEV_FD, CONFIG_SERIAL and CONFIG_PARPORT_PC?  ISA
devices of this kind are still often present in systems even if no ISA
slots exist.  Actually CONFIG_BLK_DEV_FD is purely ISA and it uses ISA DMA
(so it requires kernel/dma.c, which is ISA-only).

 An example of such a system stands next to me now -- no ISA slots but all
of the above devices. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

