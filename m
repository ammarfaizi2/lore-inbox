Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWJ3WiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWJ3WiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWJ3WiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:38:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:19389 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422717AbWJ3WiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:38:09 -0500
X-Authenticated: #20450766
Date: Mon, 30 Oct 2006 21:59:47 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known
 regressions)
In-Reply-To: <20061030120158.GA28123@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.60.0610302148560.9723@poirot.grange>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
 <20061030120158.GA28123@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Francois Romieu wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
> [...]
> > AFAIU, you wanted it applied on the top of the "non-working" kernel 
> > (2.6.19-rc2-ish)?
> 
> No. Please apply it on top of a 2.6.19-rc3 where the mac address change
> feature has been reverted (or where __rtl8169_set_mac_addr has been
> commented out at your option). 

Ok, with just __rtl8169_set_mac_addr disabled it works. With netconsole 
disabled, and your phy_reset patch applied it seems to still work. The 
printk

+		printk(KERN_ERR "%s: PHY reset failed.\n", dev->name);

doesn't get printed. If I uncomment __rtl8169_set_mac_addr it stops 
working again. What does it tell us about the original set_mac_address 
problem?

I haven't said it's an on-board chip, not a plug-in card. Don't know how 
setting the mac address worked in your configuration, but if it is storred 
in a prom, maybe it is just missing on my board?

The kernel is not 2.6.19-rc3 either. It is a clone of the powerpc git some 
time shortly after 2.6.19-rc2.

Thanks
Guennadi
---
Guennadi Liakhovetski
