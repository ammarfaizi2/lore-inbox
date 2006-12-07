Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032282AbWLGO5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032282AbWLGO5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032281AbWLGO5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:57:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1998 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937974AbWLGO5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:57:50 -0500
Date: Thu, 7 Dec 2006 15:57:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Drake <dsd@gentoo.org>, Alan Cox <alan@redhat.com>,
       Chris Wedgwood <cw@f00f.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061207145755.GI8963@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45782774.8060002@gentoo.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 09:38:44AM -0500, Daniel Drake wrote:
> Adrian Bunk wrote:
> >Daniel Drake (1):
> >      PCI: VIA IRQ quirk behaviour change
> 
> Please drop this one, Alan isn't 100% on it and is working on getting a 
> better fix into mainline

Thanks for this information.

That's the one that fixes the breakage introduced in 2.6.16.17...

Looking at Alan's patch in -mm, it seems the best current solution for 
2.6.16 is to go back to the pre-2.6.16.17
  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
and revisit this after Alan's patch was released with 2.6.20?

> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

