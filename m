Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVBQWX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVBQWX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBQWX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:23:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:34791 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261172AbVBQWXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:23:21 -0500
Date: Thu, 17 Feb 2005 13:35:31 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add "bus" symlink to class/block devices
Message-ID: <20050217213531.GB15836@kroah.com>
References: <20050215205344.GA1207@vrfy.org> <20050215220406.GA1419@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215220406.GA1419@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 11:04:06PM +0100, Kay Sievers wrote:
> On Tue, Feb 15, 2005 at 09:53:44PM +0100, Kay Sievers wrote:
> > Add a "bus" symlink to the class and block devices, just like the "driver"
> > and "device" links. This may be a huge speed gain for e.g. udev to determine
> > the bus value of a device, as we currently need to do a brute-force scan in
> > /sys/bus/* to find this value.
> 
> Hmm, while playing around with it, I think we should create the "bus"
> link on the physical device on not on the class device.
> 
> Also the current "driver" link at the class device should be removed,
> cause class devices don't have a driver. Block devices never had this
> misleading symlink.
> 
> >From the class device we point with the "device" link to the physical
> device, and only the physical device should have the "driver" and the
> "bus" link, as it represents the real relationship.

Applied, thanks,

greg k-h
