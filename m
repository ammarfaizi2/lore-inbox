Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTLWPbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTLWPbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:31:46 -0500
Received: from havoc.gtf.org ([63.247.75.124]:3019 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261270AbTLWPbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:31:44 -0500
Date: Tue, 23 Dec 2003 10:31:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Christophe Saout <christophe@saout.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031223153143.GA28690@gtf.org>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <20031223131355.A6864@infradead.org> <1072186582.4111.46.camel@leto.cs.pocnet.net> <20031223151545.GE476@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223151545.GE476@reti>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 03:15:45PM +0000, Joe Thornber wrote:
> On Tue, Dec 23, 2003 at 02:36:22PM +0100, Christophe Saout wrote:
> > Am Di, den 23.12.2003 schrieb Christoph Hellwig um 14:13:
> > 
> > > Please include driver-private headers after kernel headers.
> 
> I tend to do things this way round to ensure that the private headers
> have correctly included all that they need, rather than relying on the
> accidental inclusion of a standard header.

I agree w/ Christoph...  overly defensive programming like this just
creates a new class of programmer errors, doesn't really solve anything.
It's standard Linux kernel style, and making code look like all other
code has benefits in review and debugging.  Finally, the programmer
should be paying attention to what kernel APIs he/she uses, and add
headers accordingly.


> > > > +static struct dm_daemon _kcryptd;
> > > 
> > > Again, rather strange naming..
> > 
> > This was done to be consistent with the other device-mapper code. I can
> > change it though.
> 
> Kernel CRYPT Daemon
> 
> In the same way we have a kmirrord, kcopyd etc.  I'm happy with the
> name.

Not sure, but I think he meant the unneeded "_" prefix.

	Jeff



