Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTENKYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTENKYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:24:00 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:18619 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S261808AbTENKX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:23:57 -0400
Date: Wed, 14 May 2003 06:34:30 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030514074403.GA18152@bluemug.com>
Message-ID: <Pine.LNX.4.33.0305140608070.10480-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, Mike Touloumtzis wrote:

> It's the distribution that must be made secure, not just the kernel.
> And a secure distribution wouldn't nuke its own version of swapoff.
>

This is not a reply in particular to swapon swapoff issue that preceeded
the above, but a general comment about security since there seem to be
misconceptions about who should be responsible for it.

Level of security is a matter of trust.  Should the kernel trust a
distribution provider? No, that is not a reasonable request, because we do
not control their environment and evaluation proceedures and there are no
guarentees between the channel that provides the operating system to the
time it gets installed on a system.

In a secure environment, trusting _any_ user-space application or
combination of user-space applications, is a poor approach to security.
(I refer you to bind, openssl, sendmail, apache and a gazillion other
userspace applications which have exhibited security flaws).

For that matter, trusting the entire kernel also has its flaws (i refer
to the silly ptrace bug found not too long ago in the 2.4.x series).

[Sufficient] security is the state where we can fundamentally guard
against any deliberate sabotage or unintentional mistakes in the
environment.

A reasonable approach to achieving this is to provide a controlled
(single!?) point of evaluation because it is far less likely that issues
with such a controlled point of evaluation for all security will go
unnoticed.

Firewalls are a good example of this. Since we don't trust users on an
internal network to be able to create secure environements individually
w.r.t. the outside world, we create a single point of evaluation into it
through a firewall. Similarly, a good security system will treat anything
comming into it as not particularly trustable untless otherwise proven.
(Guilty until proven innocent approach works *teehee*)


Cheers,

Ahmed.


