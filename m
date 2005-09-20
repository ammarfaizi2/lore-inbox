Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVITNbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVITNbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVITNbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:31:00 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:9177 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S965009AbVITNa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:30:59 -0400
From: Lorenzo Allegrucci <l.allegrucci@gmail.com>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Tue, 20 Sep 2005 15:30:01 +0200
User-Agent: KMail/1.7.2
Cc: Hans Reiser <reiser@namesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
References: <200509180934.50789.chriswhite@gentoo.org> <432FC150.9020807@namesys.com> <20050920114253.GL10845@suse.de>
In-Reply-To: <20050920114253.GL10845@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201530.01808.l.allegrucci@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2005 13:42, Jens Axboe wrote:
> On Tue, Sep 20 2005, Hans Reiser wrote:
> > >>The name for one.  There is no elevator algorithm anywhere in it.  There
> > >>is a least block number first algorithm that was called an elevator, but
> > >>    
> > >>
> > >
> > >Well the terminology changed to "io scheduler" now, however the
> > >residual "elevator" name found in places doesn't cause anyone
> > >any problems and there isn't much reason to change it other than
> > >the desire to break things.
> > >  
> > >
> > Did you really say that?    I mean, come on, can't you at least manage a
> > "well, it ought to get changed but I am busy with something more
> > exciting to me".
> 
> Seeing as you are the one that is apparently bothered by the misnomer,
> it follows that you would be the one submitting a patch for this. Not
> that it would be accepted though, I don't see much point in renaming
> functions and breaking drivers just because of a slightly bad name. The
> io schedulers are all called foo-iosched.c, it's only the simple core
> api that uses the 'elevator' description.

Why not just rename the kernel option "elevator" to "iosched" ?

--- elevator.c  2005-09-20 15:26:19.000000000 +0200
+++ elevator.c.iosched  2005-09-20 15:27:11.000000000 +0200
@@ -178,7 +178,7 @@
        return 0;
 }

-__setup("elevator=", elevator_setup);
+__setup("iosched=", elevator_setup);

 int elevator_init(request_queue_t *q, char *name)
 {
