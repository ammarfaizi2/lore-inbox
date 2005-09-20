Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVITNlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVITNlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVITNlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:41:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48717 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965013AbVITNlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:41:31 -0400
Date: Tue, 20 Sep 2005 15:41:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Lorenzo Allegrucci <l.allegrucci@gmail.com>
Cc: Hans Reiser <reiser@namesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920134115.GN10845@suse.de>
References: <200509180934.50789.chriswhite@gentoo.org> <432FC150.9020807@namesys.com> <20050920114253.GL10845@suse.de> <200509201530.01808.l.allegrucci@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509201530.01808.l.allegrucci@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20 2005, Lorenzo Allegrucci wrote:
> On Tuesday 20 September 2005 13:42, Jens Axboe wrote:
> > On Tue, Sep 20 2005, Hans Reiser wrote:
> > > >>The name for one.  There is no elevator algorithm anywhere in it.  There
> > > >>is a least block number first algorithm that was called an elevator, but
> > > >>    
> > > >>
> > > >
> > > >Well the terminology changed to "io scheduler" now, however the
> > > >residual "elevator" name found in places doesn't cause anyone
> > > >any problems and there isn't much reason to change it other than
> > > >the desire to break things.
> > > >  
> > > >
> > > Did you really say that?    I mean, come on, can't you at least manage a
> > > "well, it ought to get changed but I am busy with something more
> > > exciting to me".
> > 
> > Seeing as you are the one that is apparently bothered by the misnomer,
> > it follows that you would be the one submitting a patch for this. Not
> > that it would be accepted though, I don't see much point in renaming
> > functions and breaking drivers just because of a slightly bad name. The
> > io schedulers are all called foo-iosched.c, it's only the simple core
> > api that uses the 'elevator' description.
> 
> Why not just rename the kernel option "elevator" to "iosched" ?
> 
> --- elevator.c  2005-09-20 15:26:19.000000000 +0200
> +++ elevator.c.iosched  2005-09-20 15:27:11.000000000 +0200
> @@ -178,7 +178,7 @@
>         return 0;
>  }
> 
> -__setup("elevator=", elevator_setup);
> +__setup("iosched=", elevator_setup);
> 
>  int elevator_init(request_queue_t *q, char *name)
>  {

Because I know at least SUSE uses this name for setting a different io
scheduler on boot. And there are users out there that have added the
options to their boot loader config.

So let me repeat - we are not going to break any existing setups for no
good reason. End of discussion.

-- 
Jens Axboe

