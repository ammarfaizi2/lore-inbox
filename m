Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274960AbTHAWQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 18:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274962AbTHAWQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 18:16:48 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:36362 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S274960AbTHAWQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 18:16:31 -0400
Date: Sat, 2 Aug 2003 00:16:27 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
Message-ID: <20030801221627.GA3397@win.tue.nl>
References: <1059747945.2809.2.camel@paragon.slim> <20030801145223.GA3308@win.tue.nl> <1059752011.2691.13.camel@paragon.slim> <20030801163759.GA3343@win.tue.nl> <1059760564.3404.9.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059760564.3404.9.camel@paragon.slim>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 07:56:04PM +0200, Jurgen Kramer wrote:

> PC 2.4 showkey:
> keycode  43 release
> keycode  43 press
> 
> PC 2.6 showkey:
> keycode  84 press
> keycode  84 release

Funny indeed.

The USB standards define USB code 49 for the US \| key,
USB code 50 for the non-US \| key (French mu, etc),
and USB code 137 for the Japanese Yen |.
So, you should get one of these.

This USB code is translated to a Linux keycode in
usb_kbd_keycode[] in usbkbd.c.
The three possible translations are 43, 84, 183.

Maybe you can check for yourself (e.g. with a printk in usbkbd.c)
that you really get different USB codes from that keyboard under
2.4 and 2.6?

Maybe the code one gets depends on the initialization of the keyboard.

