Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUBPBti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUBPBtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:49:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:23455 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265303AbUBPBtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:49:33 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: earny@net4u.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402160218.44351.earny@net4u.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <200402160138.02212.earny@net4u.de> <1076892215.6957.141.camel@gaston>
	 <200402160218.44351.earny@net4u.de>
Content-Type: text/plain
Message-Id: <1076896067.6959.144.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 12:47:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry, does not work. Previous attached patch does not help.
> 
> I'm _not_ using any binary drivers, as far as i know ;-)
> I'm using gentoo stable,  i don't know exactly which patches are applied to 
> the x-server:-)
> 
> relevant entries in this config:
> 
> Section "Device"
>         Identifier  "Card0"
>         Driver      "vesa"
>         VendorName  "ATI Technologies Inc"
>         BoardName   "Unknown Board"
>         BusID       "PCI:1:0:0"
> EndSection

Ok, same kind of problem caused by the "radeon" driver in XFree,
it tries to restore some vesa stuffs and fails, and for some reason
radeonfb doesn't properly reconfigure the chip.

As soon as i get this x86 box here, I'll try to find a fix. A
workaround is to use the "radeon" driver in XFree with the
Option "UseFBDev" "true"

Ben.


