Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSC2T5y>; Fri, 29 Mar 2002 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSC2T5n>; Fri, 29 Mar 2002 14:57:43 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59911
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311732AbSC2T5d>; Fri, 29 Mar 2002 14:57:33 -0500
Date: Fri, 29 Mar 2002 11:56:43 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac[23] do not boot
In-Reply-To: <E16r2Z0-0001tR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203291148070.10681-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Alan Cox wrote:

> > This is possible, however one of the problems encountered is the
> > following under several chipsets.  If there is no pio timing set at all,
> > then we can run into host lock issues if the driver drops out of dma.
> > Thus, if it is going to lockup here it would/could lock up in other
> > places when one trys to program the host for PIO.
> 
> Well right at the moment the ALi locks up on boot reliably. That means a
> fix has to be found, or the ALi changes reverted 

The real bug may be a rusult of improper setup and since there is no cable
detection bit in the XMETA Lifebook, but it needs the southbridge setup
calls, that snippet of code must be move to above function.

lines  570-590  and 611-620 or there abouts, with their if(version) test.

Rereading the code, docs, comments -- it is clear pci_init code for the
host.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

