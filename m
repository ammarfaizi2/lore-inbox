Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUIBGG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUIBGG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUIBGG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:06:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:59844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267602AbUIBGFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:05:38 -0400
Date: Wed, 1 Sep 2004 23:04:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Masover <ninja@slaphack.com>
cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4136A14E.9010303@slaphack.com>
Message-ID: <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org>
 <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Sep 2004, David Masover wrote:
> 
> I think transactions should be done in kernel space.  It's the only way
> to "enforce" them sanely.

Well, they clearly can't, since it depends on the filesystem. Also, 
transactions have a tendency to be expensive, and people have a tendency 
to ask for more than you give them. Doing transactions on one file is 
only the beginning - you'll find people who want transactions across file 
boundaries etc.

That's a basic fact when it comes to pretty much anything: you can always 
find people who want something better. You can't be all things to all 
people, so what you actually _want_ to do is to expose the _minimal_ set 
of capabilities that people can build on.

So I definitely don't want this discussion to degenerate (any more than it
lng since has ;) into what people _wish_ for. No, it should be a "what is
the _least_ we can absolutely do" that solves real problems.

		Linus
