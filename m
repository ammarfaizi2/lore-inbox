Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753458AbWKGVqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbWKGVqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbWKGVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:46:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:20627 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1753450AbWKGVqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:46:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,397,1157353200"; 
   d="scan'208"; a="157693262:sNHT19303158"
Date: Tue, 7 Nov 2006 13:44:39 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: David Weinehall <tao@acc.umu.se>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-Id: <20061107134439.1d54dc66.kristen.c.accardi@intel.com>
In-Reply-To: <20061107204409.GA37488@vasa.acc.umu.se>
References: <20061101115618.GA1683@elf.ucw.cz>
	<20061102175403.279df320.kristen.c.accardi@intel.com>
	<20061105232944.GA23256@vasa.acc.umu.se>
	<20061106092117.GB2175@elf.ucw.cz>
	<20061107204409.GA37488@vasa.acc.umu.se>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 21:44:09 +0100
David Weinehall <tao@acc.umu.se> wrote:

> On Mon, Nov 06, 2006 at 10:21:17AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > > With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> > > > > info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> > > > > (-mm1 behaves the same).
> > > > 
> > > > Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
> > > > PCI Root Bridge whenever the lid opens up.
> > > > 
> > > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > > it has no hotpluggable slots.
> > > 
> > > How about the docking station?
> > 
> > "Dock" for x60 only contains cdrom slot and aditional slots, no PCI or
> > PCMCIA slots.
> 
> Well, when I press the undock button on the dock without the acpiphp
> module loaded, I never get the green light that confirms that removing
> the laptop is safe.  If acpiphp is loaded, things work just fine.
> 
> 
> Regards: David
> -- 
>  /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
> //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> \)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/

David,
What kernel version are you using?  You should not need acpiphp to do
docking on the X60.  If you are using a recent kernel, do you mind sending
the dmesg output so we can figure out why this doesn't work for you?

Thanks,
kristen
