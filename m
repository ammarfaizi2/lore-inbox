Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132074AbQLHQi5>; Fri, 8 Dec 2000 11:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132271AbQLHQih>; Fri, 8 Dec 2000 11:38:37 -0500
Received: from janeway.cistron.net ([195.64.65.23]:25350 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S132074AbQLHQi1>; Fri, 8 Dec 2000 11:38:27 -0500
Date: Fri, 8 Dec 2000 17:07:55 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <wtarreau@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre25
Message-ID: <20001208170755.A28838@cistron.nl>
In-Reply-To: <976268866.3a30ae4296b71@imp.free.fr> <E144OCf-0003ws-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E144OCf-0003ws-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 08, 2000 at 02:08:46PM +0000
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alan Cox:
> > my server currently works with that patch, but I'm sure it won't boot anymore
> > if I apply this 2.2.18pre25 alone. 
> 
> Some days I don't know why I bother

Bad day, Alan? ;)

> > just in case, here it is again.
> It doesnt even apply

Hmm, it did apply for me. Do newer versions of patch have the -l option
on by default?

Anyway. I just threw together a testmachine with a megaraid card.
With 2.2.18pre18, it doesn't boot. With 2.2.18pre18 + Willy's patch,
it does boot.

And with 2.2.18pre25 without any extra patches, it magically works.

So I took the plunge and compiled 2.2.18pre25 on the production
machine with the megaraid. And well, it's coming up as I write this.

I see that another patch _has_ been applied between pre18 and pre25
that tooks out some forward/backwards-compat logic with LINUX_VERSION_CODE
magic (beneath /* Read the base port and IRQ from PCI */). And
reading the patch, it makes sense. It probably does about the same
as Willy's patch, but the "right" way by using pci_resource_start()
which the one in pre18 only did for kernels > 2.3.0

So, it looks like pre25 has a working megaraid driver. Thanks Alan.

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
