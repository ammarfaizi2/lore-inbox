Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbULTWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbULTWxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbULTWul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:50:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:41126 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261671AbULTWuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:50:08 -0500
Date: Mon, 20 Dec 2004 14:49:50 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
Subject: Re: /sys/block vs. /sys/class/block
Message-ID: <20041220224950.GA21317@kroah.com>
References: <1103526532.5320.33.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103526532.5320.33.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 08:08:52AM +0100, Benjamin Herrenschmidt wrote:
> I'm trying to understand why we have /sys/block instead
> of /sys/class/block, and so far, I haven't found a single good argument
> justifying it... It just messes up the so far logical layout of sysfs
> for no apparent reason.

Because /sys/block happened before /sys/class did.  Al Viro converted
the block layer before I got the struct class stuff working properly
during 2.5.

And yes, I would like to convert the block layer to use the class stuff,
but for right now, I can't as class devices don't allow
sub-classes-devices, and getting to that work is _way_ down on my list
of things to do.

thanks,

greg k-h
