Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274971AbRIXUr3>; Mon, 24 Sep 2001 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274967AbRIXUrU>; Mon, 24 Sep 2001 16:47:20 -0400
Received: from mail.zmailer.org ([194.252.70.162]:55561 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S274962AbRIXUrF>;
	Mon, 24 Sep 2001 16:47:05 -0400
Date: Mon, 24 Sep 2001 23:47:17 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK on files
Message-ID: <20010924234717.V11046@mea-ext.zmailer.org>
In-Reply-To: <20010918234648.A21010@netnation.com> <m1r8t3fyot.fsf@frodo.biederman.org> <20010919002439.A21138@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919002439.A21138@netnation.com>; from sim@netnation.com on Wed, Sep 19, 2001 at 12:24:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 12:24:39AM -0700, Simon Kirby wrote:
> On Wed, Sep 19, 2001 at 01:05:06AM -0600, Eric W. Biederman wrote:
> > What would cause the data to be read in if read just checks the caches?
> > With sockets the other side is clearing pushing or pulling the data.  With
> > files there is no other side...
> 
> Hmm...Without even thinking about it, I assumed it would start a read and
> select() or poll() or some later call would return readable when my
> outstanding request was fulfilled.  But yes, I guess you're right, this is
> different behavior because there is no other side.

   To push the idea into ultimate:  AIO

   You open file, start IO, and do other things while the machine
   is doing IO.    Doing open() asynchronously would be ultimate,
   but alas, not particularly trivial.

   There are problems also in the AIO status rendezvous mechanisms.

   Your best choice could be (with moderation) to do synchronous
   operations at separate threads.

> Reading a file would need a receive queue to make this work, I guess. :)
> Simon-
> [       sim@stormix.com       ][       sim@netnation.com        ]

/Matti Aarnio
