Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271286AbTGWUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271285AbTGWUFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:05:39 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:44540 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271275AbTGWUFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:05:34 -0400
Subject: Re: compact flash IDE hot-swap summary please
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Dave Lawrence <dgl@integrinautics.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030723204954.A439@flint.arm.linux.org.uk>
References: <3F1ECFDD.D561D861@integrinautics.com>
	 <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>
	 <20030723204954.A439@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058991230.5515.126.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 21:13:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 20:49, Russell King wrote:
> > Drive level hotswap is supported only in the "I unmounted it all
> > properly first" case and providing your system has the required bus
> > isolation. Typically its also only allowed in IDE if you have a
> > single disk on the channel. With dual device you tend to have nasty
> > accidents pulling something out while the other device is "live"
> 
> Any ideas if this is going to be fixed for 2.6?  I think this is a show
> stopper, certainly for embedded devices - a fair number of people do use
> CF cards in their embedded solutions, and some of us hotplug CF cards to
> grab images off our digital cameras.

Everyone I know is using the PCMCIA interface stuff for that. Now that 
can support the unplugging but the ide-cs code is still not doing the
right things in this case (and the core could be a little more careful).
The ide_unregister can fail - you are supposed to call it again later if
it does - ide_cs doesnt

