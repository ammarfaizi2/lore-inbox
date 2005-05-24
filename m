Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVEXPAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVEXPAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVEXPAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:00:24 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:58304 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262074AbVEXO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:59:21 -0400
Date: Tue, 24 May 2005 18:58:56 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andi Kleen <ak@suse.de>
Cc: Rajesh Shah <rajesh.shah@intel.com>, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050524185856.A7639@jurassic.park.msu.ru>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050524120527.GB15326@wotan.suse.de>; from ak@suse.de on Tue, May 24, 2005 at 02:05:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 02:05:27PM +0200, Andi Kleen wrote:
> How about you allocate an extended structure with kmalloc in this case?

This would lead to quite a few changes in the PCI subsystem.
Looks good as a long-term solution though.

> Or if it is only 6 ranges max (it is not, is it?) you could extend
> the array.
> 
> I doubt this information will need *that* much memory, so it should
> be reasonable to just teach the PCI subsystem about it.

Agreed. As a bonus, extending the PCI_BUS_NUM_RESOURCES to 6 would
cleanly resolve problems with "transparent" PCI bridges - the bus
might have 3 "native" + 3 parent bus ranges in that case.

Ivan.
