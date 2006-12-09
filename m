Return-Path: <linux-kernel-owner+w=401wt.eu-S1759291AbWLIHr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291AbWLIHr1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 02:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759294AbWLIHr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 02:47:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49494 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759291AbWLIHr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 02:47:26 -0500
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
From: Matt Helsley <matthltc@us.ibm.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Erik Jacobson <erikj@sgi.com>, guillaume.thouvenin@bull.net,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061208192027.18a1e708.zaitcev@redhat.com>
References: <20061207232213.GA29340@sgi.com>
	 <20061208192027.18a1e708.zaitcev@redhat.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 08 Dec 2006 23:47:22 -0800
Message-Id: <1165650442.24721.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 19:20 -0800, Pete Zaitcev wrote:
> On Thu, 7 Dec 2006 17:22:13 -0600, Erik Jacobson <erikj@sgi.com> wrote:

Erik,

	Thanks for cc'ing me on this patch.

> > Here, we just adjust how the variables are declared and use memcopy to
> > avoid the error messages.
> > -	ev->timestamp_ns = timespec_to_ns(&ts);
> > +	ev.timestamp_ns = timespec_to_ns(&ts);
> 
> Please try to declare u64 timestamp_ns, then copy it into the *ev
> instead of copying whole *ev. This ought to fix the problem if
> buffer[] ends aligned to 32 bits or better.

Yes, I like this suggestion.

> Also... Since Linus does not take patches in general off l-k anymore,
> you have to find whoever herds the connector and feed the patch through
> him/her.
> 
> -- Pete

	I contributed and continue to follow this particular connector (Evgeniy
Polyakov wrote the generic connector code). In the past I've given my
patches to Andrew Morton and requested inclusion in -mm -- that may be
the best route (Andrew?). I'd be happy to Ack a patch implementing
Pete's suggestion.

Cheers,
	-Matt Helsley

