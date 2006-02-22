Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWBVIhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWBVIhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWBVIhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:37:53 -0500
Received: from fnord.at ([217.160.110.113]:12556 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S932533AbWBVIhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:37:53 -0500
Date: Wed, 22 Feb 2006 09:37:51 +0100
From: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev/uevent
Message-ID: <20060222083751.GA12873@rescue.iwoars.net>
References: <20060221234807.GA27776@rescue.iwoars.net> <20060222001707.GA31611@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222001707.GA31611@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 04:17:07PM -0800, Greg KH wrote:
> On Wed, Feb 22, 2006 at 12:48:07AM +0100, Thomas Ogrisegg wrote:
> > This patch adds userspace notification for register/unregister and
> > plug/unplug events for netdevices. It calls kobject_uevent to let
> > userspace applications (via netlink-interface) know that e.g. the
> > ethernet-cable was plugged in (or plugged out) and thus the ethernet
> > device may have to be reconfigured.
[...]
> > Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
> Hm, I thought ethtool and netlink already handled this kind of event
> just fine.  Why would you add a uevent too?

What do you mean with "ethtool and netlink"? At least the current
release of ethtool does not seem to have any netlink support.

Is there currently any possibility for a program to get notified when
a netdevice link becomes ready (or the opposite)? I don't see any interface
(besides polling /sys).
