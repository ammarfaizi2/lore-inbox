Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWCUMEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWCUMEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWCUMEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:04:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36768 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750736AbWCUMEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:04:51 -0500
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is
	default
From: Arjan van de Ven <arjan@infradead.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
In-Reply-To: <200603212258.46265.kernel@kolivas.org>
References: <20060320122449.GA29718@outpost.ds9a.nl>
	 <200603211409.50331.kernel@kolivas.org>
	 <20060321085352.GA17642@rhlx01.fht-esslingen.de>
	 <200603212258.46265.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:04:44 +0100
Message-Id: <1142942684.3077.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:58 +1100, Con Kolivas wrote:
> On Tuesday 21 March 2006 19:53, Andreas Mohr wrote:
> > (and the fact that invoking a function pointer should be similarly
> > expensive to a conditional) I don't think it's useful.
> 
> Is 
> 
> *blah();
> 
> as expensive as
> 
> if (conditional)
> 	blah();
> 
> I don't know the answer. I just know cmp is expensive. Comments?

function pointer is usually MORE expensive.
for if() the processor has a change to predict the branch right, while
call <register> (which is what function pointer calls end up being) are
basically always mispredicted unless you have a really really fancy
branch predictor... 

