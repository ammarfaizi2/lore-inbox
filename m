Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261164AbRESEt0>; Sat, 19 May 2001 00:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRESEtH>; Sat, 19 May 2001 00:49:07 -0400
Received: from www.wen-online.de ([212.223.88.39]:18951 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261164AbRESEtF>;
	Sat, 19 May 2001 00:49:05 -0400
Date: Sat, 19 May 2001 06:40:14 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <20010518235852.R8080@redhat.com>
Message-ID: <Pine.LNX.4.33.0105190543190.405-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Stephen C. Tweedie wrote:

> Hi,
>
> On Fri, May 18, 2001 at 07:44:39PM -0300, Rik van Riel wrote:
>
> > This is the core of why we cannot (IMHO) have a discussion
> > of whether a patch introducing new VM tunables can go in:
> > there is no clear overview of exactly what would need to be
> > tunable and how it would help.
>
> It's worse than that.  The workload on most typical systems is not
> static.  The VM *must* be able to cope with dynamic workloads.  You
> might twiddle all the knobs on your system to make your database run
> faster, but end up in such a situation that the next time a mail flood
> arrives for sendmail, the whole box locks up because the VM can no
> longer adapt.
>
> That's the main problem with static parameters.  The problem you are
> trying to solve is fundamentally dynamic in most cases (which is also
> why magic numbers tend to suck in the VM.)

Yup.  The problems are dynamic even with my static test load.

Off the top of my head, if I could make a suggestion to the vm it
would be something like "don't let dirty pages lay idle any longer
than this" and maybe "reclaim cleaned pages older than that".

	-Mike

