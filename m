Return-Path: <linux-kernel-owner+w=401wt.eu-S932100AbXAPAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbXAPAXL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbXAPAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:23:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15879 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100AbXAPAXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:23:10 -0500
Date: Tue, 16 Jan 2007 11:23:36 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070116002336.GB4067@kernel.dk>
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org> <45AAE635.8090308@shaw.ca> <20070115025319.GC4516@kernel.dk> <45AB84D8.3020507@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AB84D8.3020507@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15 2007, Jeff Garzik wrote:
> Jens Axboe wrote:
> >I'd be surprised if the device would not obey the 7 second timeout rule
> >that seems to be set in stone and not allow more dirty in-drive cache
> >than it could flush out in approximately that time.
> 
> AFAIK Windows flush-cache timeout is 30 seconds, not 7 as with other 
> commands...

Ok, 7 seconds for FLUSH_CACHE would have been nice for us too though, as
it would pretty much guarentee lower latencies for random writes and
write back caching. The concern is the barrier code, of course. I guess
I should do some timings on potential worst case patterns some day. Alan
may have done that sometime in the past, iirc.

-- 
Jens Axboe

