Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVCLArv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVCLArv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVCLArv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:47:51 -0500
Received: from peabody.ximian.com ([130.57.169.10]:9401 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261792AbVCLArs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:47:48 -0500
Subject: Re: [2.6 patch] drivers/pnp/: possible cleanups
From: Adam Belay <abelay@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, perex@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050311162320.15007aa3.akpm@osdl.org>
References: <20050311181606.GC3723@stusta.de>
	 <1110585763.12485.223.camel@localhost.localdomain>
	 <20050311162320.15007aa3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 19:44:56 -0500
Message-Id: <1110588297.12485.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 16:23 -0800, Andrew Morton wrote:
> Adam Belay <abelay@novell.com> wrote:
> >
> > This patch essential makes it impossible for PnP protocols to be
> > modules.  Currently, they are all in-kernel.  If that is acceptable...,
> > then this patch looks fine to me.  Any comments?
> 
> You're the maintainer...

I've been holding off on making many changes to PnP at the moment,
because I have been considering replacing it with a new (more modern and
ACPI capable) ISA/LPC bridge driver.  This work would likely begin after
my PCI bridge driver rewrite is finished and merged (as the PCI work is
in some ways a prerequisite).

http://marc.theaimsgroup.com/?l=linux-kernel&m=111023821617705&w=2

Still, if there are changes to fix actual bugs, then I'm all for them.

Also a few features could be added.  Specifically PnPBIOS
hotplug/docking station support.  If anyone's interested, I may
implement it (and it would use some functions that were removed by this
patch).  Furthermore, ISAPnP could be made a module.  PnPBIOS probably
couldn't.

> 
> If someone converts a protocol to be moduar, presumably they will re-add
> the needed exports to support that.

Correct.

> 
> Are there likely to be any out-of-tree modular protocols in existence?
> 

Not that I'm aware of.

So in short, I'd rather not remove them, because they take away from the
original design of the PnP layer.

Thanks,
Adam


