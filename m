Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVG3A6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVG3A6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVG3Ax3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:53:29 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:35680 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262760AbVG3AwK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:52:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q4+AoSSbZEteG2czxT1sVuwiPkKBDuKz+VXMNSUaY0A+0ioQM4ys4ZkmkfGt2OjvC44dyhyRQabYY2DsWvmb3OgTiSnrtSj6xEwBgIAcYq5+3sefbweDUTMVUufXU1mWFZBlABavSC8ri6IgoSyztZOxsSaVSUY8EqL4gGtntAw=
Message-ID: <86802c4405072917525cfacc38@mail.gmail.com>
Date: Fri, 29 Jul 2005 17:52:10 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <m1oe8lf7o9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	 <86802c44050728092275e28a9a@mail.gmail.com>
	 <86802c4405072810352d564fd3@mail.gmail.com>
	 <m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
	 <86802c4405072913415379c5a4@mail.gmail.com>
	 <m1oe8lf7o9.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will use linus's latest tree to have a try.

YH

On 7/29/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> yhlu <yhlu.kernel@gmail.com> writes:
> 
> > if using you patch, the
> > "synchronized TSC with CPU" never come out.
> >
> > then with your patch, I add back patch that moving set callin_map from
> > smp_callin to start_secondary. It told me can not inquire the apic for
> > the CPU 1....2....
> 
> Hmm.  You didn't post enough of a boot log for me to see the problem.
> Does it boot and you don't see the message or is it something
> else.
> 
> > Can we put tsc_sync_wait() back to smp_callin?
> >
> > So that it will be executed serially and we can get
> > "synchronized TSC with CPU"?
> 
> Currently that just seems silly.  That code should be async
> safe.
> 
> But it sounds like you have some weird bug I don't understand.
> 
> Eric
>
