Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbTESQ1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTESQ1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:27:22 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:33674
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S261617AbTESQ1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:27:21 -0400
Date: Mon, 19 May 2003 12:40:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, Corey Minyard <cminyard@mvista.com>,
       linux.nics@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
Message-ID: <20030519164019.GC17048@gtf.org>
References: <3EC901BB.8040100@mvista.com> <20030519171714.A22487@infradead.org> <20030519163052.GB17048@gtf.org> <20030519173323.A22670@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519173323.A22670@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 05:33:23PM +0100, Christoph Hellwig wrote:
> On Mon, May 19, 2003 at 12:30:52PM -0400, Jeff Garzik wrote:
> > > 
> > > Don't do this. 2.5 has the module_parame stuff that works for both
> > > static and modular drivers.  Just convert e100 to it.
> > 
> > ...which totally screws people trying to keep 2.4 and 2.5
> > sources as close as possible.
> 
> So what?  It's not that we APIs don't change under Linux.

If you look carefully, source back-compatibility has been preserved
for network drivers.  Most API changes are accepted without comment
because they are easily made back-compatible.  The module_param API
breaks that.

Network driver-land is different from SCSI-land, where the amount of 2.5
differences is so high one more change doesn't make a difference.


> > If all modules do not require new module_param changes, then logically,
> > e100 does not either.  And e100 has a better argument than most against
> > such changes.
> 
> Again, we don't convert old drivers just for the sake of it.  But

Well...


> instead of adding such horrible cruft Corey did it should just use the
> proper API.

An API already exists, and it is source compatible between 2.4 and 2.5:
ethX=.... on the kernel command line.

The proper patch would pick up options from there.

	Jeff



