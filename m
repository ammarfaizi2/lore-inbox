Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVCVE6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVCVE6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVCVE0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:26:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:29920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262370AbVCVETm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:19:42 -0500
Date: Mon, 21 Mar 2005 20:03:47 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: current linus bk, error mounting root
Message-ID: <20050322040346.GD13745@kroah.com>
References: <9e47339105030909031486744f@mail.gmail.com> <20050321154131.30616ed0.akpm@osdl.org> <9e473391050321155735fc506d@mail.gmail.com> <20050321161925.76c37a7f.akpm@osdl.org> <20050322003807.GA10180@kroah.com> <20050321164318.04a5dc82.akpm@osdl.org> <9e473391050321165338208c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050321165338208c66@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 07:53:15PM -0500, Jon Smirl wrote:
> Here is fedora's initrd nash script from my system. I modified it with
> the sleep lines.
> 
> It already is creating the /dev node with 'mkrootdev /dev/root'
> I don't think udev is even running yet. Something else is causing this.
> 
> echo "Loading libata.ko module"
> insmod /lib/libata.ko
> echo "Loading ata_piix.ko module"
> insmod /lib/ata_piix.ko
> echo "Loading raid1.ko module"
> insmod /lib/raid1.ko
> /sbin/udevstart
> raidautorun /dev/md0
> >>>echo Sleep 1
> >>>sleep 1
> echo Creating root device
> mkrootdev /dev/root
> umount /sys

Care to look at what mkrootdev does?

thanks,

greg k-h
