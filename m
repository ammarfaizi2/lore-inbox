Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTD3Ry3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTD3Ry3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:54:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:21708 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262272AbTD3Ry1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:54:27 -0400
Date: Wed, 30 Apr 2003 11:06:44 -0700
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc1 compile failure [toshoboe]
Message-ID: <20030430180644.GC30338@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030429015841.GA17454@bougret.hpl.hp.com> <20030430174530.GA453@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430174530.GA453@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 07:45:30PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > I get compile failure for 2.4.21-rc1:
> > > 
> > > "in irda_device_init: undefined reference to toshoboe_init".
> > 
> > 	Non-modular IrDA is not supported in 2.4.X and is known to be
> > broken in various way (see bottom of my web page). This was fixed in
> > 2.5.24, but won't be fixed in the 2.4.X serie. However, I always
> > accept trivial patches...
> > 	Have fun...
> 
> Fix was to kill toshoboe_init() from irda_device_init(): it is
> module_init() so it gets called, anyway.

	Actually, it should probably be encapsualted in
TOSHIBA_OLD. But unfortunately, there is more than that, trust me.

> Unfortunately toshoboe in 2.4.21-rc1 works as badly as in 2.5: the
> "new" driver does not even detect it and the "old" driver breaks with
> max_baud > 9600.

	First, please verify if you have the same problem when the
full IrDA stack and drivers are modular.
	I would expect the same behaviour in 2.5.X and 2.4.X, because
it's the same driver. I personally don't have this hardware, so can't
do much, and the maintainer are unresponsive. It supposed to work
better if you pass the flag to bypass the self test.
	Also, most modern Toshiba laptops seems to have SMC instead of
toshoboe hardware.

> 								Pavel

	Good luck...

	Jean
