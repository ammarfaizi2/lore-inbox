Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVG2R5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVG2R5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVG2R5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:57:01 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:54208 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262684AbVG2R46 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:56:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fL5u0VXA8iI5IibtOYydE0L+SnFApF72aaxgiMP7vnsUerMSW75rtongrocRbYlJBp2d8brkY3RmTI+YElvsJYTNVk8THP+HNdeGoQantOWmjE0Qck9jYxMtHlke87xMnDBPthe0+LigdeurF9yjOc7Mghhd8SC/ywz/IM/9jtI=
Message-ID: <5c49b0ed05072910563bcce840@mail.gmail.com>
Date: Fri, 29 Jul 2005 10:56:55 -0700
From: Nate Diller <nate.diller@gmail.com>
Reply-To: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: io scheduler silly question perhaps..
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <20050729072749.GD22569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0507290130000.1030@skynet>
	 <5c49b0ed0507281752b9485@mail.gmail.com>
	 <20050729072749.GD22569@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/05, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Jul 28 2005, Nate Diller wrote:
> > Try benchmarking Anticipatory or Deadline against Noop, preferably
> > with your actual workload.  Noop is probably what you want, since
> > there is not much use in avoiding large "seeks".  It could be though
> > that request merging, which the non-noop schedulers all perform, willl
> > cause Noop to lose.  I haven't tried any I/O scheduler benchmarks with
> > flash, but perhaps we need a simple "merge only" scheduler for this
> > sort of thing.
> >
> > Let me know what the results are.
> 
> deadline is the appropriate choice, you could still have read starvation
> issues with noop. anticipatory doesn't make any sense, as the device has
> no seek penalty.

I'm not sure I understand your concern with noop.  even if there were
writes in the queue (he said there were none/few) i don't see how read
starvation could occur with a FIFO.  also, I have read that for large
flash devices, there is a (small) seek penalty, but that it's
relatively constant for large vs. small seeks.  can someone elaborate
on that?

so dave, try deadline vs noop and let us know what you get.  also, are
you concerned with CPU use?

> 
> and hey, don't top post! now we lost daves original mail.

yeah, you're right, so much for gmail "quick reply"

NATE
> 
> --
> Jens Axboe
> 
>
