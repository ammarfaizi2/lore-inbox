Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVBOBKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVBOBKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVBOBKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:10:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:1921 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261601AbVBOBIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:08:00 -0500
Subject: Re: Radeon FB troubles with recent kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, adaplas@pol.net
In-Reply-To: <20050215002025.GQ15058@waste.org>
References: <20050214203902.GH15058@waste.org>
	 <1108420723.12740.17.camel@gaston> <1108422492.12653.30.camel@gaston>
	 <20050215002025.GQ15058@waste.org>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 12:07:34 +1100
Message-Id: <1108429654.12739.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nope. No printk outputs from _set_par, _write_mode, or _engine_init.
> 
> Just to clarify: the gdm stop is done from tty1 while gdm is running
> on tty7, so I don't think it's a matter of mode switch logic.

Ohhh, this is a known bug then. When you kill X while it's not on the
front VT, it will crap on the engine. This has always been the case, I
suppose that if you didn't notice it before, it 's because you are
lucky :)

> If I do "sleep 5; /etc/init.d/gdm stop" and then switch to tty7 and
> wait for it to stop, all is fine.

Yes.
> 
> Also, I'm still seeing the LCD blooming + hang on starting radeonfb.
> It's something like 1 in 10 boots rather than every boot now though.

Does it actually hangs ? That's weird... looks like a chip crash. Can
you check if that happens with radeonfb.default_dynclk=-1 on the kernel
command line ?

Ben.


