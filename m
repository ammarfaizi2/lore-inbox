Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWCANN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWCANN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCANN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:13:57 -0500
Received: from gold.veritas.com ([143.127.12.110]:13873 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932206AbWCANN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:13:56 -0500
X-IronPort-AV: i="4.02,156,1139212800"; 
   d="scan'208"; a="56463164:sNHT29984276"
Date: Wed, 1 Mar 2006 13:14:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: [PATCH] proc: task_mmu bug fix.
In-Reply-To: <m1oe0qnxdi.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0603011310160.10154@goblin.wat.veritas.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
 <20060228181849.faaf234e.pj@sgi.com> <20060228183610.5253feb9.akpm@osdl.org>
 <20060228194525.0faebaaa.pj@sgi.com> <20060228201040.34a1e8f5.pj@sgi.com>
 <m1irqypxf5.fsf@ebiederm.dsl.xmission.com> <20060228212501.25464659.pj@sgi.com>
 <m1u0aiocc1.fsf_-_@ebiederm.dsl.xmission.com> <20060228234628.55ee9f76.akpm@osdl.org>
 <m1oe0qnxdi.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Mar 2006 13:13:56.0234 (UTC) FILETIME=[FEB0F6A0:01C63D31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> >
> > Thanks.  Do you think this is likely to fix the crashes reported by
> > Laurent, Jesper, Paul, Rafael and Martin?
> 
> So I haven't tracked down all of the bug reports yet.  But the
> few bits I have seen make it likely.  First the task_mmu change
> was one of the largest change in logic I had to make.  Second
> the ugly bug reports seem to be about an extra decrement.  Third
> it seems to be my task_ref work that is the most implicated.

I was getting the same bootup __put_task_struct symptoms as Rafael,
and this patch fixes those nicely: looks stable now, thanks Eric.

Hugh
