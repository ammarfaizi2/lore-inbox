Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbTDBHrY>; Wed, 2 Apr 2003 02:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262845AbTDBHrY>; Wed, 2 Apr 2003 02:47:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262660AbTDBHrD>;
	Wed, 2 Apr 2003 02:47:03 -0500
Date: Wed, 2 Apr 2003 09:58:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.66-mm2 with contest
Message-ID: <20030402075822.GB2925@suse.de>
References: <200304021324.10799.kernel@kolivas.org> <3E8A6227.7080209@cyberone.com.au> <20030402074227.GH901@suse.de> <3E8A97D6.3000603@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8A97D6.3000603@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02 2003, Nick Piggin wrote:
> Jens Axboe wrote:
> 
> >On Wed, Apr 02 2003, Nick Piggin wrote:
> >
> >>Con Kolivas wrote:
> >>
> >>
> >>>Big rise in ctar_load and io_load. Drop in read_load.
> >>>(All uniprocessor with IDE and AS elevator). AS tweaks? No obvious 
> >>>scheduler tweak result changes.
> >>>
> >>>
> >>Thanks Con,
> >>I'm a bit busy now, but next week I'll work something out for it.
> >>It is most likely to be as-queue_notready-cleanup.patch. I'll
> >>wait until after Jens ports his dynamic requests stuff over to
> >>mm before I go further.
> >>
> >
> >It is ported, I sent Andrew the patch yesterday. I'm attaching it here
> >as well.
> >
> Thanks for doing that, Jens. Any CPU measurements on the hash
> goodness that you did for deadline?

Nope none yet, in fact Andrew's profile numbers show very little time
spent inside the io scheduler hash as it is. It feels like the right
thing to do though, even if the hash doesn't eat that much time.

-- 
Jens Axboe

