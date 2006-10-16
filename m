Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWJPTBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWJPTBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWJPTBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:01:23 -0400
Received: from colin.muc.de ([193.149.48.1]:3844 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1422686AbWJPTBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:01:22 -0400
Date: 16 Oct 2006 21:01:15 +0200
Date: Mon, 16 Oct 2006 21:01:15 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
Message-ID: <20061016190115.GA45331@muc.de>
References: <1161013892.24237.100.camel@localhost.localdomain> <20061016160759.GA14354@muc.de> <1161017113.24237.115.camel@localhost.localdomain> <20061016162426.GB14354@muc.de> <1161018340.24237.122.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161018340.24237.122.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 06:05:40PM +0100, Alan Cox wrote:
> Ar Llu, 2006-10-16 am 18:24 +0200, ysgrifennodd Andi Kleen:
> > > You can't hot unplug your MMU
> > 
> > Not sure about that. Calgary is afaik in the bridges and since Summit
> > has pluggable PCI cages and nodes i would assume the MMU instances are also
> > hot pluggables.
> 
> If so Linux doesn't currently support that and the patch keeps things as
> they are except for using hotplug safe APIs (and since I want to
> exterminate pci_find_device* shortly thats preferable)
> 

Ok i applied the patch to -rc2, but it results in 

arch/x86_64/pci/built-in.o: In function `pcibios_irq_init':
irq.c:(.init.text+0xc7e): undefined reference to `pci_get_bus_and_slot'

That function is also nowhere to be found:

% gid pci_get_bus_and_slot
%

So dropped again.

-Andi
