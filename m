Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWCJGlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWCJGlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 01:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWCJGlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 01:41:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:34448 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752082AbWCJGlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 01:41:11 -0500
Date: Thu, 9 Mar 2006 22:37:24 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
Message-ID: <20060310063724.GB30968@suse.de>
References: <patchbomb.1141950930@eng-12.pathscale.com> <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com> <20060310011106.GD9945@suse.de> <1141967377.14517.32.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141967377.14517.32.camel@camp4.serpentine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:09:37PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 17:11 -0800, Greg KH wrote:
> 
> > These two files sure do show a lot of different stuff, all in a
> > predefined structure for a single file.  Please break them up into the
> > different individual files please.
> 
> The problem is that I want them to be presented together.  They look
> like a pile of different stuff, but they're actually Infiniband NodeInfo
> and PortInfo structures.  And yes, they are that ugly.

Then why not just have a bunch of different files for the different
things, and then a simple shell script to grab them all and put them
together however you want.

The main issue is that if you create a sysfs file like this, and then in
3 months realize that you need to change one of those characters to
be something else, you are in big trouble...

> These files fall into the same categories as the atomic_counters and
> atomic_snapshots files you raised objections to earlier; it actually
> makes sense to look at them as a whole, not their constituent parts.

Sure, lots of different files can be combined by a script into a whole.

> In the earlier round of review, people suggested that I use netlink for
> stuff like this, but I quickly decided I'd rather gnaw my leg off than
> use the netlink API.

Just because you don't want to use it doesn't mean it isn't the proper
tool...

thanks,

greg k-h
