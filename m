Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTEOB4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTEOB4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:56:06 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:26046 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S263652AbTEOB4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:56:04 -0400
Date: Wed, 14 May 2003 22:06:38 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030514205847.GA18514@bluemug.com>
Message-ID: <Pine.LNX.4.33.0305142149490.13035-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Mike Touloumtzis wrote:

> On Wed, May 14, 2003 at 06:34:30AM -0400, Ahmed Masud wrote:
> >
> I don't understand why people are willing to base security arguments
> > Level of security is a matter of trust.  Should the kernel trust a
> > distribution provider? No, that is not a reasonable request, because we do
> > not control their environment and evaluation proceedures and there are no
> > guarentees between the channel that provides the operating system to the
> > time it gets installed on a system.
>
> on some sort of bizarre adversarial relationship between the kernel and
> the system tools.
>
> No Unix (even a "secure" one) is designed to run all security-critical
> code in the kernel.  That would be a bad design anyway, since it would
> run lots of code at an unwarranted privilege level.  "login" is not
> part of the kernel.  "su" is not part of the kernel".  The boot loader
> is not part of the kernel.  And so on.

There no relationship in what I had said above and what you are saying
here.  When i state that you cannot trust the operating environment
user-space applications, i exactly mean that. It has nothing to do with
running su or login as part of the kernel.  On the contrary, I am even
actually saying they shouldn't even run with full root privileges on a
system? (ref. Linux capabilities interface).

>
> There is no issue of "trust" between the kernel and the distribution
> provider.  The distribution provider provides a system, which (like all
> Unix-derived systems) is modular and thus has multiple independent

Well ofcourse there is a degree of trust as soon as you accept a
particular vendor's distribution.  What i am suggesting is a mechanism to
throttle that trust as per the sensitivity of application, and the one
place you can do that effectively is the kernel.

> components with security functions.  The sum of those parts is what you
> should evaluate for security.  Yes, the system should include proper
> isolation mechanisms to prevent improper privilege escalations.  But it
> doesn't make sense to even think about what the kernel should do when
> the untrusted distribution provides a malicious "/sbin/init".

We don't want to just deal with "improper" escalations, rather we want to
deal with realtime decisions on what may be the "proper" escalation or
deescalation along the timeline of running system.

Not sure if what i am attempting to say is clear from above, but i am not
suggesting about moving any thing from userspace into kernel space. I am
just suggesting that the kernel should provide non binary throttling of
the level of trust that may be placed in various components that interact
with it.

Ahmed.

