Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUBOXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUBOXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:09:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:2207 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265228AbUBOXJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:09:28 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: earny@net4u.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402152357.25751.earny@net4u.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <200402152252.17301.earny@net4u.de> <1076884158.6959.105.camel@gaston>
	 <200402152357.25751.earny@net4u.de>
Content-Type: text/plain
Message-Id: <1076886481.6960.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 10:08:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, it does not work with the old driver. These are new PC's, never tried a 
> kernel older than 2.6.2. These are not yet really in 'production', so if 
> you want me to install an older kernel, no problem: Today if have no 
> problem with that.
> 
> If i enable VESA VGA, everything works. If i enable ATI Radeon (old or new) 
> the screen is blank, but the monitor shows valid freqencies. If i switch 
> to X, no problems, everything works as espected.
> 
> dmesg/config attached

It couldn't mmap the framebuffer, the problem is that you have run out
of kernel virtual space. I'll try to find a workaround, but in the
meantime, you need to change the lowmem/highmem ratio.

Ben.


