Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbSLLJOj>; Thu, 12 Dec 2002 04:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbSLLJOj>; Thu, 12 Dec 2002 04:14:39 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:2056 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267435AbSLLJOj>; Thu, 12 Dec 2002 04:14:39 -0500
Date: Thu, 12 Dec 2002 09:22:21 +0000
To: Jens Axboe <axboe@suse.de>
Cc: Wil Reichert <wilreichert@yahoo.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
Message-ID: <20021212092221.GB1299@reti>
References: <1039572597.459.82.camel@darwin> <3DF6A673.D406BC7F@digeo.com> <1039577938.388.9.camel@darwin> <20021211072139.GF16003@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211072139.GF16003@suse.de>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 08:21:39AM +0100, Jens Axboe wrote:
> On Tue, Dec 10 2002, Wil Reichert wrote:
> > Exact error with debug is:
> > 
> > darwin:/a01/mp3s/Skinny Puppy/Too Dark Park# ogg123 -q 01\ -\
> > Convulsion.ogg
> > bio too big device ide0(3,4) (256 > 255)
> 
> looks like a one-off in the dm merge_bvec function.

Nope, we're not using merge_bvec yet.  Kevin Corry has convinced me
that there is a bug in dms bv splitting code, I'll put out a new
patchset later.  However the known bug wouldn't have a stack trace
like this.

- Joe
