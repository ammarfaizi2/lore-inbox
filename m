Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWHVNvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWHVNvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWHVNvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:51:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:23211 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932256AbWHVNvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:51:37 -0400
Date: Tue, 22 Aug 2006 19:20:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060822135056.GB7125@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <1156245036.6482.16.camel@Homer.simpson.net> <20060822101028.GB5052@in.ibm.com> <1156257674.4617.8.camel@Homer.simpson.net> <1156260209.6225.7.camel@Homer.simpson.net> <1156261506.6319.6.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156261506.6319.6.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 03:45:05PM +0000, Mike Galbraith wrote:
> > With only cpu 1 in the cpuset, it worked.
> 
> P.S.  since it worked, (and there are other tasks that I assigned on it,
> kthreads for example, I only assigned the one shell), I figured I'd try
> adding the other cpu and see what happened.  It let me hot add cpu 0,
> but tasks continue to be run only on cpu 1.

How did you add the other cpu? to the "all" cpuset? I don't think I am
percolating the changes to "cpus" field of parent to child cpuset, which
may explain why tasks continue to run on cpu0. Achieving this change
atomically for all child cpusets again is something I don't know whether
cpuset code can handle well.

-- 
Regards,
vatsa
