Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTEONFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTEONFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:05:53 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:8446 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264007AbTEONFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:05:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mike Touloumtzis <miket@bluemug.com>
Subject: Re: The disappearing sys_call_table export.
Date: Thu, 15 May 2003 08:17:41 -0500
X-Mailer: KMail [version 1.2]
Cc: Ahmed Masud <masud@googgun.com>, Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
References: <20030514074403.GA18152@bluemug.com> <20030514205847.GA18514@bluemug.com> <Pine.LNX.4.53.0305141724220.12328@chaos>
In-Reply-To: <Pine.LNX.4.53.0305141724220.12328@chaos>
MIME-Version: 1.0
Message-Id: <03051508174100.25285@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 May 2003 16:32, Richard B. Johnson wrote:
> On Wed, 14 May 2003, Mike Touloumtzis wrote:
> > On Wed, May 14, 2003 at 06:34:30AM -0400, Ahmed Masud wrote:
> > > Level of security is a matter of trust.  Should the kernel trust a
> > > distribution provider? No, that is not a reasonable request, because we
> > > do not control their environment and evaluation proceedures and there
> > > are no guarentees between the channel that provides the operating
> > > system to the time it gets installed on a system.
> >
> > I don't understand why people are willing to base security arguments
> > on some sort of bizarre adversarial relationship between the kernel and
> > the system tools.
> >
> > No Unix (even a "secure" one) is designed to run all security-critical
> > code in the kernel.  That would be a bad design anyway, since it would
> > run lots of code at an unwarranted privilege level.  "login" is not
> > part of the kernel.  "su" is not part of the kernel".  The boot loader
> > is not part of the kernel.  And so on.
> >
> > There is no issue of "trust" between the kernel and the distribution
> > provider.  The distribution provider provides a system, which (like all
> > Unix-derived systems) is modular and thus has multiple independent
> > components with security functions.  The sum of those parts is what you
> > should evaluate for security.  Yes, the system should include proper
> > isolation mechanisms to prevent improper privilege escalations.  But it
> > doesn't make sense to even think about what the kernel should do when
> > the untrusted distribution provides a malicious "/sbin/init".
>
> Not even malicious. For years, it was accepted that if you had
> physical possesion of a computing system, you could do anything
> with it that it was capable of.
>
> Not so, with the latest Red Hat distribution (9). You can no longer
> set init=/bin/bash at the boot prompt.... well you can set it, but
> then you get an error about killing init. This caused a neighbor
> a lot of trouble when she accidentally put a blank line in the
> top of /etc/passwd. Nobody could log-in. I promised to show her
> how to "break in", but I wasn't able to. I had to take her hard-disk
> to my house, mount it, and fix the password file. All these "attempts"
> at so-called security do is make customers pissed.

I fix those errors with by booting the Slackware CD with the live 
filesystem...

No dependancies on any of the regular disks - then I can fix anything within
reason (haven't tried md raids though).
