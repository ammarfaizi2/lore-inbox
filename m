Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbRFFTnz>; Wed, 6 Jun 2001 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbRFFTnq>; Wed, 6 Jun 2001 15:43:46 -0400
Received: from front6.grolier.fr ([194.158.96.56]:15086 "EHLO
	front6.grolier.fr") by vger.kernel.org with ESMTP
	id <S261390AbRFFTnh> convert rfc822-to-8bit; Wed, 6 Jun 2001 15:43:37 -0400
Date: Wed, 6 Jun 2001 18:31:26 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Adrian Cox <adrian@humboldt.co.uk>
cc: Marc Lehmann <pcg@goof.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
In-Reply-To: <3B1AB5BA.8060805@humboldt.co.uk>
Message-ID: <Pine.LNX.4.10.10106061820260.1373-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001, Adrian Cox wrote:

> Marc Lehmann wrote:
> 
> 
> > Aren't PCI delayed transaction supposed to be handled by the pci master
> > (e.g. my northbridge), not by the (software) driver for my pdc(?) I would
> > also be surprised if my pdc actually used that feature, not to speak of
> > the fact that the promise + harddisk worked fine in another computer (the
> > data corruption was easily detectable, one couldn't even write 500megs
> > without altered bytes).
> 
> 
> Wrong way round. You're right that the pci master is supposed to handle 
> delayed transactions, but during data transfer the pdc is the pci master 
> and the northbridge is the PCI target.

Wrong in my opinion, at least as it is worded. :)

PCI delayed transactions are not a PCI master issue at all, for the reason
it is not possible for a PCI master to distiguish between a transaction
which is delayed by the target and a simple retry requested by the target.

Btw, a PCI master that is unable to properly retry a transaction (could
the transaction be handled by the target as a delayed transaction on not)
would not allow a system to work for a long time. I would expect system
breakage within seconds in such situation.

Gérard.

