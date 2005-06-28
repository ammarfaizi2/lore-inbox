Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVF1H2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVF1H2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVF1G34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:29:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261844AbVF1GSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:18:01 -0400
Date: Mon, 27 Jun 2005 23:17:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: earny@net4u.de, linux-kernel@vger.kernel.org
Subject: Re: dirty md raid5 slab bio leak
Message-Id: <20050627231718.2f6c3bbf.akpm@osdl.org>
In-Reply-To: <17088.59816.277303.588185@cse.unsw.edu.au>
References: <200506272222.51993.list-lkml@net4u.de>
	<17088.41384.864708.23860@cse.unsw.edu.au>
	<17088.52861.78252.726904@cse.unsw.edu.au>
	<20050627212511.11402fd1.akpm@osdl.org>
	<17088.59816.277303.588185@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> On Monday June 27, akpm@osdl.org wrote:
> > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > >
> > > It's OK, I found it.  The bio leaks when writing the md superblock.
> > > 
> > 
> > Thanks.
> > 
> > >  insert a missing bio_put when writting the md superblock.
> > 
> > Does 2.6.12.x need this?
> 
> Hmmm.. probably, though it isn't Ooopsable, and isn't a security
> problem.  Just a slow leak with a trivial patch...  

It's a pretty sad bug if it hits you though.

> Is there a web-page somewhere that lists the acceptance criterea? I
> didn't save the mail message.

Me either.  Just send 'em any old thing and let them decide ;)

> Do I just mail the patch to stable@kernel.org ??

That's OK, I'll add it to my backport queue - we should leave it to bake in
2.6.13-rc1 for a bit first.

