Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTDISAS (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 14:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTDISAR (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 14:00:17 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:12441 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263653AbTDISAQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 14:00:16 -0400
Date: Wed, 9 Apr 2003 08:38:33 +0200
From: Dominik Brodowski <linux@brodo.de>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030409063833.GA1988@brodo.de>
References: <20030408223111.GA25785@bougret.hpl.hp.com> <3E93538C.9010306@pobox.com> <20030409000553.GA26454@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409000553.GA26454@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 05:05:53PM -0700, Jean Tourrilhes wrote:
> On Tue, Apr 08, 2003 at 06:56:12PM -0400, Jeff Garzik wrote:
> > 
> > >	Example :
> > >	Lucent/Agere Orinoco wireless card :
> > >		manfid 0x0156,0x0002
> > >		possible drivers : wlan_cs ; orinoco_cs
> > >	Intersil PrismII and clones (Linksys, ...) :
> > >		manfid 0x0156,0x0002
> > >		possible drivers : prism2_cs ; hostap_cs
> > >
> > >	Please explain me in details how your stuff will cope with the
> > >above, and how to make sure the right driver is loaded in every case
> > >and how user can control this.

Actually, I was unaware of this problem: etc/* of pcmcia-cs-3.2.3 only tells
me about the orinoco_cs driver. And that's the only one I can find in kernel
2.5.67 as well.... However, for such cases there is already an override
option in my patches:
echo -n "driver_the_next_device_needs" > /sys/bus/pcmcia/settings/force_match

> > >	If your scheme can't cope with the simple real life example
> > >above (I've got those cards on my desk, and those drivers on my disk),
> > >then it's no good to me.
> > 
> > These cases already exist for PCI, so pcmcia behavior should follow what 
> > the kernel does when the PCI core sees such.

i.e. a ->probe() callback?


	Dominik
