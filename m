Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVBAKuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVBAKuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVBAKuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:50:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36241 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261979AbVBAKty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:49:54 -0500
Date: Tue, 1 Feb 2005 11:49:49 +0100
From: Jens Axboe <axboe@suse.de>
To: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Strange vmstat output. 2.6.10 Scheduler?
Message-ID: <20050201104949.GM4137@suse.de>
References: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro> <20050201102638.GJ4137@suse.de> <Pine.LNX.4.62.0502011236100.26221@webhosting.rdsbv.ro> <20050201104214.GK4137@suse.de> <Pine.LNX.4.62.0502011243270.26221@webhosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502011243270.26221@webhosting.rdsbv.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01 2005, Catalin(ux aka Dino) BOIE wrote:
> >Well then that is why, the writes are taking quite a while to reach the
> >platter. Nothing is wrong, the drive is just slow :-)
> >
> >-- 
> >Jens Axboe
> 
> I don't know what to say because sometimes works really good.
> bi=20000.

The vmstat you showed had bi and bo at the same time, so it's not so
surprising if bi often suffers if it is seeking all over the map to
write out the big chunk submitted.

How does it look with write cache enabled?

> I'm fighting with this problem for 1 month now and I realy tried to 
> resolve the problem.

If postgres uses fsync() properly, you should be safe with write cache
enabled.

> P.S. I tried also with cfq and see no improvement.

Not surprising, there's not much the io scheduler can do for you here.

-- 
Jens Axboe

