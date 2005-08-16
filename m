Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVHPT6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVHPT6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVHPT6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:58:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3265 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932402AbVHPT6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:58:53 -0400
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <200508161316.32602.bjorn.helgaas@hp.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <200508161316.32602.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 21:25:46 +0100
Message-Id: <1124223946.22924.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)
> 
> HDIO_SCAN_HWIF - I don't know about this one.  How are we supposed to
> follow the "new ports shouldn't define IDE_ARCH_OBSOLETE_INIT" injunction
> if we lose all this functionality without it?  ia64 is about as close to
> a new port as you get :-)

It allows you to register interfaces from user space.

As to IDE_ARCH_OBOSOLETE_INIT, its a red herring. It's not worth the
trouble to avoid it given the expected short remaining life time of the
old IDE layer. Far better would be to help get the new SATA layer doing
PATA so drivers/ide can be deleted.

> IDE on ia64 is little-used, so I'm OK with leaving it alone, but
> I do think it's wrong for an architecture with no real restriction
> to specify MAX_HWIFS in ide.h.  Better to have the config option,
> and make the default there larger if necessary.

In the ideal world - its a historical inheritance that its not dynamic -
you probably should set it to 10 though - just for plug in IDE cards.


