Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVFVSBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVFVSBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVFVSBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:01:13 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:43451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261785AbVFVSAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:00:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HdzhRHkVC2aCDVekZBAYa50mkn/SYMz6llLALxt2XkwFokIyeF9fLaDpJaMoHmHdx/3JDkb3inTAVplJ3vfCx04zntIwl2oVemn0SxDa3TzG8vlB2cJhIzhplIMSpXrEc9pvMftPzZBck91jNOW2RNz1T5zu+QP3HwxmatK2viU=
Message-ID: <29495f1d050622110076569807@mail.gmail.com>
Date: Wed, 22 Jun 2005 11:00:09 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: -mm -> 2.6.13 merge status
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d050621115636bc6f77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <1119369028.19357.28.camel@mindpipe>
	 <29495f1d050621115636bc6f77@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On 6/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2005-06-20 at 23:54 -0700, Andrew Morton wrote:
> > > CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ
> > > Kconfigurable.
> > >
> > >     Will merge (will switch default to 1000 Hz later if that seems
> > > necessary)
> >
> > Are you serious?  You're changing the *default* HZ in a stable kernel
> > series?!?
> >
> > This is a big regression, it degrades the resolution of system calls.
> 
> Not that my opinion should sway anybody else, but I really would
> prefer more of the in-kernel sleep callers were converted to use
> human-time units (and thus were verified to be correct) so that
> switching HZ will result in the *same* latencies. How much of moving
> to lower HZ values is due to the fact that everything is request 10ms
> for 1 jiffy of sleep instead of 1 ms? It's hard to tell if the gain is
> there or from the lower frequency of interrupts.

After some further consideration, I don't think that my patches would
be at all changed by adjusting HZ's default value. I just want to make
sure maintainers are still responsive to appropriate patches to split
time-based delays from tick-based delays. So, CONFIG_HZ is ok by me,
but I consider it a band-aid.

Thanks,
Nish
