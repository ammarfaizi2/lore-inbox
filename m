Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSFDMVO>; Tue, 4 Jun 2002 08:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSFDMVN>; Tue, 4 Jun 2002 08:21:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316594AbSFDMVM>;
	Tue, 4 Jun 2002 08:21:12 -0400
Date: Tue, 4 Jun 2002 14:21:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604122105.GB1105@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Neil Brown wrote:
> On Tuesday June 4, axboe@suse.de wrote:
> > 
> > What changes did you have in mind?
> 
> http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/2.5.20/patch-A-NewPlug
> 
> Is what I had against 2.5.20.  A quick look at the mail that you sent
> with improvements suggest that I can be even less intrusive..  But it
> will have to wait until tomorrow (my time).

Ah ok, I see what you have in mind. Right now you are completely
mimicking the tq_struct setup -- any reason a simple q->plug_fn is not
enough? Do you ever need anything else than the queue passed in with the
plug? Wrt umem, it seems you could keep 'card' in the queuedata. Same
for raid5 and conf.

-- 
Jens Axboe

