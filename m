Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285499AbRLNVBW>; Fri, 14 Dec 2001 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285501AbRLNVBN>; Fri, 14 Dec 2001 16:01:13 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:23594 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285499AbRLNVBA> convert rfc822-to-8bit; Fri, 14 Dec 2001 16:01:00 -0500
Date: Fri, 14 Dec 2001 19:05:58 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jens Axboe <axboe@suse.de>
cc: Kirk Alexander <kirkalx@yahoo.co.nz>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20011214200948.GT1180@suse.de>
Message-ID: <20011214183721.H1878-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Dec 2001, Jens Axboe wrote:

> On Fri, Dec 14 2001, Gérard Roudier wrote:
> > > I fixed the problem by seeing what the sym
> > > driver did i.e. the patch below
> > > This may not be right at all, and I haven't had a
> > > chance to boot the kernel - but it did build OK.
> >
> > The ncr53c8xx and sym53c8xx version 1 use the obsolete scsi eh handling.
> > Moving the eh code from sym53c8xx_2 (version 2) to ncr53c8xx/sym53c8xx is
> > quite feasible, but may-be it is just useless given sym53c8xx_2. For now,
> > it seems that sym53c8xx_2 replaces both ncr/sym53c8xx without any loss of
> > reliability and performance.
>
> Gerard,
>
> For 2.5, why don't we just yank old sym and ncr out of the kernel? Is
> there _any_ reason to keep the two older ones given your new driver
> handles it all?

On my side, there is obviously no reason to keep them in 2.5, as sym-2 is
intended to replace them both. Personnaly I have switched to sym-2 on my
systems since several months.

However, I donnot consider myself as the only owner of these drivers. The
owners are all people that may need symbios chips support under Linux. My
personnal vote, as a user/owner, is to remove them and rely for symbios
chip support on sym-2.

--

Linux stable is a different issue. For this one, I would prefer the old
drivers to remain in place for a longer time. However, I personnaly will
not track bugs on old drivers if either,

- The problem also shows up in sym-2. Then I will try to fix sym-2,
- Or the problem simply doesn't occur in sym-2.

This will apply to problems reported directly by users or by packagers.

By the way, for now, I haven't received any report about sym-2 failing
when sym-1 or ncr succeeds, and my feeling is that this could well be very
unlikely.

But I can make mistakes, me too. :-)

  Gérard.

