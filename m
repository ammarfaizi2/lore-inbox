Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWASSuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWASSuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWASSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:50:20 -0500
Received: from mx.pathscale.com ([64.160.42.68]:14058 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161208AbWASSuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:50:18 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	 <1137688158.3693.29.camel@serpentine.pathscale.com>
	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 19 Jan 2006 10:50:11 -0800
Message-Id: <1137696611.3693.63.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 11:20 -0700, Eric W. Biederman wrote:

> For high performance
> non-IP targeted networking cards you aren't doing anything terribly
> exotic.

True.

>   Could you please detail why you can't use the IB/rdma
> whatever helper layer, is insufficient to do what you need.  

There really isn't an RDMA helper layer.  The fact that the IB headers
live in include/rdma is, as best as I can tell, an artefact of Roland
being accommodating to someone's suggestion when he was going through
the same process with the IB tree as we are now with our driver.

> Right now it largely seems to be a chicken and the egg problem.
> There is a large portion of the HPC community that doesn't believe
> they are interesting to the rest of the world or that the rest of
> the world is interesting to them so they do they own thing leading
> to support problems.

I can't solve that problem.  If other vendors don't want to pony up
their driver source and take the same kinds of slings and arrows I'm
doing, I'm not going to do the work to provide them with a generic set
of abstractions to use in their out-of-tree or proprietary drivers.

> Which is the RDMA thing.  And looking at the code and I don't see how

Your sentence ends in the middle.

> >> Again this is a generic problem, and the generic interfaces are broken
> >> if you can't do this.

> But SIOCSIFFLAGS is not implemented by a driver.

I can't square these two statements.  Can you indicate what you might
have been talking about, if not SIOCSIFFLAGS?

> That helper really needs to export those counters
> to sysfs as well as ethtool but the support already exists for more
> typical networking. 

I know about the ethtool interfaces, but we implement only a tiny
fraction of the stuff that is relevant to ethtool at this level of
abstraction.

> Is it the stack that is byzantine?  Or the interface too it.

Both.

	<b

