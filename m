Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263259AbVCKKeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbVCKKeB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVCKKeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:34:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42196 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263260AbVCKKdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:33:50 -0500
Date: Fri, 11 Mar 2005 11:31:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
Message-ID: <20050311103146.GC30252@elf.ucw.cz>
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU> <20050311071825.GA28613@kroah.com> <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> +/* + * The PCI subsystem is implemented as yet-another pseudo
> >> filesystem, + * albeit one that is never mounted.  + * This is its
> >> magic number.  + */ +#define USR_PCI_MAGIC (0x12345678)
> 
> Greg> If you make it a real, mountable filesystem, then you don't need
> Greg> to have any of your new syscalls, right?  Why not just do that
> Greg> instead?
> 
> 
> The only call that would go is usr_pci_open() -- you'd still need 
> usr_pci_map(), usr_pci_unmap() and usr_pci_get_consistent().

There are quite a lot of buses. Having to add #buses * 3 seems quite
wrong to me...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
