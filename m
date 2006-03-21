Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWCUNyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWCUNyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWCUNyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:54:16 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:30950 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030384AbWCUNyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:54:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 00:53:52 +1100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <1142592375.7895.43.camel@homer> <20060321125900.GA25943@w.ods.org> <1142947456.7807.53.camel@homer>
In-Reply-To: <1142947456.7807.53.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220053.53595.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 00:24, Mike Galbraith wrote:
> On Tue, 2006-03-21 at 13:59 +0100, Willy Tarreau wrote:
> > That would suit me perfectly. I think I would set them both to zero.
> > It's not clear to me what workload they can help, it seems that they
> > try to allow a sometimes unfair scheduling.
>
> Correct.  Massively unfair scheduling is what interactivity requires.

To some degree, yes. Transient unfairness was all that it was supposed to do 
and clearly it failed at being transient. 

I would argue that good interactivity is possible with fairness by changing 
the design. I won't go there (to try and push it that is), though, as the 
opposition to changing the whole scheduler in place or making it pluggable 
has already been voiced numerous times over, and it would kill me to try and 
promote such an alternative ever again. Especially since the number of people 
willing to test interactive patches and report to lkml has dropped to 
virtually nil. 

The yardstick for changes is now the speed of 'ls' scrolling in the console. 
Where exactly are those extra cycles going I wonder? Do you think the 
scheduler somehow makes the cpu idle doing nothing in that timespace? Clearly 
that's not true, and userspace is making something spin unnecessarily, but 
we're gonna fix that by modifying the scheduler.... sigh

Cheers,
Con
