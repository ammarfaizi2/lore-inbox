Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbTGHUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbTGHUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:38:16 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:47827 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S267614AbTGHUiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:38:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Wed, 9 Jul 2003 06:54:17 +1000
User-Agent: KMail/1.5.2
Cc: Szonyi Calin <sony@etc.utt.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307070317.11246.kernel@kolivas.org> <200307081759.39215.kernel@kolivas.org> <Pine.LNX.4.55.0307080806400.4544@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307080806400.4544@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307090654.17408.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 01:12, Davide Libenzi wrote:
> On Tue, 8 Jul 2003, Con Kolivas wrote:
> > On Tue, 8 Jul 2003 17:46, Davide Libenzi wrote:
> > > On Tue, 8 Jul 2003, Szonyi Calin wrote:
> > > > In the weekend i did some experiments with the defines in
> > > > kernel/sched.c It seems that changing in MAX_TIMESLICE the "200" to
> > > > "100" or even "50" helps a little bit. (i was able to do a make
> > > > bzImage and watch a movie without noticing that is a kernel compile
> > > > in background)
> > >
> > > I bet it helps. Something around 100-120 should be fine. Now we need an
> > > exponential function of the priority to assign timeslices to try to
> > > maintain interactivity. This should work :
> >
> > This is still decreasing the timeslices. Whether you do it linearly or
> > exponentially the timeslices are smaller, which just about everyone will
> > resist you doing.
>
> Maybe you (and this Mr Everyone) might be interested in knowing that the
> interactivity is not given by the absolute length of the timeslice but by
> the ratio between timeslices. If you have three processes running with
> timeslices :
>
> A = 400
> B = 200
> C = 100
>
> the interactivity is the same of the one if you have :
>
> A = 100
> B = 50
> C = 25
>
> What changes is the maxiomum CPU blackout time that each task has to see
> before re-emerging again from the expired array. In the first case in
> "only" 700ms while in the first case is 175ms.

and what happens to the throughput?

