Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTESQRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTESQRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:17:55 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:16778
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S261564AbTESQRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:17:54 -0400
Date: Mon, 19 May 2003 12:30:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, Corey Minyard <cminyard@mvista.com>,
       linux.nics@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
Message-ID: <20030519163052.GB17048@gtf.org>
References: <3EC901BB.8040100@mvista.com> <20030519171714.A22487@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519171714.A22487@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 05:17:14PM +0100, Christoph Hellwig wrote:
> On Mon, May 19, 2003 at 11:09:31AM -0500, Corey Minyard wrote:
> > Annoyed by the fact that I could set configuration parameters for a
> > compiled-in e100 driver, I've added boot-line parameter parsing.  The
> > patch is attached.  It would be very helpful if this could be applied. 
> > This is relative to 2.5.68, but should be pretty portable.
> 
> Don't do this. 2.5 has the module_parame stuff that works for both
> static and modular drivers.  Just convert e100 to it.

...which totally screws people trying to keep 2.4 and 2.5
sources as close as possible.

If all modules do not require new module_param changes, then logically,
e100 does not either.  And e100 has a better argument than most against
such changes.

	Jeff



