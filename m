Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUH0Wda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUH0Wda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUH0Wct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:32:49 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:11371 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263448AbUH0W3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:29:40 -0400
Message-ID: <20040827222938.12618.qmail@web14922.mail.yahoo.com>
Date: Fri, 27 Aug 2004 15:29:38 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040827164303.GW16196@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Matthew Wilcox <willy@debian.org> wrote:
> The expansion rom PCI region claims to be 4MB in size, but if we try
> to read past 1MB, the machine reboots.  This won't be a problem with
> the latest patch because it'll return a size of 0.

I would think that it would return 4MB. If it can't find standard ROM
headers it should return the window size. 

Are you sure you are getting the correct contents of those ROMs? Would
it be worthwhile to try and get the author of the ROMs to add standard
ROM headers? The content you included doesn't look that useful unless
that is what IA64 instructions look like.

If reading past 1MB for those ROMs causes a reboots, could something be
wrong in the IA64 fault handing code?

I'd feel a lot better if someone actually tried this patch on a ppc or
sun machine.

=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
