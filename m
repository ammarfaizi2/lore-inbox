Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUGJJpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUGJJpP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 05:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUGJJpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 05:45:15 -0400
Received: from outmx003.isp.belgacom.be ([195.238.2.100]:61335 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266199AbUGJJpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 05:45:08 -0400
Subject: Re: Autoregulate swappiness & inactivation
From: FabF <fabian.frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40EE8075.6060700@yahoo.com.au>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <20040708001027.7fed0bc4.akpm@osdl.org>
	 <cone.1089273505.418287.4554.502@pc.kolivas.org>
	 <20040708010842.2064a706.akpm@osdl.org>
	 <cone.1089275229.304355.4554.502@pc.kolivas.org>
	 <1089284097.3691.52.camel@localhost.localdomain>
	 <40EDEF68.2020503@kolivas.org>
	 <1089366486.3322.10.camel@localhost.localdomain>
	 <40EE76CC.5070905@yahoo.com.au>
	 <1089371646.3322.38.camel@localhost.localdomain>
	 <40EE8075.6060700@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089452697.3646.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 11:44:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 13:24, Nick Piggin wrote:
> FabF wrote:
> > On Fri, 2004-07-09 at 12:43, Nick Piggin wrote:
> 
> >>pdflush is used to perform writeout of dirty data, so it has
> >>no part in reducing Mozilla's RSS.
> > 
> > Oops ... kswapd then ?
> > 
> 
> Yep.
> 
> > 
> >>I don't really understand what you are asking though. Your basic
> >>problem is that mozilla's resident memory gets evicted too easily,
> >>is that right?
> >>
> > 
> > Not at all.My problem is mozilla has some MB to recover when
> > reactivating; meanwhile, I consider there was sufficient resource to
> > share with it _before_ reactivation as I'm waiting some minutes after an
> > heavy process (e.g updatedb) to be done and over.
> > 
> 
> You could try my -np7 patch, which would hopefully fix the problem
> for you.

Hi Nick:)
	 I've been busy benchmarking Con's autoregulation which _is_ proved
interesting in middle pressure.
AFAICS mm7np works that way : it cleans up memory brightly so we do see
attractive free memory available _but_ relevant rss doesn't move 1 byte
:( So we'll have foregrounding elevation for sure (no cleaning required)
but application still have to 'emerge' and that's the heavier side of
the story I'm afraid.

Regards,
FabF

