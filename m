Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267196AbTGOLMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbTGOLMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:12:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267196AbTGOLMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:12:50 -0400
Date: Tue, 15 Jul 2003 13:27:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715112737.GQ833@suse.de>
References: <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <20030715052640.GY833@suse.de> <1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15 2003, Alan Cox wrote:
> On Maw, 2003-07-15 at 06:26, Jens Axboe wrote:
> > Sorry, but I think that is nonsense. This is the way we have always
> > worked. You just have to maintain a decent queue length still (like we
> > always have in 2.4) and there are no problems.
> 
> The memory pinning problem is still real - and always has been. It shows up
> best not on IDE disks but large slow media like magneto opticals where you
> can queue lots of I/O but you get 500K/second

Not the same thing. On slow media, like dvd-ram, what causes the problem
is that you can dirty basically all of the RAM in the system. That has
nothing to do with memory pinned in the request queue.

And that is still writes, not reads. Reads are pinned on the queue, so
very different case.

-- 
Jens Axboe

