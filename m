Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137019AbRATFib>; Sat, 20 Jan 2001 00:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136908AbRATFiV>; Sat, 20 Jan 2001 00:38:21 -0500
Received: from quattro.sventech.com ([205.252.248.110]:9736 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S136653AbRATFiM>; Sat, 20 Jan 2001 00:38:12 -0500
Date: Sat, 20 Jan 2001 00:38:12 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Subject: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
Message-ID: <20010120003812.G9156@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3A691043.F18CA6CA@megapathdsl.net>; from Miles Lane on Fri, Jan 19, 2001 at 08:12:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001, Miles Lane <miles@megapathdsl.net> wrote:
> Johannes Erdfelt wrote:
> 
> > TODO
> > ----
> > - The PCI DMA architecture is horribly inefficient on x86 and ia64. The
> >   result is a page is allocated for each TD. This is evil. Perhaps a slab
> >   cache internally? Or modify the generic slab cache to handle PCI DMA
> >   pages instead?
> 
> This might be the kind of thing to run past Linus when the 2.5 tree 
> opens up.  Are these inefficiencies necessary evils due to workarounds 
> for whacky bugs in BIOSen or PCI chipsets or are they due to poor 
> design/implementation?

Looks like poor design/implementation. Or perhaps it was designed for
another reason than I want to use it for.

2.5 is probably where any core changes will happen, if any. But for now
I suspect I'll need to workaround it in my driver.

I should also check architectures other than x86 and ia64.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
