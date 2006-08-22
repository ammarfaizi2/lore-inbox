Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWHVPwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWHVPwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHVPwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:52:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:52453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751346AbWHVPwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:52:31 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060822140124.GC7125@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
	 <1156245036.6482.16.camel@Homer.simpson.net>
	 <20060822101028.GB5052@in.ibm.com>
	 <1156257674.4617.8.camel@Homer.simpson.net>
	 <1156260209.6225.7.camel@Homer.simpson.net>
	 <20060822140124.GC7125@in.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 18:01:01 +0000
Message-Id: <1156269661.4954.6.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 19:31 +0530, Srivatsa Vaddagiri wrote:
> On Tue, Aug 22, 2006 at 03:23:29PM +0000, Mike Galbraith wrote:
> > > I try it with everything in either root or mikeg.
> 
> How did you transfer everything to root? By cat'ing each task pid
> (including init's) to root (or mikeg) task's file?

Yes.

> I will give your experiment a try here and find out what's happening.
> 
> You said that you spawn a task which munches ~80% cpu. Is that by
> something like:
> 
> do {
> 	gettimeofday(&t1, NULL);
> loop:
> 	gettimeofday(&t2, NULL);
> 	while (t2.tv_sec - t1.tv_sec != 48)
> 		goto loop;
> 	sleep 12
> 
> } while (1);

Yeah, a sleep/burn loop.  The proggy is a one of several scheduler
exploits posted to lkml over the years.  The reason I wanted to test
this patch set was to see how well it handles various nasty loads.

	-Mike

