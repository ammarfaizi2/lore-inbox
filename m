Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWAPOKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWAPOKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWAPOKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:10:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:273 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750801AbWAPOKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:10:14 -0500
Date: Mon, 16 Jan 2006 15:12:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
       jejb <james.bottomley@steeleye.com>
Subject: Re: [PATCH/RFC] SATA in its own config menu
Message-ID: <20060116141203.GD3945@suse.de>
References: <20060115135728.7b13996d.rdunlap@xenotime.net> <20060116121328.GA12871@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116121328.GA12871@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2006, Christoph Hellwig wrote:
> On Sun, Jan 15, 2006 at 01:57:28PM -0800, Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Put SATA into its own menu.  Reason:  using SCSI is an
> > implementation detail that users need not know about.
> > 
> > Enabling SATA selects SCSI since SATA uses SCSI as a function
> > library supplier.  It also enables BLK_DEV_SD since that is
> > what SATA drives look like in Linux.
> 
> we'll soon support (or already do?) support sata atapi, when this
> won't be true anymore.  Please never select scsi upper drivers from
> lower drivers, this independence is the whole point of the layered
> architecture.

It's already possible, and besides you could be using sg with your SATA
devices stand-alone if you so wanted. So this selection is indeed a
nonsensical one, it's an invalid dependency.

-- 
Jens Axboe

