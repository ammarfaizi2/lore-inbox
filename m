Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752144AbWCJAp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbWCJAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWCJAp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:45:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43694
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752134AbWCJApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:45:23 -0500
Date: Thu, 9 Mar 2006 16:45:05 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060310004505.GB17050@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> <ada8xrjfbd8.fsf@cisco.com> <1141948367.10693.53.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141948367.10693.53.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:52:47PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 15:26 -0800, Roland Dreier wrote:
> 
> > Similarly what protects against another process opening the device
> > right after the ipath_sma_alive = 0 setting, but before you do all the
> > cleanup that's after that?
> 
> This is fixed by the stuff I just did in response to your earlier
> message.
> 
> > And what protects against a hot unplug of a device after the test of s
> > against ipath_max?
> 
> We don't support hotplugged devices at the moment.

Why not?  Your cards can't be placed in a machine that supports PCI
Hotplug (or PCI-E hotplug)?  You can't really tell users that (no matter
how often I have wished I could...)

thanks,

greg k-h
