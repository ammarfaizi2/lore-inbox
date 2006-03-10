Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWCJBEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWCJBEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWCJBEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:04:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4746 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1422663AbWCJBEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:04:20 -0500
Date: Thu, 9 Mar 2006 17:04:03 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060310010403.GC9945@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> <ada8xrjfbd8.fsf@cisco.com> <1141948367.10693.53.camel@serpentine.pathscale.com> <20060310004505.GB17050@suse.de> <1141951725.10693.88.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141951725.10693.88.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 04:48:45PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 16:45 -0800, Greg KH wrote:
> 
> > > We don't support hotplugged devices at the moment.
> > 
> > Why not?  Your cards can't be placed in a machine that supports PCI
> > Hotplug (or PCI-E hotplug)?
> 
> No, the driver and userspace code doesn't support it yet.  That's all.
> 
> > You can't really tell users that (no matter
> > how often I have wished I could...)
> 
> I don't expect this to be a practical problem.  We're planning to add
> hotplug support to the driver once we have some cycles free.

Ugh, that means it's never going to be there.

All new PCI drivers have the requirement that they work properly in
hotplug systems, as they should follow the PCI core api.  If not, odds
are they will not be accepted into the tree :(

thanks,

greg k-h
