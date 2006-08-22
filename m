Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWHVP5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWHVP5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWHVP5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:57:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:22730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751398AbWHVP5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:57:00 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060822135056.GB7125@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
	 <1156245036.6482.16.camel@Homer.simpson.net>
	 <20060822101028.GB5052@in.ibm.com>
	 <1156257674.4617.8.camel@Homer.simpson.net>
	 <1156260209.6225.7.camel@Homer.simpson.net>
	 <1156261506.6319.6.camel@Homer.simpson.net>
	 <20060822135056.GB7125@in.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 18:05:31 +0000
Message-Id: <1156269931.4954.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 19:20 +0530, Srivatsa Vaddagiri wrote:
> On Tue, Aug 22, 2006 at 03:45:05PM +0000, Mike Galbraith wrote:
> > > With only cpu 1 in the cpuset, it worked.
> > 
> > P.S.  since it worked, (and there are other tasks that I assigned on it,
> > kthreads for example, I only assigned the one shell), I figured I'd try
> > adding the other cpu and see what happened.  It let me hot add cpu 0,
> > but tasks continue to be run only on cpu 1.
> 
> How did you add the other cpu? to the "all" cpuset? I don't think I am
> percolating the changes to "cpus" field of parent to child cpuset, which
> may explain why tasks continue to run on cpu0. Achieving this change
> atomically for all child cpusets again is something I don't know whether
> cpuset code can handle well.

I just did echo "0-1" > cpus.

	-Mike

