Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274172AbRIXVFe>; Mon, 24 Sep 2001 17:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274170AbRIXVFY>; Mon, 24 Sep 2001 17:05:24 -0400
Received: from peace.netnation.com ([204.174.223.2]:42756 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S274172AbRIXVFK>; Mon, 24 Sep 2001 17:05:10 -0400
Date: Mon, 24 Sep 2001 14:05:34 -0700
From: Simon Kirby <sim@netnation.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK on files
Message-ID: <20010924140534.E2335@netnation.com>
In-Reply-To: <20010918234648.A21010@netnation.com> <m1r8t3fyot.fsf@frodo.biederman.org> <20010919002439.A21138@netnation.com> <20010924234717.V11046@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010924234717.V11046@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Mon, Sep 24, 2001 at 11:47:17PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 11:47:17PM +0300, Matti Aarnio wrote:

> On Wed, Sep 19, 2001 at 12:24:39AM -0700, Simon Kirby wrote:
> 
> > Hmm...Without even thinking about it, I assumed it would start a read and
> > select() or poll() or some later call would return readable when my
> > outstanding request was fulfilled.  But yes, I guess you're right, this is
> > different behavior because there is no other side.
> 
>    To push the idea into ultimate:  AIO
> 
>    You open file, start IO, and do other things while the machine
>    is doing IO.    Doing open() asynchronously would be ultimate,
>    but alas, not particularly trivial.
> 
>    There are problems also in the AIO status rendezvous mechanisms.
> 
>    Your best choice could be (with moderation) to do synchronous
>    operations at separate threads.

Yes, but this sucks.  My whole intent was an interface design that would
never need to context switch.  I'm not sure if this is even possible, but
if so it would be very nice from a userspace perspective.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
