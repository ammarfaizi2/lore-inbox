Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWIKUC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWIKUC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWIKUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:02:55 -0400
Received: from brick.kernel.dk ([62.242.22.158]:7279 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965020AbWIKUCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:02:55 -0400
Date: Mon, 11 Sep 2006 22:01:12 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
Message-ID: <20060911200112.GA10409@kernel.dk>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain> <20060911153706.GE4955@suse.de> <450585DF.1080500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450585DF.1080500@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Mon, Sep 11 2006, Alan Cox wrote:
> >>We could perhaps do it by ATA version - 255 for ATA < 3 256 for ATA 3+,
> >
> >Might be sane, yep.
> 
> 
> Since we're doing this just for paranoia, and nobody can actually 
> produce a problem case, it's safer just to hardcode 255 for all cases, 
> than try to come up with a hueristic that won't be exercised for another 
> decade...

If it's a real problem, yes I agree. If it's just hand waving, then no.
The fact that 2.4 and 2.6 has been using 256 for ages really tells me
that no one has been affected by this. The SUSE bugzilla certainly
hasn't seen any entries on it either.

> Most new disks are lba48 anyway.  (should we use 65535 there too???)

Heh, good question. Given that the limit is so high, we might as well
just use 65535. It's not nearly as sensitive as the lba28 case.

-- 
Jens Axboe

