Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUHSXBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUHSXBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUHSXAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:00:47 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:49313 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267493AbUHSXAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:00:09 -0400
Message-ID: <20040819230008.3874.qmail@web14927.mail.yahoo.com>
Date: Thu, 19 Aug 2004 16:00:08 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1092919910.28129.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-08-18 at 19:13, Jon Smirl wrote:
> > I haven't received any comments on pci-sysfs-rom-17.patch. Is
> > everyone asleep or is it ready to be pushed upstream? I'm still 
> > not sure that anyone has tried it on a ppc machine.
> 
> Looks ok to me. Not sure we ever want to copy roms kernel side but
> thats a minor query only.
> 

Drivers for hardware with partial PCI decoding need to at least add a
call to pci_remove_rom() to remove the rom attribute from sysfs. I
don't know which hardware has this problem or even if any hardware with
a Linux driver has this problem. If anyone is maintainer for a driver
like this, please let me know and I can add the call to
pci_remove_rom().

Also, I believe the i386 quirk should also be applied to the x86_64
arch. I don't have the hardware and I don't know enough about the boot
aequence in 64 bits to do the right thing with a guess. The code is not
broken for x86_64, it just may not pick up the right ROM image on that
architecture.


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
