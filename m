Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270171AbRHWTfr>; Thu, 23 Aug 2001 15:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270194AbRHWTfb>; Thu, 23 Aug 2001 15:35:31 -0400
Received: from [195.211.46.202] ([195.211.46.202]:42834 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S270171AbRHWTfM>;
	Thu, 23 Aug 2001 15:35:12 -0400
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Tue, 21 Aug 2001 09:17:00 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.30.0108182231030.31188-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0108210911350.28862-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Oliver Xymoron wrote:
> > > On 18 Aug 2001, Robert Love wrote:
> > > > obviously some people fear NICs feeding entropy provides a hazard.  for
> > > > those who dont, or are increadibly low on entropy, enable the
> > > > configuration option.
> The network is still feeding data to the pool, yes? It's merely
> underestimating the value of that data. If you think you're getting enough
> entropy for your application, use /dev/urandom, don't weaken /dev/random.

Read it the other way around:
He fixed a bug where some network devices where feeding the pool illegally
and making your system "unsecure". The "bug-fix" is configurable so you
can choose for yourself, if you want to have the "old broken unsecure"
bahaviour or you want to disable all entropy feeding by NICs and want your
processes get stuck when reading /dev/random.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

