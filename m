Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWCMVdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWCMVdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWCMVdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:33:40 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:44079 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751518AbWCMVdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:33:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FrjY3jvR+cX5gJselmFJuGcdWdB2YNRIQZEcrD9mUI+ja6ExEIgcW5pHdCuMDRf38ZpSJCGQSwn60wfSekOMv16nqy+fUcAW00veDYbQnmWwBJBOEvguU+WOqHzDKIKVcLXmf67sVLUQBHFNllYvz8U2x28IcOj2embEC1uK2aM=
Message-ID: <9a8748490603131333o1b252aeq9e7f4aca97295640@mail.gmail.com>
Date: Mon, 13 Mar 2006 22:33:38 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()
Cc: linux-kernel@vger.kernel.org, "Christoph Lameter" <clameter@engr.sgi.com>
In-Reply-To: <9a8748490603122334h6682be62r18f781003db88b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603121428.08226.jesper.juhl@gmail.com>
	 <20060312144129.0b5c227d.akpm@osdl.org>
	 <9a8748490603122334h6682be62r18f781003db88b20@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 3/12/06, Andrew Morton <akpm@osdl.org> wrote:
> > Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > >
> > >
> > > The Coverity checker found that we may leak memory in
> > > mm/slab.c::alloc_kmemlist()
> > > This should fix the leak and coverity bug #589
> > >
> [snip]
> >
> > It's more complicated than that.  We can also leak new_alien.  And if any
> > allocation in that for_each_online_node() loop fails I guess we need to
> > back out all the allocations we've done thus far, which means another loop.
> > ug.
> >
> Ok, I'll take a second (and much more thorough) look at it tonight.
> And I'll be sure to describe whatever changes I make and the reasoning
> behind.
>
>
> > Patches against rc6-mm1 would be preferred please, that code's changed
> > quite a bit.
> >
> Sure thing.
>

Ok, I've been playing around with a few ways to resolve this, but I'm
a bit pressed for time and won't have properly tested patches ready
tonight. I will however keep at this, so you'll see patches
releatively shortly, just give me another day or two and I'll have
this fixed in a nice way (nice little task to work at :) ...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
