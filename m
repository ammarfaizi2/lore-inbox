Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSHRSHt>; Sun, 18 Aug 2002 14:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSHRSHs>; Sun, 18 Aug 2002 14:07:48 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:24017 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315503AbSHRSHs>; Sun, 18 Aug 2002 14:07:48 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10208180215370.23171-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208180215370.23171-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 14:11:46 -0400
Message-Id: <1029694308.516.11.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 05:19, Andre Hedrick wrote:
> 
> 2.4.19-preempt
> 
> All bets are off because who knows what preempt is doing to the state
> machines and in PIO you are dead.
> 
> You can not delay transaction of data between interrupts w/o having the
> transport help out.  But the preempt don't get it.
> 
> If you push your request size down to 8k or to a page you preempt problems
> will go away, only because granularity of requests.  And the price is
> performance goes in the tank.  But this is preempt so who cares.
> 

OK, that makes some sense, at least more than removing devfs.  I'll not
compile in preempt and test to see if the problem still occurs.   As
soon as i figure out how to not use devfs i'll try it without that too. 



