Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWCWLTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWCWLTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWCWLTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:19:39 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:36897 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751017AbWCWLTi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:19:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ELO6nb2EHk85rl1CSNCTJqASTCZiol/sRyPlfMocSieZWcT7bns/QS9qi1Mm77X9nGF+MIoaA7o5QvzzNGoXgAxfLoP5ttRZLhzr0rtPsO0+3WQwz7EZZBj+xnAQfKoMQ9b0Cmpv2XCj70UucPrOcIwdz6/azC9el1rJC6yjgqU=
Message-ID: <9a8748490603230319q5ad06eb2m25d1f3ad4b969000@mail.gmail.com>
Date: Thu, 23 Mar 2006 12:19:37 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: swap prefetching merge plans
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322205305.0604f49b.akpm@osdl.org>
	 <200603231804.36334.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Con Kolivas <kernel@kolivas.org> wrote:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
>
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
>
> >   Still don't have a compelling argument for this, IMO.
>
> For those users who feel they do have a compelling argument for it, please
> speak now or I'll end up maintaining this in -ck only forever.  I've come to
> depend on it with my workloads now so I'm never dropping it. There's no point
> me explaining how it is useful yet again, though, because I just end up
> looking like I'm handwaving. It seems a shame for it not to be available to
> all linux users.
>

I certainly like it and see a bennefit.
My situation is like this:
 A KDE desktop with OpenOffice, Lyx, Firefox, Eclipse, Gimp & a bunch
of xterms running more or less permanently.
 When I work on kernel stuff I often end up running "make clean ; make
allyesconfig ; make" and the build and especially final link of the
kernel usually kills the box for a while, so I tend to walk away and
come back a while later when it's done.
 Where I see the bennefit of swap prefetch is when I come back to my
box after such a build and pull one of my other running apps back to
the foreground. The apps come back noticably faster when I'm running a
swap prefetching kernel - we are not talking massive amounts of time,
just a few seconds, but it's enough for me to notice when I sometimes
happen to run a mainline kernel without swap prefetch.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
