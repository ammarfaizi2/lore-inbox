Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVI2PXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVI2PXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVI2PXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:23:06 -0400
Received: from ns.firmix.at ([62.141.48.66]:16532 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932202AbVI2PXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:23:04 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Bernd Petrovitsch <bernd@firmix.at>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <433BFB1F.2020808@adaptec.com>
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>
	 <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>
	 <433BFB1F.2020808@adaptec.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 29 Sep 2005 17:17:12 +0200
Message-Id: <1128007032.11443.77.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 10:33 -0400, Luben Tuikov wrote:
[...]
> Linux _development_ needs to catch up to Linux _deployment_.

That is probably the root and single cause of quality problems in
companies: Deployment folks (read: sales) set the delivery date (and get
the bonus for selling) and the rest (read: tech folks) have to follow,
no matter what (and get the blame for being late and buggy).
Or why do you think that MSFT has such quite crappy software?

> Currently they are two different worlds.

ACK - in the commercial world (and the bigger the company the worse
because sales people are far more distant from the tech people).

[ software rewrite ]
> > Maybe it can simply coexist with another new subsystem. This is what
> 
> Now _this_ is a smart suggestion: it wouldn't break legacy hardware
> _and_ it would give Linux SCSI a fresh start.
>
> Next year, your new serverboard wouldn't have any of those old
> cumbersome storage chips to worry about.  It would have only one
> storage chip which could do SAS and SATA and that'd be that.
> Why would anyone need this fat, old semanticaly overloaded,
> SPI-centric SCSI Core?

Then submit your driver as a (separate) block device in parallel to the
existing SCSI subsystem. People will use it for/with other parts if it
makes sense (and you - as the maintainer - accept their patches). And in
a few years the "old" SCSI core fades out as legacy drives fade out (or
they will happily coexist forever).
The point is: If *you* want it that way, *you* must go that way (and do
not expect others to do it just that *you* get *your* driver merged).
You are the maintainer of the new stuff and (almost) everything will
work as you want.
It might not be the cleanest or most elegant solution in the world, but
if it works, who cares and why?
Where is now the real problem?
I can't see one.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

