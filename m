Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWBVRxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWBVRxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWBVRxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:53:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:53209
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161149AbWBVRxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:53:14 -0500
Date: Wed, 22 Feb 2006 09:53:22 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev/uevent
Message-ID: <20060222175322.GA11733@kroah.com>
References: <20060221234807.GA27776@rescue.iwoars.net> <20060222001707.GA31611@kroah.com> <20060222083751.GA12873@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222083751.GA12873@rescue.iwoars.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:37:51AM +0100, Thomas Ogrisegg wrote:
> On Tue, Feb 21, 2006 at 04:17:07PM -0800, Greg KH wrote:
> > On Wed, Feb 22, 2006 at 12:48:07AM +0100, Thomas Ogrisegg wrote:
> > > This patch adds userspace notification for register/unregister and
> > > plug/unplug events for netdevices. It calls kobject_uevent to let
> > > userspace applications (via netlink-interface) know that e.g. the
> > > ethernet-cable was plugged in (or plugged out) and thus the ethernet
> > > device may have to be reconfigured.
> [...]
> > > Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
> > Hm, I thought ethtool and netlink already handled this kind of event
> > just fine.  Why would you add a uevent too?
> 
> What do you mean with "ethtool and netlink"? At least the current
> release of ethtool does not seem to have any netlink support.

That should have been "or", sorry.

> Is there currently any possibility for a program to get notified when
> a netdevice link becomes ready (or the opposite)? I don't see any interface
> (besides polling /sys).

Try asking on the netdev mailing list, I'm sure it must come up there a
lot.

thanks,

greg k-h
