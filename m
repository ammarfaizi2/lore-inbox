Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWGAW4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWGAW4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGAW4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:56:41 -0400
Received: from havoc.gtf.org ([69.61.125.42]:37589 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751442AbWGAW4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:56:40 -0400
Date: Sat, 1 Jul 2006 18:56:39 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Neil Brown <neilb@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Grant Wilson <grant.wilson@zen.co.uk>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-ID: <20060701225639.GC12703@havoc.gtf.org>
References: <20060701033524.3c478698.akpm@osdl.org> <20060701142419.GB28750@tlg.swandive.local> <20060701143047.b3975472.akpm@osdl.org> <1151792765.3438.30.camel@mulgrave.il.steeleye.com> <17574.63484.261979.866512@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17574.63484.261979.866512@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 08:32:28AM +1000, Neil Brown wrote:
> The problem seems to be simply that on some hardware at least,
> BIO_RW_BARRIER writes result in an EIO.  Don't know why yet.

Could be that <whatever device> is choking on FLUSH CACHE (ATA)
or SYNCHRONIZE CACHE (SCSI).

That's one possible reason why EIO may result from a barrier...

	Jeff



