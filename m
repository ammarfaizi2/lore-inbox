Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWARStl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWARStl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWARStl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:49:41 -0500
Received: from palrel10.hp.com ([156.153.255.245]:33994 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1030275AbWARStk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:49:40 -0500
Date: Wed, 18 Jan 2006 10:49:45 -0800
From: Grant Grundler <iod00d@hp.com>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/5] [RFC] Infiniband: connection	abstraction
Message-ID: <20060118184945.GG6818@esmail.cup.hp.com>
References: <ORSMSX401yEXUIEAOeI00000043@orsmsx401.amr.corp.intel.com> <adar775wnfi.fsf@cisco.com> <43CE8695.9080401@ichips.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE8695.9080401@ichips.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:19:01AM -0800, Sean Hefty wrote:
> Roland Dreier wrote:
> > > +	UCMA_MAX_BACKLOG	= 128
> >
> >Is there any reason that we might want to make this a tunable?  Maybe
> >as a module parameter that's writable in sysfs...
> 
> There's no reason not to make this tunable.

Yes, there are reasons to NOT make something a tunable:
o increases system complexity (admin)
o increases the amount of documentation (learning curve)
o increases test matrix/cost (devel/support cost)
o generally hurts performance (var vs a constant of the same value)

Any reason to make something a tunable has to compensate
for the above drawbacks. An answer to Roland's question
is a reasonable prerequisite if someone wants add a tunable.

IB doesn't have the much in /sys/class/infiniband* or module parameters
and I think that's a Good Thing.

grant
