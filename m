Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRC3Ouf>; Fri, 30 Mar 2001 09:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRC3Ou0>; Fri, 30 Mar 2001 09:50:26 -0500
Received: from [207.246.91.243] ([207.246.91.243]:1806 "HELO thor")
	by vger.kernel.org with SMTP id <S131468AbRC3OuM>;
	Fri, 30 Mar 2001 09:50:12 -0500
Date: Fri, 30 Mar 2001 09:48:18 -0500
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Michael Peddemors <michael@linuxmagic.com>
cc: David Konerding <dek_ml@konerding.com>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <20010330024815Z130448-406+5643@vger.kernel.org>
Message-ID: <Pine.SGI.4.10.10103300942140.14106-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just to throw my own observations into the war, I have to agree with David
K. here.  This needs to be some sort of module and/or interface.  Get the
policy into a replaceable user space module.

One of the hot areas for the kernel right now is for embedded systems.
They need an entirely different strategy than for a desk top.  I'm working
on such a thing now were we don't even have an enabled swap space and the
OOM is causing us no end of trouble as we start dipping below 1MB "free"
system memory.

On 29 Mar 2001, Michael Peddemors wrote:

> Looking over the last few weeks of postings, there are just WAY to many
> conflicting ways that people want the OOM to work..  Although an
> incredible amount of good work has gone into this, people are definetely
> not happy about the benifits of OOM ...  About 10 different approaches
> are being made to change the rule based systems pertaining to WHEN the
> OOM will fire, but in the end, still not everyone will be happy..

<SNIP>

> On 29 Mar 2001 07:41:44 -0800, David Konerding wrote:
> 
> > Now, if you're going to implement OOM, when it is absolutely necessary, at the very
> > least, move the policy implementation out of the kernel.  One of the general
> > philosophies of Linux has been to move policy out of the kernel.  In this case, you'd
> > just have a root owned process with locked pages that can't be pre-empted, which
> > implemented the policy.  You'll never come up with an OOM policy that will fit
> > everybody's needs unless it can be tuned for  particular system's usage, and it's
> > going to be far easier to come up with that policy if it's not in the kernel.

