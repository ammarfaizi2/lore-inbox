Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVIMV5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVIMV5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVIMV5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:57:10 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:13565 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932499AbVIMV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:57:08 -0400
Date: Tue, 13 Sep 2005 18:25:50 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, nkiesel@tbdnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
Message-ID: <20050913182550.A10911@mail.kroptech.com>
References: <20050913120255.A16713@mail.kroptech.com> <Pine.LNX.4.58.0509130850550.3351@g5.osdl.org> <20050913.132213.01982680.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050913.132213.01982680.davem@davemloft.net>; from davem@davemloft.net on Tue, Sep 13, 2005 at 01:22:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 01:22:13PM -0700, David S. Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Tue, 13 Sep 2005 08:55:31 -0700 (PDT)
> 
> > >         /* Reset expansion ROM address decode enable */
> > >         pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
> > >         w &= ~PCI_ROM_ADDRESS_ENABLE;
> > >         pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);
>  ...
> > So the above probably works fine, especially since it's just disabling the 
> > ROM (ie we don't end up caring at all about the upper bits even if they 
> > did get the wrong value). But it's definitely bad practice, and there are 
> > probably cards (for which that driver is irrelevant, of course ;) where 
> > doing something like the above might not work at all.
> 
> I think for consistency the above driver case should still be fixed,
> however.  This way when people try to audit the tree for
> PCI_ROM_ADDRESS config space accesses, they won't come across this
> same instance again and again.

Agreed. I'll follow up with patches for the relevant maintainers.

--Adam

