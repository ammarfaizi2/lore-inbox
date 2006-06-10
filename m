Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWFJHwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWFJHwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWFJHwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:52:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4036 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932444AbWFJHwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 03:52:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605144328.GA12904@sergelap.austin.ibm.com>
	<m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
	<20060609232551.GA11240@sergelap.austin.ibm.com>
	<m1k67p6dz7.fsf@ebiederm.dsl.xmission.com>
	<20060610012314.GA2378@sergelap.austin.ibm.com>
Date: Sat, 10 Jun 2006 01:52:03 -0600
In-Reply-To: <20060610012314.GA2378@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 9 Jun 2006 20:23:14 -0500")
Message-ID: <m1y7w54fdo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Egads, I apologize.
>
> Apparently I was in a daze, as I'd forgotten that converting
> all kernel_thread users to kthread was something else we wanted
> to work towards, and which Christoph had explicitly asked for
> help with.

Yep.  And the linux-vserver guys discovered the hard way.

>> Ok a couple of comments.
>> 
>> As I recall there are some pretty sane ways of going
>> from struct pid to a task_struct and then we can use things
>> like group_send_sig.
>
> Oh, you mean instead of doing kill_proc(struct pid->nr), which
> I guess was pretty braindead?  :)

I think it defeats half our purpose.

> Ok, futile as this may have seemed overall, I think it's helped
> me figure out what to actually do.

Sure and that is what it was aimed to do.

You want to attack the kernel_thread -> kthread thing?

Eric
