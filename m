Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274649AbRITVL6>; Thu, 20 Sep 2001 17:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRITVLv>; Thu, 20 Sep 2001 17:11:51 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:29898 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274649AbRITVLd>; Thu, 20 Sep 2001 17:11:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Date: Thu, 20 Sep 2001 23:11:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Chris Mason <mason@suse.com>, Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy>
In-Reply-To: <1001019170.6090.134.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920211140Z274649-760+14609@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2001 22:52 schrieb Robert Love:
> On Thu, 2001-09-20 at 13:39, Andrew Morton wrote:
> > > Andrew, are these still maintained or should I pull out the reiserfs
> > > bits?
> >
> > This is the reiserfs part - it applies to 2.4.10-pre12 OK.
> >
> > For the purposes of Robert's patch, conditional_schedule()
> > should be defined as
> >
> > 	if (current->need_resched && current->lock_depth == 0) {
> > 		unlock_kernel();
> > 		lock_kernel();
> > 	}
> >
> > which is somewhat crufty, because the implementation of lock_kernel()
> > is arch-specific.  But all architectures seem to implement it the same
> > way.

> > <patch snipped>
>
> Looks nice, Andrew.
>
> Anyone try this? (I don't use ReiserFS).

Yes, I will...:-)
Send it along.

>
> I am putting together a conditional scheduling patch to fix some of the
> worst cases, for use in conjunction with the preemption patch, and this
> might be useful.

The conditional_schedule() function hampered me from running it already.

-Dieter
