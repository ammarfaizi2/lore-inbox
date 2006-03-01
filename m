Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWCANAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWCANAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWCANAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:00:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14571 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932106AbWCANAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:00:36 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: [PATCH] proc: task_mmu bug fix.
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<m1u0aiocc1.fsf_-_@ebiederm.dsl.xmission.com>
	<20060228234628.55ee9f76.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Mar 2006 05:49:13 -0700
In-Reply-To: <20060228234628.55ee9f76.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 28 Feb 2006 23:46:28 -0800")
Message-ID: <m1oe0qnxdi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> This should fix the big bug that has been crashing kernels when
>>  fuser is called.  At least it is the bug I observed here.  It seems
>>  you need the right access pattern on /proc/<pid>/maps to trigger this.
>
> Thanks.  Do you think this is likely to fix the crashes reported by
> Laurent, Jesper, Paul, Rafael and Martin?

So I haven't tracked down all of the bug reports yet.  But the
few bits I have seen make it likely.  First the task_mmu change
was one of the largest change in logic I had to make.  Second
the ugly bug reports seem to be about an extra decrement.  Third
it seems to be my task_ref work that is the most implicated.

I will certainly follow and see what I can do to confirm that I have
gotten everything.

Eric
