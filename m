Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264902AbSJVSkv>; Tue, 22 Oct 2002 14:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSJVSkv>; Tue, 22 Oct 2002 14:40:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46524 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264902AbSJVSkp>;
	Tue, 22 Oct 2002 14:40:45 -0400
To: Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
In-reply-to: Your message of Tue, 22 Oct 2002 10:09:47 PDT.
             <3DB5865B.4462537F@digeo.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6644.1035312307.1@us.ibm.com>
Date: Tue, 22 Oct 2002 11:45:11 -0700
Message-Id: <E18441g-0001jW-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DB5865B.4462537F@digeo.com>, > : Andrew Morton writes:
> Rik van Riel wrote:
> > 
> > ...
> > In short, we really really want shared page tables.
> 
> Or large pages.  I confess to being a little perplexed as to
> why we're pursuing both.

Large pages benefit the performance of large applications which
explicity take advantage of them (at least today - maybe in the
future, large pages will be automagically handed out to those that
can use them).  And, as a side effect, they reduce KVA overhead.
Oh, and at the moment, they are non-pageable, e.g. permanently stuck
in memory.

On the other hand, shared page tables benefit any application that
shares data, including those that haven't been trained to roll over
and beg for large pages.  Shared page tables are already showing large
space savings with at least one database.

gerrit
