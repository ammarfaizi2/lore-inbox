Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEOX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEOX3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEOX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:29:47 -0400
Received: from palrel10.hp.com ([156.153.255.245]:48289 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750769AbWEOX3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:29:46 -0400
Date: Mon, 15 May 2006 16:30:49 -0700
From: Grant Grundler <iod00d@hp.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Grant Grundler <iod00d@hp.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
Message-ID: <20060515233049.GM29082@esmail.cup.hp.com>
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com> <adad5efuw1o.fsf@cisco.com> <1147728081.2773.25.camel@chalcedony.pathscale.com> <adar72vrn8y.fsf@cisco.com> <20060515231342.GK29082@esmail.cup.hp.com> <ada1wuuswte.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada1wuuswte.fsf@cisco.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 04:16:45PM -0700, Roland Dreier wrote:
>     Grant> Or figure out which openib.org interface has to change so
>     Grant> the original virt addresses that were registered/handed to
>     Grant> the ULP are passed down to the low level interface driver
>     Grant> too.  Seems like a more obvious way to fix the problem.
>     Grant> Someone did suggest this already, right?
> 
> It's been suggested many times, but no one ever comes up with a way to
> handle the fact that RDMA means that addresses come from remote
> systems as well as being passed in through an API.

Aren't remote addresses handled differently than local ones?
ULP has to map local addresses.
We can't map remote ones (remote host maps it).
The ULP must know the difference and can tell the lower level
driver which is which.

Sorry, I hope my ignorance of RDMA isn't getting in the way again.

thanks,
grant
