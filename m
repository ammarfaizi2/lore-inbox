Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUHYPgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUHYPgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUHYPgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:36:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4829 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267869AbUHYPgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:36:42 -0400
Date: Wed, 25 Aug 2004 16:36:40 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040825153640.GF16196@parcelfarce.linux.theplanet.co.uk>
References: <20040814221010.GA18592@ucw.cz> <20040818181310.12047.qmail@web14927.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818181310.12047.qmail@web14927.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 11:13:10AM -0700, Jon Smirl wrote:
> I haven't received any comments on pci-sysfs-rom-17.patch. Is everyone
> asleep or is it ready to be pushed upstream? I'm still not sure that
> anyone has tried it on a ppc machine.

I'm now working on something that could use the ROM mapping facility.
However, I know that I only need the first 64k of the ROM.  Would it
be reasonable to check the value passed in to pci_map_rom() in *size
and only automatically set it if it's 0?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
