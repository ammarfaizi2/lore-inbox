Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWANXns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWANXns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 18:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWANXns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 18:43:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28615 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750955AbWANXnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 18:43:47 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Dan Williams <dcbw@redhat.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060113221935.GJ16166@tuxdriver.com>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213011.GE16166@tuxdriver.com>
	 <20060113221935.GJ16166@tuxdriver.com>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 18:41:56 -0500
Message-Id: <1137282117.27849.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 17:19 -0500, John W. Linville wrote:
> Configuration
> =============
> 
> Configuration seems to be coalescing around netlink.  Among other
> things, this technology provides for muliticast requests and
> asynchronous event notification.
> 
> The kernel should provide generic handlers for netlink
> configuraion messages, and there should be a per-device 80211_ops
> (wireless_ops? akin to ethtool_ops) structure for drivers to
> populate appropriately.

One other thing: capability.  It's not enough to be able to configure
the device, user-space tools also have to know what the device is
capable of before they try touching it.  Ie, which ciphers, protocols,
channels, etc.  Similar to the IWRANGE ioctl that there is now.  Half
the problem now is that you can't reliably tell what drivers support
which features, or how much they support a particular feature.  Think of
ethernet devices and whether or not they support carrier detection,
there's absolutely no way to tell that now (unless they respond to
ethtool or MII, and some cards freeze if you touch them with MII too
often).

Dan


