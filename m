Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265235AbTLaT1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTLaT1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:27:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:40083 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265235AbTLaT1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:27:38 -0500
Date: Wed, 31 Dec 2003 11:23:06 -0800
From: Greg KH <greg@kroah.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20031231192306.GG25389@kroah.com>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AbWgJ-0000aT-00@neptune.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 04:05:59AM +0100, Pascal Schmidt wrote:
> On Wed, 31 Dec 2003 01:40:09 +0100, you wrote in linux.kernel:
> 
> >     2) udev does not care about the major/minor number schemes.  If the
> >        kernel tomorrow switches to randomly assign major and minor numbers
> >        to different devices, it would work just fine (this is exactly
> >        what I am proposing to do in 2.7...)
> 
> Why? I want to keep my static device files in /dev. I don't even have
> hotpluggable devices, and many months do pass before even one piece
> of hardware gets changed (in which case I know what I have to do).
> I don't want to eat any overhead or run any daemons or hotplug agents.

You would not have any "extra" overhead if you don't add any new devices
to your system.  udev only runs when /sbin/hotplug runs.  As for extra
space on your disk, this email thread is almost as big as the udev
binary is :)

> What benefit would there be in "random" numbers? More compressed number
> space by giving out numbers sequentially?

Yes.

> Or less having to work with the numbers because they become just
> cookies and never need to be inspected except in very small parts of
> the kernel?

That is already happening today in the kernel.  

And 2.8 will probably have the "random number" assignment be a compile
option, depending on the maturity of udev.  We'll just have to see how
it works out.

thanks,

greg k-h
