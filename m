Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUH1Vxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUH1Vxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUH1Vxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:53:35 -0400
Received: from colo.lackof.org ([198.49.126.79]:35514 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S268052AbUH1Vx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:53:29 -0400
Date: Sat, 28 Aug 2004 15:53:26 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040828215326.GE20230@colo.lackof.org>
References: <20040827164303.GW16196@parcelfarce.linux.theplanet.co.uk> <20040827222938.12618.qmail@web14922.mail.yahoo.com> <20040828163521.GD16196@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828163521.GD16196@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 05:35:21PM +0100, Matthew Wilcox wrote:
> > If reading past 1MB for those ROMs causes a reboots, could something be
> > wrong in the IA64 fault handing code?
> 
> No, that's normal behaviour on ia64 -- unacknowledged PCI reads cause a
> machine check rather than reading ffffffff like x86 does.

Only on HP IA64 machines (just like on HP parisc machines).
Intel IA64 machines return -1 or garbage on Master Abort
(due to timeout) just like the IA32 platforms.

grant
