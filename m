Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUA3NeH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 08:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUA3NeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 08:34:07 -0500
Received: from linux-bt.org ([217.160.111.169]:61906 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263834AbUA3NeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 08:34:04 -0500
Subject: Re: Bluetooth oddity
From: Marcel Holtmann <marcel@holtmann.org>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1075462349.9698.4.camel@tor.trudheim.com>
References: <1075462349.9698.4.camel@tor.trudheim.com>
Content-Type: text/plain
Message-Id: <1075469610.26729.108.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 14:33:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

> Out of curiosity, has anyone else noticed something odd with Bluetooth
> in 2.6.x kernels? On my Thinkpad X31 I can switch it on/off with Fn+F5.
> Switching it on is no problem, but switching it off causes solid hang of
> the Thinkpad. Only SysRq+b works.

I assume that you have enabled the SCO support of the HCI USB driver.
The unlink of ISOC URB's fails on UHCI host controllers and actually I
don't know why. So disable the SCO support of the HCI USB driver and you
can switch on and off your Bluetooth device as often as you like.

What is your USB host controller chipset? Do you see an oops?

> It is not the whole world, but a little irritating. Also, I use
> Bluetooth to hot-sync my Tungsten T|3. Same problem occurs on the 4th -
> 6th sync, solid hang of the Thinkpad. No debug output yet, if any
> Bluetooth developers are interested to have this fixed, I am game to
> help debug this.

This was a bug in the RFCOMM layer that has been already fixed. Why
don't you say what 2.6 kernel do you use? Try the latest 2.6.2-rc2 or
2.6.1-mh3 and this will go away.

Regards

Marcel


