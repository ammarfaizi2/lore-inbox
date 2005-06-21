Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFUNsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFUNsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFUNob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:44:31 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:15632 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261448AbVFUNnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:43:52 -0400
Date: Tue, 21 Jun 2005 14:42:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: PATCH: IDE - sensible probing for PCI systems
In-Reply-To: <1119356601.3279.118.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Alan Cox wrote:

> Old ISA/VESA systems sometimes put tertiary IDE controllers at addresses
> 0x1e8, 0x168, 0x1e0 or 0x160. Linux thus probes these addresses on x86
> systems. Unfortunately some PCI systems now use these addresses for
> other purposes which leads to users seeing minute plus hangs during boot
> or even crashes.

 Are these addresses visible in BARs?

> The following patch (again has been in Fedora for a while) only probes
> the obscure legacy ISA ports on machinea that are pre-PCI. This seems to
> keep everyone happy and if there is someone with that utterly weird
> corner case the ide= command line still provides a get out of jail card.
> Unsurprisingly we've not found anyone so affected.

 FYI, for MIPS for machines with a PCI bus we only probe for ISA IDE ports 
on if there's a PCI-ISA or PCI-EISA bridge somewhere there.  This might be 
a good idea for the i386 and probably any platform using PCI as well.

  Maciej
