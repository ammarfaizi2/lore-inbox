Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWIKPIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWIKPIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWIKPIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:08:00 -0400
Received: from brick.kernel.dk ([62.242.22.158]:51041 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932291AbWIKPH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:07:58 -0400
Date: Mon, 11 Sep 2006 17:06:15 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
Message-ID: <20060911150615.GB4955@suse.de>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157986974.23085.147.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11 2006, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 17:47 +0400, ysgrifennodd Sergei Shtylyov:
> >     It's not likely I'll be able to try it. But I'm absolutely sure that drive 
> > aborted the read commands with the sector count of 0 (i.e. 256 actually). The 
> > exact model was IBM DHEA-34331.
> 
> Several people reported this problem when we tried 256 years ago in
> drivers/ide. You might want to do 256 for SATA Jeff but please don't do
> 256 for PATA. Reading specs is too hard for some people ;)
> 
> Some drives abort the xfer, some just choked.

Ehm it's 256 now and it has been for a looong time. The few cases I've
seen where people claimed it broke, turned out to be something else.
I've still haven't seen a valid report on this.

It might sound obscure that 0 means 256 sectors, but it's really not a
hidden obscure fact - people do know. I'm all for being conservative
where it matters, but I'm siding with Jeff on this one. I suspect that
Windows uses 256 as well, which basically means that we're in the clear.

-- 
Jens Axboe

