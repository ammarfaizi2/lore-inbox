Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTESQUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTESQUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:20:32 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8964 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261580AbTESQUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:20:31 -0400
Date: Mon, 19 May 2003 17:33:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Corey Minyard <cminyard@mvista.com>,
       linux.nics@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
Message-ID: <20030519173323.A22670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Corey Minyard <cminyard@mvista.com>, linux.nics@intel.com,
	LKML <linux-kernel@vger.kernel.org>
References: <3EC901BB.8040100@mvista.com> <20030519171714.A22487@infradead.org> <20030519163052.GB17048@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030519163052.GB17048@gtf.org>; from jgarzik@pobox.com on Mon, May 19, 2003 at 12:30:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:30:52PM -0400, Jeff Garzik wrote:
> > 
> > Don't do this. 2.5 has the module_parame stuff that works for both
> > static and modular drivers.  Just convert e100 to it.
> 
> ...which totally screws people trying to keep 2.4 and 2.5
> sources as close as possible.

So what?  It's not that we APIs don't change under Linux.

> If all modules do not require new module_param changes, then logically,
> e100 does not either.  And e100 has a better argument than most against
> such changes.

Again, we don't convert old drivers just for the sake of it.  But
instead of adding such horrible cruft Corey did it should just use the
proper API.
