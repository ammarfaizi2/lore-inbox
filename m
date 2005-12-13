Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVLMSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVLMSgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVLMSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:36:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54796 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750717AbVLMSgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:36:53 -0500
Date: Tue, 13 Dec 2005 19:38:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [DOC PATCH] block/stat.txt
Message-ID: <20051213183821.GP12024@suse.de>
References: <20051212124553.GW26185@suse.de> <20051213084121.GF26568@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213084121.GF26568@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13 2005, Andy Isaacson wrote:
> > > +in_flight
> > > +=========
> > > +
> > > +This value counts the number of currently-queued I/O requests.
> > 
> > A little confusing - it's the number of in flight io at the
> > driver/device end, that is after the block layer. One could read the
> > above as total in flight (total queued in the queue for the device),
> > which is a very different number.
> 
> I wrote from misunderstanding, so it's no suprise what I wrote was
> wrong. :)  Is "number of requests in the queue" available somewhere?

Nope, it's only accounted internally I'm afraid. It's somewhere between
0 and ~ /sys/block/<dev>/queue/nr_requests (it can go a little higher
than this value, hence approximately).

> How does this sound instead of the above?
> 
> +in_flight
> +=========
> +
> +This value counts the number of I/O requests that have been issued to
> +the device driver but have not yet completed.  It does not include I/O
> +requests that are in the queue but not yet issued to the device driver.

That is perfect, thanks.

-- 
Jens Axboe

