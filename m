Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVKDVvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVKDVvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVKDVvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:51:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:4049 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750954AbVKDVva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:51:30 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131111297.26925.24.camel@localhost.localdomain>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <1131086585.4680.235.camel@gaston>
	 <1131111297.26925.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 08:50:30 +1100
Message-Id: <1131141030.29195.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 13:34 +0000, Alan Cox wrote:
> On Gwe, 2005-11-04 at 17:43 +1100, Benjamin Herrenschmidt wrote:
> > > - HPA
> > > - IRQ mask
> > 
> > Why do we need the above at all ? It always looked to me like a gross
> > hack but then, I don't fully understand what the problem was on those
> > old x86 that needed it :)
> 
> You can't do anything useful with some systems without disabling the HPA
> because it is used to mask most of the drive at boot to hide from old
> incompatible BIOS.

I know, I was talking about IRQ Mask :)

> IRQ mask is on my todo list and looks quite easy. A small number of
> controllers mishandle the case when the FIFO empties. Instead of
> stalling the drive they dribble random numbers. 

OK, but my question why, what is the reason why we need IRQ mask ? Some
old non-PCI controllers can't grok un-related ISA IO cycles during a
FIFO read/write ? I suppose those would be broken on SMP too (though I
suspect then that those don't exist as SMP machines then :)

Ben.


