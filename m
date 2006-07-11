Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWGKG6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWGKG6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWGKG6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:58:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62901 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965046AbWGKG6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:58:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<20060710211951.7bf8320b.akpm@osdl.org>
Date: Tue, 11 Jul 2006 00:57:35 -0600
In-Reply-To: <20060710211951.7bf8320b.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 10 Jul 2006 21:19:51 -0700")
Message-ID: <m1bqrwiq74.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Mon, 10 Jul 2006 16:38:59 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Since sys_sysctl is deprecated start allow it to be compiled out.
>
> This could be a tough one to get rid of (looks at sys_bdflush() again).
>
> I'd suggest we put a sys_bdflush()-style warning in there, see what that
> flushes out.

Sounds sane.  I know I have booted several kernels with it compiled out
but just because you can do without it doesn't mean that something
isn't using it.

Hmm.  The question is where do I want the put the warning message?

When the code is compiled out?
When the code is compiled in?

Probably both places at this point, and using the rate limited printk
I think instead of just the 5 printks that sys_bdflush uses...

I will cook up an incremental patch once I get some sleep.

Eric

