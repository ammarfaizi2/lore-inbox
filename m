Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVI0JWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVI0JWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVI0JWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:22:52 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:25477 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964877AbVI0JWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=wNdGK8TQkCFLCf0lIkeBqzGia+IyH9jb/MLmuJQ2VguxZoeLGcfjk9kYNxc0fCyqmLRgluI7HLN0Kr7bkKcP8D3asegc5TuZscqnc81K4y/NOpJt0KILBF/p8+tds4ZlrcG4OkcepGC5QyenkIGrCCEA/1V/cTADvNR5RDDxJO8=  ;
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: KUROSAWA Takahiro <kurosawa@valinux.co.jp>, taka@valinux.co.jp,
       magnus.damm@gmail.com, dino@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20050927013751.47cbac8b.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	 <20050909.203849.33293224.taka@valinux.co.jp>
	 <20050909063131.64dc8155.pj@sgi.com>
	 <20050910.161145.74742186.taka@valinux.co.jp>
	 <20050910015209.4f581b8a.pj@sgi.com>
	 <20050926093432.9975870043@sv1.valinux.co.jp>
	 <20050927013751.47cbac8b.pj@sgi.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 19:22:17 +1000
Message-Id: <1127812937.5174.6.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 01:37 -0700, Paul Jackson wrote:

> You will need to encourage someone else, with scheduler expertise,
> to review that portion of the patch.  The kernel/sched.c file is
> too hard for me; I stick to easier files such as kernel/cpuset.c.
> 
> I continue to be quite suspicious that perhaps there should be a
> tighter relation between your work and CKRM.  For one thing, I suspect
> that CKRM has a cpu controller that serves essentially the same purpose
> as yours.  If that is so, I cannot imagine that we would ever put both
> cpu controllers in the kernel.  They touch on code that is changing too
> rapidly, and too critical for performance.
> 
> My wild guess would be that the right answer would be to take the
> CKRM cpu controller instead of yours, and connect it to cpusets in the
> manner that you have done here.  But I have no expertise in cpu
> controllers, so am quite unfit to judge which one or the other, or
> perhaps some combination of the two cpu controllers, is the best one.
> 

Last time I looked at the CKRM cpu controller code I found
it was quite horrible, with a great deal of duplication and
very intrusive large and complex.

It could have come a long way since then, but this code looks
much neater than the code I reviewed.

I guess the question of the resource controller stuff is going
to come up again sooner or later. I would hope to have just a
single CPU resource controller (presumably based on cpusets),
the simpler the better ;)

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
