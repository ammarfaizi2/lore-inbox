Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUFDJKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUFDJKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUFDJKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:10:44 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:2353 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263740AbUFDJKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:10:43 -0400
Date: Fri, 4 Jun 2004 02:14:50 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604021450.2894c6a9.pj@sgi.com>
In-Reply-To: <20040604081906.GR21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040604081906.GR21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
On Thu, Jun 03, 2004 at 10:10:10AM -0700, Paul Jackson wrote:
> > +static inline void __cpu_set(int cpu, volatile cpumask_t *dstp)
> > ...
> Hungarian notation?

You mean the 'p' for pointer?  Well, loosely speaking, I guess you could
call it that.  Why do you ask?

Well ... I am not being straight forward.  I likely know why you ask.  I
find an occassional 'p' in a variable name to be helpful.  For example,
in this case, I am flipping between referring to the same datum by
reference and by value - so it is useful to reflect that distinction in
the variable names - it's _the_ key distinction.  If you wish to state a
case to the contrary, you're welcome to do so.

> #ifdef'ing it anyway?

In certain cases, yes.  I had a version of these particular macros that
used inline logic instead, but this looked easier to read to my eye.  If
I spoke out against ifdef's carte blanche at some point (which likely I
did) then I was being incautious in my speaking.  The question is more
how best to make the code readable, maintainable, robust, fast and small.

> This is an improvement?

... see Keith's reply ...

Thank-you for your review comments.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
