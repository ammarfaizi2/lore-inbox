Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbRERXBh>; Fri, 18 May 2001 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbRERXB1>; Fri, 18 May 2001 19:01:27 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:61046 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261598AbRERXBT>; Fri, 18 May 2001 19:01:19 -0400
Date: Fri, 18 May 2001 23:58:52 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Linux 2.4.4-ac10
Message-ID: <20010518235852.R8080@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0105182153570.387-100000@mikeg.weiden.de> <Pine.LNX.4.21.0105181941070.5531-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105181941070.5531-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Fri, May 18, 2001 at 07:44:39PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 18, 2001 at 07:44:39PM -0300, Rik van Riel wrote:

> This is the core of why we cannot (IMHO) have a discussion
> of whether a patch introducing new VM tunables can go in:
> there is no clear overview of exactly what would need to be
> tunable and how it would help.

It's worse than that.  The workload on most typical systems is not
static.  The VM *must* be able to cope with dynamic workloads.  You
might twiddle all the knobs on your system to make your database run
faster, but end up in such a situation that the next time a mail flood
arrives for sendmail, the whole box locks up because the VM can no
longer adapt.

That's the main problem with static parameters.  The problem you are
trying to solve is fundamentally dynamic in most cases (which is also
why magic numbers tend to suck in the VM.)

Cheers, 
 Stephen
