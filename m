Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTLDJy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 04:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTLDJy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 04:54:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47287 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262776AbTLDJy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 04:54:27 -0500
Date: Thu, 4 Dec 2003 10:54:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Yasunori Goto <ygoto@fsw.fujitsu.com>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] RE: memory hotremove prototype, take 3
Message-ID: <20031204095426.GB6911@atrey.karlin.mff.cuni.cz>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125DD50@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125DD50@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > IMHO, To hot-remove memory, memory attribute should be divided
> > > > into Hotpluggable and no-Hotpluggable, and each attribute memory
> > > > should be allocated each unit(ex. node).
> > >
> > > Why? I still don't get that -- we should be able to use the virtual
> > > addressing mechanism of any CPU to swap under the rug any virtual
> > > address without needing to do anything more than allocate a page frame
> > > for the new physical location
> > 
> > My understanding is that the kernel and device drivers sometimes
> > assume physical memory address is not changed.
> > For example, IA32 kernel often uses __PAGE_OFFSET.
> > I suppose that there are many case which the kernel and device drivers
> > assume physical address is not changed like this.
> > Even if we use Mr. Iwamoto's method use, some memories will remain.
> 
> Grrrr ... my concern is that Murphy's Law says that we'll need to hotplug
> the memory that we cannot in most of the cases (pray not). I guess I will
> need to research some more to think how to do it.
> 
> I still think we could use the CPU's virtualization mechanism--of course,
> and as you and Tony Luck mention, we'd had to track down and modify the
> parts that assume physical memory et al. That they use large pages
> or

...which means basically auditing whole kernel, and rewriting half of
drivers. Good luck with _that_.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
