Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318197AbSG2WcH>; Mon, 29 Jul 2002 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318198AbSG2WcH>; Mon, 29 Jul 2002 18:32:07 -0400
Received: from dsl-213-023-043-226.arcor-ip.net ([213.23.43.226]:12693 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318197AbSG2WcG>;
	Mon, 29 Jul 2002 18:32:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 1/13] misc fixes
Date: Tue, 30 Jul 2002 00:36:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207291751160.3086-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0207291751160.3086-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ZJ84-0004s4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 22:55, Rik van Riel wrote:
> On Mon, 29 Jul 2002, Andrew Morton wrote:
> 
> > At some point, when the reverse map is as CPU efficient as we can make
> > it, we need to decide whether the remaining cost is worth the benefit.
> > I wonder how to do that.
> 
> On a system which isn't swapping, the pte_chain based reverse
> maps will never be worth it.  However, it seems that well over
> 90% of Linux machines have data in swap ...

There is also the promise of being able to do active defragmentation, an 
enabler for large pages, which have been shown to significantly enhance 
performance due to reduced tlb pressure.

So the 'never will be worth it' case is limited to loads that don't create 
any tlb pressure and don't do any swapping or mmap IO.

-- 
Daniel
