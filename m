Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUBUOe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUBUOeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:34:25 -0500
Received: from s4.uklinux.net ([80.84.72.14]:48362 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S261563AbUBUOeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:34:24 -0500
Date: Sat, 21 Feb 2004 14:33:56 +0000
To: Adam Belay <ambx1@neo.rr.com>, Mark Hindley <mark@hindley.uklinux.net>,
       linux-kernel@vger.kernel.org
Subject: Re: pnp missing proc entries?
Message-ID: <20040221143356.GA5558@titan.home.hindley.uklinux.net>
References: <20040218074414.GA11598@titan.home.hindley.uklinux.net> <20040218112414.GA10238@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218112414.GA10238@neo.rr.com>
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
X-MailScanner-Titan: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Feb 18, 2004 at 11:24:14AM +0000, Adam Belay wrote:
> Hi,
> 
> On Wed, Feb 18, 2004 at 07:44:14AM +0000, Mark Hindley wrote:
> > Hi,
> > 
> > I have just switched to 2.6 and am trying to resolve and irq conflict
> > between a sound card and internal modem.
> 
> Is the pnp layer complaining about this conflict?  Are you using pnpbios 
> support?  Are both the sound card and internal modem isapnp devices?

Both are internal -- Rockwell/ALS100. I get no complaints from the pnp
layer, other than a refusal to config one if the other modules is
loaded. Both want to use irq 5. I have pnpbios in too.

I have just fixed a problem with unloading the 8250_pnp module, so am
hoping I can delve into this a bit more.

It seems that pnp is only trying the first config option for the device
and then bailing out if that won't fit with what else is setup.

Mark
