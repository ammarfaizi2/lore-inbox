Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUH1QmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUH1QmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUH1QlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:41:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9095 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267438AbUH1QfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:35:25 -0400
Date: Sat, 28 Aug 2004 17:35:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040828163521.GD16196@parcelfarce.linux.theplanet.co.uk>
References: <20040827164303.GW16196@parcelfarce.linux.theplanet.co.uk> <20040827222938.12618.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827222938.12618.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 03:29:38PM -0700, Jon Smirl wrote:
> I would think that it would return 4MB. If it can't find standard ROM
> headers it should return the window size. 

The patch I just sent changes this ... if we can find PCI headers,
we should return nothing.

> Are you sure you are getting the correct contents of those ROMs? Would
> it be worthwhile to try and get the author of the ROMs to add standard
> ROM headers? The content you included doesn't look that useful unless
> that is what IA64 instructions look like.

It looks like nothing that makes any sense to me.  Maybe it's a blanked
EEPROM or something.  This particular device is on the motherboard of a
prototype machine, so there could be almost anything going on with it ;-)

> If reading past 1MB for those ROMs causes a reboots, could something be
> wrong in the IA64 fault handing code?

No, that's normal behaviour on ia64 -- unacknowledged PCI reads cause a
machine check rather than reading ffffffff like x86 does.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
