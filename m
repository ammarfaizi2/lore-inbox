Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbWBVARF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWBVARF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWBVARF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:17:05 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:56770
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161272AbWBVARE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:17:04 -0500
Date: Tue, 21 Feb 2006 16:17:07 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev/uevent
Message-ID: <20060222001707.GA31611@kroah.com>
References: <20060221234807.GA27776@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221234807.GA27776@rescue.iwoars.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:48:07AM +0100, Thomas Ogrisegg wrote:
> This patch adds userspace notification for register/unregister and
> plug/unplug events for netdevices. It calls kobject_uevent to let
> userspace applications (via netlink-interface) know that e.g. the
> ethernet-cable was plugged in (or plugged out) and thus the ethernet
> device may have to be reconfigured.
> 
> Common scenario:
> A userspace application is notified that the ethernet cable was plugged
> out and later plugged in. It now checks whether the ethernet card is now
> connected to an other network and reassigns it's IP-Address via DHCP.
> 
> BTW: Of course I know that the constant KOBJ_ONLINE actually has an other
> meaning than what I used it for. I just didn't want to introduce a new
> constant and it just seems perfect for my purpose.
> 
> Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>

Hm, I thought ethtool and netlink already handled this kind of event
just fine.  Why would you add a uevent too?

thanks,

greg k-h
