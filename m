Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934527AbWKXJwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934527AbWKXJwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934526AbWKXJwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:52:05 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:10265 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S934528AbWKXJwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:52:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KIy28znwgdNzcrhMOiGBdeV4oSRMW5bulJ7DSYWnEP+TXLEZxOKs97dTtyILRCrJWJMH7ymLy0cdJIPxY+QS6M9W1aW3TjvFuL3RQV/SIkFTinji3bMwREelUi6V2rZ7oauJggAP93s1XGAOE9CbXX3paEl5NhGS+JLVKm0CH3c=
Message-ID: <9a8748490611240152x3a24f96fx62cd311f52b5fafb@mail.gmail.com>
Date: Fri, 24 Nov 2006 10:52:00 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061124094648.GA5400@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com>
	 <20061122110740.GA8055@kernel.dk>
	 <200611240052.13719.jesper.juhl@gmail.com>
	 <20061124065209.GX4999@kernel.dk>
	 <9a8748490611240141o4d285317h3c1e2110f515e141@mail.gmail.com>
	 <20061124094648.GA5400@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Fri, Nov 24 2006, Jesper Juhl wrote:
> > On 24/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >On Fri, Nov 24 2006, Jesper Juhl wrote:
> > >> > Does the box survive io intensive workloads?
> > >>
> > >> It seems to. It does get sluggish as hell when there is lots of disk I/O
> > >but
> > >> it seems to be able to survive.
> > >> I'll try some more, with some IO benchmarks + various other stuff to see
> > >> if I can get it to die that way.
> > >
> > >Just wondering if you have a marginal powersupply, perhaps.
> > >
> > It is a possibility, but I doubt it, since if I use a 2.6.17.x kernel
> > then things are rock solid and I can't cause a lockup even if I leave
> > my box building kernels in the background for days.
>
> Since it triggers fairly quickly, any chance that you could try and
> narrow it down to a specific version that breaks?
>
I already tried doing a git bisect, but I somehow messed it up
(probably by concluding that a bad kernel was good).
The problem is that *usually* triggers fairly quickly (within 1hr),
but sometimes it takes much longer to trigger, so it's hard to be 100%
sure that a kernel is actually good - except if I leave it running for
something like 24hrs for each step in the bisect. That is actually
something I plan to do, but finding the time for that is not easy.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
