Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTLDLBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 06:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLDLBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 06:01:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25797 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261779AbTLDLBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 06:01:02 -0500
Date: Thu, 4 Dec 2003 12:01:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Yasunori Goto <ygoto@fsw.fujitsu.com>, linux-kernel@vger.kernel.org,
       "Luck, Tony" <tony.luck@intel.com>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] RE: memory hotremove prototype, take 3
Message-ID: <20031204110101.GF11044@atrey.karlin.mff.cuni.cz>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125DD6A@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125DD6A@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I still think we could use the CPU's virtualization mechanism--of course,
> > > and as you and Tony Luck mention, we'd had to track down and modify the
> > > parts that assume physical memory et al. That they use large pages
> > > or
> > 
> > ...which means basically auditing whole kernel, and rewriting half of
> > drivers. Good luck with _that_.
> 
> Bingo...just the perfect excuse I need to give to my manager to keep
> a low profile while tinkering around for a long time :)
> 
> Okay, so I will play a wee bit more the devil's advocate as an 
> exercise of futility, if you don't mind. Just trying to compile a 
> (possibly incomplete) quick list of what would be needed, can you 
> guys help me? you know way more than I do:
> 
> 1) the core kernel needs to be independent of physical memory position
> 1.1) same with drivers/subsystems
> 1.2) filesystems
> [it cannot be really incomplete because I have added all the code
> :/]

...and you have bad problem at any place where physical address is
passed to the hardware. UHCI is going to be "interesting".
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
