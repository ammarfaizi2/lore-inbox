Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVG2Uop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVG2Uop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVG2UnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:43:17 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:10957 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262786AbVG2Ulm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:41:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=muhB7M8dV1l1k4FCFIE6DMpeDmXoOAV346ydQUbuRKFpnCXagL9INfF1lXRtW2H6IhNsAc70zqPJ0vEQ36DjjzR/E6FUiZuFLLErB039NaFu7vV/Uny5uRstbQda9EJessTDFpr8omF4nlRBIsEnn2g7bXlyfS+bXgxyxbJzpLI=
Message-ID: <86802c4405072913415379c5a4@mail.gmail.com>
Date: Fri, 29 Jul 2005 13:41:06 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	 <86802c44050728092275e28a9a@mail.gmail.com>
	 <86802c4405072810352d564fd3@mail.gmail.com>
	 <m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if using you patch, the
"synchronized TSC with CPU" never come out.

then with your patch, I add back patch that moving set callin_map from
smp_callin to start_secondary. It told me can not inquire the apic for
the CPU 1....2....

YH

Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 3600.30 BogoMIPS (lpj=7200601)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 1415 cycles)
On 7/28/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> yhlu <yhlu.kernel@gmail.com> writes:
> 
> > I have some problem with this patch.
> >
> > YH
> >
> > On 7/28/05, yhlu <yhlu.kernel@gmail.com> wrote:
> >> Do you mean solve the timing problem for 2 way dual core or 4 way
> >> single core above?
> 
> As best as I can determine the problem is possible any time
> you have more than 2 cpus (from the kernels perspective),
> but you have ti hit a fairly narrow window in cpu start up.
> 
> What problem do you have with this patch.
> 
> Eric
>
