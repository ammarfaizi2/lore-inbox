Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291301AbSBGVEE>; Thu, 7 Feb 2002 16:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291307AbSBGVEA>; Thu, 7 Feb 2002 16:04:00 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:18951 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291301AbSBGVDC>;
	Thu, 7 Feb 2002 16:03:02 -0500
Date: Thu, 7 Feb 2002 14:02:19 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <akpm@zip.com.au>
Cc: yodaiken@fsmlabs.com, Ingo Molnar <mingo@elte.hu>,
        Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207140219.B23179@hq.fsmlabs.com>
In-Reply-To: <20020207125601.A21354@hq.fsmlabs.com> <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>, <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>; <20020207133109.B21935@hq.fsmlabs.com> <3C62EA2F.FDA9E241@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C62EA2F.FDA9E241@zip.com.au>; from akpm@zip.com.au on Thu, Feb 07, 2002 at 12:57:19PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 12:57:19PM -0800, Andrew Morton wrote:
> yodaiken@fsmlabs.com wrote:
> > 
> >         llseek:
> >                 atomic_enquee request
> >                 if no room gotta sleep
> >                 else if trylock mutex
> >                         return
> >                      else
> >                         do work
> >                         loop:
> >                              process any pending requests
> >                              release lock;
> >                              if pending_requests && !(trylock mutex) goto loop
> 
> This is how printk() works.  It was a very powerful and satisfactory
> solution to a nasty locking/atomicity problem.  It'd be nice to have
> a more generic way of expressing that solution.

note how I put in the goto so Ingo would be more happy with it -)

> 
> -

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

