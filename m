Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbTF3J7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbTF3J7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:59:33 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:26343 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265834AbTF3J6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:58:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Mon, 30 Jun 2003 20:16:21 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200306291457.40524.kernel@kolivas.org> <5.2.0.9.2.20030630094946.00cfb000@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030630094946.00cfb000@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306302016.21123.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003 17:57, Mike Galbraith wrote:
> Greetings,
>
> At 03:35 PM 6/30/2003 +1000, Con Kolivas wrote:
> >Summary:
> >A patch to reduce audio skipping and X jerking under load.
>
> I took it out for a quick spin.  It kills thud graveyard dead.  That's the
> good news, now for the bad ;-)  With a make -j5 running, kasteroids
> stutters enough to be pretty annoying.  The patched kernel is making
> booboos wrt cc1's priority often enough to nail kasteroids pretty
> hard.  The mouse pointer also jerks around quite a bit,...

Consider it not optimised yet. The workings are still evolving but are now 
close. It errs on the too-easy to get a bonus in the early ms after an app 
has started at the moment.

>
> >It's looking seriously like I'm talking to myelf here, but just in case
> > there are lurkers testing this patch, there's a big bug that made it
> > think jiffy wraparound was occurring so interactive tasks weren't
> > receiving the boost they deserved. Here is a patch with the fix in.
> >
> >How to use if you're still thinking of testing:
> >Use with Hz 1000, and use the granularity patch I posted as well for
> >smoothing
> >X off.
>
> ...but I'm not using that, because I wanted to see the pure effects of this
> patch.

Good point. If it's going to be developed properly it should only include what 
is likely to be used with it.

Con

