Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278104AbRJRTpb>; Thu, 18 Oct 2001 15:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278105AbRJRTpV>; Thu, 18 Oct 2001 15:45:21 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:5127 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S278104AbRJRTpJ>; Thu, 18 Oct 2001 15:45:09 -0400
Date: Thu, 18 Oct 2001 15:45:42 -0400
From: Bill Davidsen <davidsen@deathstar.prodigy.com>
Message-Id: <200110181945.f9IJjg106861@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20011017004839.A15996@earthlink.net>
Organization: Prodigy http://www.prodigy.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011017004839.A15996@earthlink.net> rwhron@earthlink.net wrote:
>On Wed, Oct 17, 2001 at 04:31:03AM +0200, Andrea Arcangeli wrote:
>> I noticed that anotehr thing that changed between vanilla 2.4.13pre2 and
>> 2.4.13pre3 is the setting of page_cluster on machine with lots of ram.
>> 
>> You'll now find the page_cluster set to 6, that means "1 << 6 << 12"
>> bytes will be paged in at each major fault, while previously only "1 <<
>> 4 << 12" bytes were paged in.
>> 
>> So I'd suggest to try again after "echo 4 > /proc/sys/vm/page-cluster"
>> to see if it makes any difference.
>> 
>> Andrea
>
>You Rule!
>
>The tweak to page-cluster is basically magic for this test.

Out of curiousity, did you play with the 'preempt' patch at all?

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
