Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262894AbTDBIE3>; Wed, 2 Apr 2003 03:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbTDBIE3>; Wed, 2 Apr 2003 03:04:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43916 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262894AbTDBIE2>;
	Wed, 2 Apr 2003 03:04:28 -0500
Date: Wed, 2 Apr 2003 10:15:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.66-mm2 with contest
Message-ID: <20030402081542.GB3367@suse.de>
References: <200304021324.10799.kernel@kolivas.org> <3E8A6227.7080209@cyberone.com.au> <20030402074227.GH901@suse.de> <3E8A97D6.3000603@cyberone.com.au> <20030402075822.GB2925@suse.de> <3E8A9A83.1070704@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8A9A83.1070704@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02 2003, Nick Piggin wrote:
> Jens Axboe wrote:
> 
> >On Wed, Apr 02 2003, Nick Piggin wrote:
> >
> >>Thanks for doing that, Jens. Any CPU measurements on the hash
> >>goodness that you did for deadline?
> >>
> >
> >Nope none yet, in fact Andrew's profile numbers show very little time
> >spent inside the io scheduler hash as it is. It feels like the right
> >thing to do though, even if the hash doesn't eat that much time.
> >
> I agree - especially as we want a smaller hash and with
> more requests.

Exactly. The effectiveness of the last merge hint shows that the
majority of the merges happen in succession, so the move-to-front for
last merge should have obvious benefits.

The rq-dyn-alloc patch shrinks the hash to 32 entries as a consequence.

-- 
Jens Axboe

