Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVG1BNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVG1BNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVG1BNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:13:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13211 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261246AbVG1BNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:13:13 -0400
To: ncunningham@cyclades.com
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [PATCH 1/23] Add missing device_suspsend(PMSG_FREEZE) calls.
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<1122400462.4382.13.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 27 Jul 2005 19:12:30 -0600
In-Reply-To: <1122400462.4382.13.camel@localhost> (Nigel Cunningham's
 message of "Wed, 27 Jul 2005 03:54:23 +1000")
Message-ID: <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> writes:

> Hi.
>
> Could you please send PMSG_* related patches to linux-pm at
> lists.osdl.org as well?

I'll try.  My goal was not to add or change not functionality but to
make what the kernel was already doing be consistent.

It turns out the device_suspend(PMSG_FREEZE) is a major pain
sitting in the reboot path and I will be submitting a patch to
remove it from the reboot path in 2.6.13 completely.

At the very least the ide driver breaks, and the e1000 driver
is affected.

And there is of course the puzzle of why there exists simultaneously
driver shutdown() and suspend(PMSG_FREEZE) methods as I believed they
are defined to do exactly the same thing.

Eric

