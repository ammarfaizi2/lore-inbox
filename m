Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWCMHel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWCMHel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 02:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCMHek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 02:34:40 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:42089 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751942AbWCMHek convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 02:34:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iP/es3DMjAXMmz8sxWj4+vCpqQJZyXMhyb6Mi+rv6/R7Ay41oAmaSf+lWFPS0UEGENvDqZW/JfEJXxGjIk11zcWNBMplDStdkWg8hAQcRHJkg2mYwxbpjsogn56lqKJHIR5aMRoHR6mMI2VJQKTSiraOczoRJvh/ZLiqxxW96vI=
Message-ID: <9a8748490603122334h6682be62r18f781003db88b20@mail.gmail.com>
Date: Mon, 13 Mar 2006 08:34:39 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()
Cc: linux-kernel@vger.kernel.org, "Christoph Lameter" <clameter@engr.sgi.com>
In-Reply-To: <20060312144129.0b5c227d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603121428.08226.jesper.juhl@gmail.com>
	 <20060312144129.0b5c227d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> >
> > The Coverity checker found that we may leak memory in
> > mm/slab.c::alloc_kmemlist()
> > This should fix the leak and coverity bug #589
> >
[snip]
>
> It's more complicated than that.  We can also leak new_alien.  And if any
> allocation in that for_each_online_node() loop fails I guess we need to
> back out all the allocations we've done thus far, which means another loop.
> ug.
>
Ok, I'll take a second (and much more thorough) look at it tonight.
And I'll be sure to describe whatever changes I make and the reasoning
behind.


> Patches against rc6-mm1 would be preferred please, that code's changed
> quite a bit.
>
Sure thing.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
