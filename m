Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271601AbRHPRyk>; Thu, 16 Aug 2001 13:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271603AbRHPRyb>; Thu, 16 Aug 2001 13:54:31 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:32714 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S271601AbRHPRyU>; Thu, 16 Aug 2001 13:54:20 -0400
Message-ID: <0b7201c1267c$5c30b260$103147ab@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: =?iso-8859-1?Q?Eduardo_Cort=E9s?= <the_beast@softhome.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10108161610150.19342-100000@coffee.psychology.mcmaster.ca> <20010816162913Z271588-760+2494@vger.kernel.org>
Subject: Re: Re: limit cpu
Date: Thu, 16 Aug 2001 10:53:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current Linux scheduler doesn't seem to be able to support this nicely.  You
can set their priorities..but the values are not very intuitive.  And if you
sleep, the result could become very inaccurate.

A new scheduler (sth like weighted round robin) is a more natural solution.
You just assign weights to processes and they will be scheduled accordingly.

----- Original Message -----
From: "Eduardo Cortés" <the_beast@softhome.net>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 16, 2001 9:29 AM
Subject: Re: Re: limit cpu


> On Thursday 16 August 2001 18:13, you wrote:
> > > > > i want to know if linux can limit the max cpu usage (not cpu time)
> > > > > per user,
> > > >
> > > > no.  doing so would inherently slow down the scheduler.
> > >
> > > but *BSD has this feature, what's the problem in linux?
> >
> > I said that, thinking that it would require another test along
> > the scheduler's fast path.  but if we only test when a process
> > has exhausted its quantum (or perhaps at counter-recalc),
> > the overhead would be minor.
>
> I think that it's a good feature for linux, but I don't know if is very
> complex to develope in linux. If I can limit the max cpu usage (in %) for
an
> user/group, the box is more solid.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

