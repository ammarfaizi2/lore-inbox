Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262200AbTCHU70>; Sat, 8 Mar 2003 15:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262203AbTCHU70>; Sat, 8 Mar 2003 15:59:26 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:43533 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262200AbTCHU6u>; Sat, 8 Mar 2003 15:58:50 -0500
Date: Sat, 8 Mar 2003 21:09:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, akpm@digeo.com, alan@lxorguk.ukuu.org.uk,
       greg@kroah.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308210922.A419@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com, alan@lxorguk.ukuu.org.uk,
	greg@kroah.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200303082059.h28KxES05315.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303082059.h28KxES05315.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Mar 08, 2003 at 09:59:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 09:59:14PM +0100, Andries.Brouwer@cwi.nl wrote:
> > We need to get rid of the artifical major/minor split completly
> 
> I do not disagree with you, but your point of view seems
> to be that either we make everything perfect or we do nothing.
> I prefer slow progress.

I completly agree with you on the slow steps.  What we seem to
disagree about is the order of steps..

> Concerning this split - traces of it occur in a very large
> number of places.

Yupp.  And getting rid of those one by one is a a good thing
and I'm happy about every single patch you submit to get rid
of one.

> Let me just mention the raw device that
> I did this afternoon. How does one connect a raw device
> with a block device? Using a struct raw_config_request
> from user space. And look
> 
> struct raw_config_request
> {
>         int     raw_minor;
>         __u64   block_major;
>         __u64   block_minor;
> };
> 
> One of the many places that has a built-in major/minor split.
> Basically this split is unimportant. A dev_t is just a cookie.
> But as soon as you start looking at details this split is
> all over the place.

Yes.  And my opinion is that we need to sort these issues out
one for one before moving on to make dev_t bigger, not the other
way around.

