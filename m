Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280372AbRKEInu>; Mon, 5 Nov 2001 03:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280373AbRKEInj>; Mon, 5 Nov 2001 03:43:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:23052 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280372AbRKEInY>; Mon, 5 Nov 2001 03:43:24 -0500
Message-ID: <3BE64FE3.DBEF8E21@zip.com.au>
Date: Mon, 05 Nov 2001 00:37:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5-preempt, overflow in cached memory stat?
In-Reply-To: <Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz>,
		<Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz> <1004948146.806.4.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> > PS I know you keep hearing this, but that preempt patch makes for some
> > damn smooth interactive performance ;)
> 
> I can't hear it enough :)
> 

umm...  Look.  Sorry.  But I don't see any theoretical reason
why interactivity should be noticeably different from the
little patch at

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre7aa2/00_lowlatency-fixes-2

and I did some quantitative testing a week or so back which
bears this out.  With either patch, worst-case latencies
are very rare, and very bad.   Usual latencies are excellent.

Is there any reason why preempt should be noticeably better than
that little patch?  If it is, then where on earth are the
problematic commonly-occuring, long-running, lock-free code paths?

-
