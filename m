Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWHVOCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWHVOCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWHVOCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:02:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22722 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932262AbWHVOCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:02:06 -0400
Date: Tue, 22 Aug 2006 19:31:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060822140124.GC7125@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <1156245036.6482.16.camel@Homer.simpson.net> <20060822101028.GB5052@in.ibm.com> <1156257674.4617.8.camel@Homer.simpson.net> <1156260209.6225.7.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156260209.6225.7.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 03:23:29PM +0000, Mike Galbraith wrote:
> > I try it with everything in either root or mikeg.

How did you transfer everything to root? By cat'ing each task pid
(including init's) to root (or mikeg) task's file?

I will give your experiment a try here and find out what's happening.

You said that you spawn a task which munches ~80% cpu. Is that by
something like:

do {
	gettimeofday(&t1, NULL);
loop:
	gettimeofday(&t2, NULL);
	while (t2.tv_sec - t1.tv_sec != 48)
		goto loop;
	sleep 12

} while (1);
	

> That didn't work.

Ok. I will repeat your experiment and see what I can learn from it.


-- 
Regards,
vatsa
