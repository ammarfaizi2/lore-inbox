Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUGTO22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUGTO22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUGTOYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:24:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63420 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265930AbUGTOVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:21:19 -0400
Date: Tue, 20 Jul 2004 10:21:41 -0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: [12/25] Merge pmdisk and swsusp
Message-ID: <20040720122141.GH1651@suse.de>
References: <Pine.LNX.4.50.0407171529530.22290-100000@monsoon.he.net> <20040718221653.GD31958@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718221653.GD31958@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19 2004, Pavel Machek wrote:
> Hi!
> 
> > +static void wait_io(void)
> > +{
> > +	while(atomic_read(&io_done))
> > +		io_schedule();
> > +}
> ...
> > +	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
> > +	wait_io();
> > + Done:
> > +	bio_put(bio);
> > +	return error;
> > +}
> 
> Perhaps it is worth it to inline wait_io?

Since it's not a fast path, does it matter?

-- 
Jens Axboe

