Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbUKKAU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUKKAU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUKKAUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:20:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:49848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262167AbUKKATi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:19:38 -0500
Date: Wed, 10 Nov 2004 16:19:11 -0800
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Alexandre Costa <alebyte@gmail.com>,
       linux-os@analogic.com
Subject: Re: DEVFS_FS
Message-ID: <20041111001909.GA18269@kroah.com>
References: <Pine.LNX.4.61.0411101544080.19616@chaos.analogic.com> <543d091304111013035563e7f6@mail.gmail.com> <200411101906.37328.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411101906.37328.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 07:06:37PM -0500, Gene Heskett wrote:
> On Wednesday 10 November 2004 16:03, Alexandre Costa wrote:
> >On Wed, 10 Nov 2004 15:46:06 -0500 (EST), linux-os
> >
> ><linux-os@chaos.analogic.com> wrote:
> >> What is the approved substitute for DEVFS_FS that is marked
> >> obsolete?
> >
> >udev
> >http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html
> 
> Humm, I'm not sure I'm entirely happy with that choice.  I have an 
> FC3RC5 install on an old P-II running at 233mhz, and the udev start 
> in the bootup is the slowest single thing to get started by an order 
> of magnitude.
> 
> Can someone tell me a good reason udev wastes as much time as the post 
> does checking 383 megs of memory, which is very nearly a minute even 
> just for udev?

It's all up to the rules you are using for udev.  If you have udev rules
that call out to scripts for every device (like I think the SuSE default
install does), udevstart can take a long time.

If you don't have any external dependancies, udevstart is fast.

> If its to be used, its got to speed itself up, a LOT!.

Please post what version of udev you are using, and what your udev rules
file looks like.

thanks,

greg k-h
