Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUHEVSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUHEVSC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUHEVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:15:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11658 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267977AbUHEVPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:15:25 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Thu, 5 Aug 2004 14:12:06 -0700
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040805204518.21243.qmail@web14921.mail.yahoo.com>
In-Reply-To: <20040805204518.21243.qmail@web14921.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051412.06169.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 5, 2004 1:45 pm, Jon Smirl wrote:
> If you follow the code path of pci_assign_resource() it will program
> the ROM to appear at the newly assigned address in
> pci_update_resource(). I'd check these code paths and see if they are
> 64 bit broken. This process does work on ia32.

I think just my platform is broken (i.e. pci_assign_resource doesn't do the 
right thing on sn2).  I'll take a look.

> If you can read the ROM without a resource assigned it is just luck
> that everything is still in the same place as boot. If you start
> hotpluging the original ROM address could get used by another card
> since is is not actively assigned.

Right.

Thanks,
Jesse
