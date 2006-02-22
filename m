Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWBVRxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWBVRxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWBVRxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:53:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53378 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161146AbWBVRxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:53:33 -0500
Date: Wed, 22 Feb 2006 09:54:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev/uevent
Message-ID: <20060222175408.GA27645@sorel.sous-sol.org>
References: <20060221234807.GA27776@rescue.iwoars.net> <20060222001707.GA31611@kroah.com> <20060222083751.GA12873@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222083751.GA12873@rescue.iwoars.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Ogrisegg (tom-lkml@lkml.fnord.at) wrote:
> Is there currently any possibility for a program to get notified when
> a netdevice link becomes ready (or the opposite)? I don't see any interface
> (besides polling /sys).

Yes, there's a netlink socket that already communicates these changes.
Routing daemons typically consume this information.  The netdev notifier
chain should end up generating these events via rtmsg_ifinfo.

thanks,
-chris
