Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbREFG4G>; Sun, 6 May 2001 02:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132991AbREFGzq>; Sun, 6 May 2001 02:55:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45318 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132909AbREFGzp>; Sun, 6 May 2001 02:55:45 -0400
Date: Sun, 6 May 2001 10:55:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010506105519.A7562@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010504141240.A11122@twiddle.net> <20010505175547.A2302@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010505175547.A2302@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sat, May 05, 2001 at 05:55:47PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you do
> > (perhaps to coordinate with devices) then the barriers are required.
> 
> For IO space access mb's are required, but ll/sc are of no use, AFAIK.

Ugh. You are right, of course. I forgot that drivers are also using
atomic.h, and the intelligent device could be counted as another CPU
to some degree...

Thanks for the __builtin_expect fix!

Ivan.
