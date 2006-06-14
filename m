Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWFNAbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWFNAbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWFNAbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:31:14 -0400
Received: from gw.openss7.com ([142.179.199.224]:60082 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932374AbWFNAbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:31:13 -0400
Date: Tue, 13 Jun 2006 18:31:12 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060613183112.B8460@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Chase Venters <chase.venters@clientec.com>,
	Daniel Phillips <phillips@google.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <448F3C83.9080606@google.com> <20060613164714.B7232@openss7.org> <200606131859.43695.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606131859.43695.chase.venters@clientec.com>; from chase.venters@clientec.com on Tue, Jun 13, 2006 at 06:59:21PM -0500
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase,

On Tue, 13 Jun 2006, Chase Venters wrote:
> 
> It depends on what you mean by "pure-BSD". If you're talking about the 
> 4-clause license with the advertising clause, then you are correct. Otherwise 
> (IANAL) but my understanding is that BSD code can even be relicensed GPL by a 
> third party contribution (though it is perhaps kind to ask for relicensing 
> permission anyway).

Yes, and the long list of open source licenses listed on the FSF website
as incompatible with the GPL.

> Then would offering a 'stable API in disguise' not be a disaster and an 
> irritation to these people? If the kernel doesn't specify that an in-kernel 
> interface is stable, then there is no reason to expect it to be. It might not 
> change, but there won't be too much sympathy for out-of-tree users if it 
> does. The kernel comes with big warnings about the lack of a stable API for a 
> reason.

In fact most core kernel facilities (spin lock, memory caches, character and
block device interface, even core file system) have had a very stable API
(way back to early 2.4 kernels).  An in fact most of them are derived from
some variant or precursor to UNIX.  For example, memory caches are a Sun
Solaris concept.

It is the lack of an ABI that is most frustrating to these users.

> 
> > Another thing to consider is that the first step for many organizations in
> > opening a driver under GPL is to release a proprietary module that at least
> > first works.  
> 
> If the driver is an old-tech Linux port, then it seems there isn't too much 
> stopping them from doing this today (aside from the fact that some people 
> think proprietary modules are murky anyway). In this case, we don't want a 
> stable API/ABI, because then we leave them with little incentive to open the 
> code.

"old-tech"?  No, these are high-tech drivers supported by commercial RTOS,
from which Linux stands to benefit.  And, by not allowing these organizations
to take the first step (generate a workable Linux driver) such a policy
provides them little incentive to ever move the driver to Linux, and cuts
them off from opening it.

I don't think that it is fair to say that an unstable API/ABI, in of itself,
provides an incentive to open an existing proprietary driver.

> We're not as perfect as I wish we were. But the lack of stable API (dead 
> horse) is something that is fairly well established and understood. I think 
> most people feel that the cost-benefit analysis, for Linux anyway, strongly 
> favors no stable API.

Well, the lack of a stable ABI is well known.  The API is largely stable (but
not sacrosanctly so) for the major reason that changing it within a large
code base is difficult and error prone at best.
