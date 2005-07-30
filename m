Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVG3AlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVG3AlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVG3AlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:41:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8845 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261512AbVG3AkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:40:13 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	<86802c44050728092275e28a9a@mail.gmail.com>
	<86802c4405072810352d564fd3@mail.gmail.com>
	<m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
	<86802c4405072913415379c5a4@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 18:40:06 -0600
In-Reply-To: <86802c4405072913415379c5a4@mail.gmail.com> (yhlu.kernel@gmail.com's
 message of "Fri, 29 Jul 2005 13:41:06 -0700")
Message-ID: <m1oe8lf7o9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yhlu.kernel@gmail.com> writes:

> if using you patch, the
> "synchronized TSC with CPU" never come out.
>
> then with your patch, I add back patch that moving set callin_map from
> smp_callin to start_secondary. It told me can not inquire the apic for
> the CPU 1....2....

Hmm.  You didn't post enough of a boot log for me to see the problem.
Does it boot and you don't see the message or is it something
else.

> Can we put tsc_sync_wait() back to smp_callin?
> 
> So that it will be executed serially and we can get
> "synchronized TSC with CPU"?

Currently that just seems silly.  That code should be async
safe.

But it sounds like you have some weird bug I don't understand.

Eric
