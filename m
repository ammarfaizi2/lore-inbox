Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUKWUSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUKWUSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUKWUQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:16:19 -0500
Received: from [82.147.40.124] ([82.147.40.124]:51080 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S261563AbUKWUNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:13:46 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Stian Jordet <stian_web@jordet.nu>
To: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1101193585.20006.533.camel@d845pe>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
	 <1101151780.20006.69.camel@d845pe>
	 <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
	 <1101155893.20007.125.camel@d845pe>
	 <Pine.LNX.4.58.0411221815460.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411222048120.20993@ppc970.osdl.org>
	 <1101193585.20006.533.camel@d845pe>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 21:13:01 +0100
Message-Id: <1101240781.10178.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
If the reason for cc'ing me was for me to verify it still works on my
VIA board, I can confirm it does with Linus' patch :)

Thanks.

Best regards,
Stian

tir, 23,.11.2004 kl. 02.06 -0500, skrev Len Brown:
> On Mon, 2004-11-22 at 23:57, Linus Torvalds wrote:
> > 
> > On Mon, 22 Nov 2004, Linus Torvalds wrote:
> > >
> 
> > Len, how about this patch - it re-enables the link disable and then
> > re-codes the ELCR setting to match.
> > 
> > Basically it just computes the new ELCR: if acpi_noirq is set, it
> > leaves it at the old value, otherwise it zeroes it - and in both cases
> > it fixes the SCI entry.
> 
> > Your argument for doing this ended up being convincing, so the only
> > difference between this and your debug patch is really just the
> > obvious organizational ones, and the test for "acpi_noirq", which I
> > think is needed (since if acpi_noirq is set, we're not going to
> > disable and re-enable the PCI interrupts, so we'll just have to trust
> > ELCR).
> 
> I think your use of acpi_noirq in acpi_pic_sci_set_trigger() was clever
> -- maybe more clever than the name of the routine suggests -- but it
> looks correct.
> 
> thanks for restoring pci_link.c
> 
> -Len
> 

