Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751967AbWHNJc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbWHNJc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWHNJc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:32:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751967AbWHNJc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:32:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1155542805.3430.5.camel@raven.themaw.net> 
References: <1155542805.3430.5.camel@raven.themaw.net>  <20060813012454.f1d52189.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> 
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 14 Aug 2006 10:32:10 +0100
Message-ID: <15771.1155547930@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> I'm having trouble duplicating this.
> Is there any more info. about this I'm missing?

Works fine for me also.

Andrew, can you do the following:

	cat /proc/fs/nfsfs/*

And can you try mounting "bix:/" manually to see if that exhibits the same
problem?  It'd be useful to know if autofs is actually having an effect.

Also, can you do a module list and check that it's autofs4 that's being used,
and not autofs.  It would be handy if we could rule out an adverse interaction
between nfs and autofs4.

> Bisection shows that the bug is introduced by git-nfs.patch.

But what does it actually show?  Do you know where the bug is then?  (I don't
know exactly how bisection works).

David
