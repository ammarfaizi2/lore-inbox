Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbVHPM7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbVHPM7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVHPM7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:59:30 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:51165 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965206AbVHPM73 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:59:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cHMbA+7CWblgaGw0O/kCk0+/DkSamahCLrLjgVHNWre2ik53Hn7EIovXLTuOlQqqJLbn+4H8KkywXm4pLWpzKTSgMc+iq9NjEirVwmJJOeKXPlr9lW1BgVhIaMbuVD3RgkNcxgFKekLYUiu2pkyDkL4CDI3uOyyTfzfaLT2iX6U=
Message-ID: <58cb370e050816055924852804@mail.gmail.com>
Date: Tue, 16 Aug 2005 14:59:26 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <1124196958.17555.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <1123836012.22460.16.camel@localhost.localdomain>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <1124196958.17555.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-08-16 at 11:38 +0200, Bartlomiej Zolnierkiewicz wrote:
> > * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
> >   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)
> 
> IA64 systems can support PCI->Cardbus/PCMCIA cards so they do actually
> need this support. They could also do with cardbus IDE support but that
> means a whole pile of patches still although the refcounting stuff means
> its a lot closer to doable now

Therefore we need to fix ide-cs driver first to get rid of ide_init_hwif_ports()
which should be trivial unless some PPC32 specific hooks need it
(ide_ppc_md.ide_init_hwif).

> >   * ordering change for ide-pnp interfaces in case of no IDE devices
> >     on default IDE PCI ports, (but there aren't any ide-pnp devices on IA64?)
> 
> No ISAPnP

Excellent!

Bartlomiej
