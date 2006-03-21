Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWCUMIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWCUMIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCUMIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:08:54 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:19408 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751498AbWCUMIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:08:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Date: Tue, 21 Mar 2006 23:07:59 +1100
User-Agent: KMail/1.9.1
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
References: <20060320122449.GA29718@outpost.ds9a.nl> <200603212258.46265.kernel@kolivas.org> <1142942684.3077.66.camel@laptopd505.fenrus.org>
In-Reply-To: <1142942684.3077.66.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603212308.00645.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 23:04, Arjan van de Ven wrote:
> On Tue, 2006-03-21 at 22:58 +1100, Con Kolivas wrote:
> > On Tuesday 21 March 2006 19:53, Andreas Mohr wrote:
> > > (and the fact that invoking a function pointer should be similarly
> > > expensive to a conditional) I don't think it's useful.
> >
> > Is
> >
> > *blah();
> >
> > as expensive as
> >
> > if (conditional)
> > 	blah();
> >
> > I don't know the answer. I just know cmp is expensive. Comments?
>
> function pointer is usually MORE expensive.
> for if() the processor has a change to predict the branch right, while
> call <register> (which is what function pointer calls end up being) are
> basically always mispredicted unless you have a really really fancy
> branch predictor...

Thanks! That's something I've been trying to find good info on.

Cheers,
Con
