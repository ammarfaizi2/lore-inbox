Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHRS1b>; Sun, 18 Aug 2002 14:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSHRS1b>; Sun, 18 Aug 2002 14:27:31 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:60867 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315690AbSHRS13>; Sun, 18 Aug 2002 14:27:29 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10208180215370.23171-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208180215370.23171-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 14:31:30 -0400
Message-Id: <1029695490.1357.8.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preempt doesn't seem to be the culprit.  Reran the test without using
preempt and I got MEMORY errors within 22 seconds at udma2.  So preempt
is not the problem here.  



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




