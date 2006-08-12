Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWHLSJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWHLSJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWHLSJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 14:09:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5779 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030230AbWHLSJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 14:09:29 -0400
Subject: Re: [RFC][PATCH 3/4] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <40048.81.207.0.53.1155405282.squirrel@81.207.0.53>
References: <20060812141415.30842.78695.sendpatchset@lappy>
	 <20060812141445.30842.47336.sendpatchset@lappy>
	 <44640.81.207.0.53.1155403862.squirrel@81.207.0.53>
	 <1155404697.13508.81.camel@lappy>
	 <40048.81.207.0.53.1155405282.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 20:08:40 +0200
Message-Id: <1155406120.13508.87.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 19:54 +0200, Indan Zupancic wrote:
> On Sat, August 12, 2006 19:44, Peter Zijlstra said:
> > Euhm, right :-) long comes naturaly when I think about quantities op
> > pages. The adjust_memalloc_reserve() argument is an increment, a delta;
> > perhaps I should change that to long.
> 
> Maybe, but having 16 TB of reserved memory seems plenty for a while.

Oh, for sure, but since it doesn't really matter all that much, I'd
rather go for proper.

> > Having them separate would allow ajust_memalloc_reserve() to be used by
> > other callers too (would need some extra locking).
> 
> True, but currently memalloc_reserve isn't used in a sensible way,
> or I'm missing something.

Well, I'm somewhat reluctant to stick network related code into mm/, it
seems well separated now.


