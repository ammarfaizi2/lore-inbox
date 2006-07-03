Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWGCXTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGCXTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWGCXTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:19:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:43149 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932067AbWGCXTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:19:47 -0400
Date: Mon, 3 Jul 2006 16:16:10 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] change netdevice to use struct device instead of struct class_device
Message-ID: <20060703231610.GA18352@kroah.com>
References: <20060703224719.GA14176@kroah.com> <44A9A345.8040706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A9A345.8040706@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 07:07:49PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >I have a patch here that converts the network device structure to use
> >the struct device instead of struct class_device structure.  It's a bit
> >too big to post here, so it's at:
> >	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/network-class_device-to-device.patch
> 
> So....  this is a userspace ABI change, then?

No, not really.  According to Documentation/ABI/testing/sysfs-class all
code that uses /sys/class/foo/ needs to be able to handle the fact that
those entries might be symlinks and not just directories.  Everything
that I know of already works properly because the input layer has had
symlinks in /sys/class/input for quite some time now.

Do you know of any tools that use /sys/class/net/ that can not handle
symlinks there?  I've been running this on my boxes for about a week now
with no noticeable issues.  Renaming interfaces works just fine too.

thanks,

greg k-h
