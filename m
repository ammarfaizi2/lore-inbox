Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSGZJUg>; Fri, 26 Jul 2002 05:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSGZJUf>; Fri, 26 Jul 2002 05:20:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22173 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317424AbSGZJUf>; Fri, 26 Jul 2002 05:20:35 -0400
Date: Fri, 26 Jul 2002 14:53:44 +0530
From: Kiran <geekazoid@phreaker.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch 2.5.25: Ensure xtime_lock and timerlist_lock are on difft cachelines
Message-ID: <20020726145344.A18568@phreaker.net>
References: <20020726125605.A2822@phreaker.net> <20020726080211.3E71E4824@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020726080211.3E71E4824@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Jul 26, 2002 at 05:56:19PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 05:56:19PM +1000, Rusty Russell wrote:
> In message <20020726125605.A2822@phreaker.net> you write:
> > This patch was not meant to be a definitive fix for do_gettimeofday.
> > I thought having diffrent locks  on the same cacheline was bad. Atleast, 
> > I don't think there'd be any negative performance impact due to my patch.  
> > Pls correct me if I am wrong. 
> 
> Did you ever wonder why we don't declare spinlock to be ____cacheline_aligned?

Yep...and for long enough...(I think..)..or there'd have been an RFC 
or a stupid question to lkml sometime from me :)

> While it's probably justified in this case, you pay for it in a slight
> increase in size...
>

I thought you were of the opinion that "memory is cheap" ;-)

-Kiran
