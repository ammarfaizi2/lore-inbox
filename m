Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUGBGUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUGBGUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 02:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUGBGUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 02:20:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:51687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266308AbUGBGUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 02:20:49 -0400
Date: Thu, 1 Jul 2004 23:18:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: karim@opersys.com
Cc: peterm@redhat.com, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com, trz@us.ibm.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: [PATCH] IA64 audit support
Message-Id: <20040701231844.0aed5201.akpm@osdl.org>
In-Reply-To: <40E4D4AD.2020302@opersys.com>
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
	<20040701124644.5e301ca0.akpm@osdl.org>
	<40E4B20F.8010503@opersys.com>
	<20040701182954.43351d36.akpm@osdl.org>
	<40E4D4AD.2020302@opersys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour <karim@opersys.com> wrote:
>
> > Developer support tools are good, but are not as persuasive as end-user
> > features.  Because the audience is smaller, and developers know how to
> > apply patches and rebuild stuff.
> 
> This is probably one of the biggest misconception about LTT amongst kernel
> developers. So let me present this once more: LTT is _NOT_ for kernel
> developers, it has never been developed with this crowd in mind. LTT is and
> has _ALWAYS_ been intended for the end user.

Note I said "developer", not "kernel developer".  If the audience for a
feature is kernel developers, userspace developers and perhaps the most
sophisticated sysadmins then that's a small audience.  It's certainly an
_important_ audience, but the feature is not as important as those
codepaths which Uncle Tillie needs to run his applications.

> Again, LTT is of marginal use to kernel developers, the benefits all go
> to the end users' ability to understand what's going on in their system (see
> above for examples.)

To me, an "end user" is one who is capable of identifying the power switch
and the ANY key, not an application programmer!

> On the topic of maintenance cost, I fail to see how one-liners such as the
> above can be of any burden to any kernel developer, they have remained
> virtually unchanged for the past 5 years and any look throughout the LTT
> archives or the kernel mailing list archive for LTT patches will readily
> show this.

Fair enough.

> > If it could use kprobes hooks that'd be neat.  kprobes is low-impact.
> 
> The issues about the spread of trace points across the source code are
> exactly the same, you still need to mark the code-paths (and maintain
> these markings for each version) regardless of the mechanism being used.

Nope, kprobes allows a kernel module to patch hooks into the running
binary.  That's all it does, really.   See
http://www-124.ibm.com/linux/projects/kprobes/

