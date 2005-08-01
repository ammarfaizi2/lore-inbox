Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVHAGsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVHAGsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVHAGsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:48:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262356AbVHAGsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:48:37 -0400
Date: Mon, 1 Aug 2005 07:48:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re: -rc4: arm broken?)
Message-ID: <20050801074831.A677@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk> <20050730223628.M26592@flint.arm.linux.org.uk> <1122858068.15622.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1122858068.15622.10.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 01, 2005 at 02:01:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 02:01:07AM +0100, Alan Cox wrote:
> On Sad, 2005-07-30 at 22:36 +0100, Russell King wrote:
> > Since PCMCIA cards are detected and drivers bound at boot time, we no
> > longer get hotplug events to setup networking for PCMCIA network cards
> > already inserted.  Consequently, if you are relying on /sbin/hotplug to
> > setup your PCMCIA network card at boot time, triggered by the cardmgr
> > startup binding the driver, it won't happen.
> 
> So eth0 now randomly changes between on board and PCMCIA depending upon
> whether the PCMCIA card was inserted or not, and your disks re-order
> themselves in the same situation. That'll be funny if anyone does a
> mkswap to share their swap between Linux and Windows. Gosh look there
> goes the root partition.
> 
> I'm hoping thats not what you are implying. Especially for disks,
> network is much much less of an issue.

If you have the socket driver as a module, as some (most?) distros do,
then of course such cards won't be detected at boot time.  If PCMCIA
and the socket driver are built-in, along with the card driver, then
I guess this possibility may well exist - it does for NE2K cards.

Since I don't use CF cards with PCMCIA here, I can't say what the ide-cs
behaviour actually is.  This is why I'm trying to encourage folk to
explore the kernels new behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
