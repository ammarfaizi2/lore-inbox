Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVGGAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVGGAXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVGFUAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:45264 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262367AbVGFQrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:47:31 -0400
Date: Wed, 6 Jul 2005 09:47:24 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
Message-ID: <20050706164724.GB14165@kroah.com>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <200507061128.49843.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061128.49843.rjw@sisk.pl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 11:28:49AM +0200, Rafael J. Wysocki wrote:
> PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.0
> PCI: Failed to allocate mem resource #10:2000000@100000000 for 0000:02:01.1
> PCI: Failed to allocate I/O resource #7:1000@e000 for 0000:02:01.1
> PCI: Failed to allocate I/O resource #8:1000@e000 for 0000:02:01.1

Do you also get the above errors on booting with -rc1?

> PCI: Bus 3, cardbus bridge: 0000:02:01.0
>   IO window: 0000b000-0000bfff
>   IO window: 0000c000-0000cfff
>   PREFETCH window: 30000000-31ffffff
> PCI: Bus 7, cardbus bridge: 0000:02:01.1
>   PREFETCH window: 32000000-33ffffff
> PCI: Bridge: 0000:00:0a.0
>   IO window: b000-dfff
>   MEM window: f8a00000-feafffff
>   PREFETCH window: 30000000-34ffffff
> PCI: Bridge: 0000:00:0b.0
>   IO window: disabled.
>   MEM window: f6900000-f89fffff
>   PREFETCH window: c6800000-e67fffff
> PCI: Setting latency timer of device 0000:00:0a.0 to 64
> PCI: Device 0000:02:01.0 not available because of resource collisions
> PCI: Device 0000:02:01.1 not available because of resource collisions

And these?  As this is your carbus bridge, I'm guessing that is why -rc2
is failing for you.

thanks,

greg k-h
