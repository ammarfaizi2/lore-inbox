Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVJMM3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVJMM3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVJMM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 08:29:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751032AbVJMM3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 08:29:51 -0400
Date: Thu, 13 Oct 2005 14:30:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcin Owsiany <marcin@owsiany.pl>, linux-kernel@vger.kernel.org
Subject: Re: SCSI "asking for cache data failed"
Message-ID: <20051013123028.GE6603@suse.de>
References: <20051013104536.GA10525@kufelek> <1129208154.18635.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129208154.18635.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, Alan Cox wrote:
> On Iau, 2005-10-13 at 12:45 +0200, Marcin Owsiany wrote:
> > I'm wondering about the following messages, which appeared when I upgraded from
> > 2.4 to 2.6:
> > 
> > | sda: asking for cache data failed
> > | sda: assuming drive cache: write through
> > 
> > (a larger log snippet below)
> 
> The kernel asks the SCSI drive for its cache parameters. The AMI raid
> card sitting in the middle doesn't know how to handle this so this
> message occurs. It should be ok providing the raid card itself is
> handling the consistency correctly but check with your card vendor.

The assumption that sd makes might be a little on the risky side though,
would seem a lot safer to assume write back if you don't know the
policy. At least that wont bring surprises later on...

-- 
Jens Axboe

