Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUCRVJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUCRVJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:09:07 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60644 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262963AbUCRVH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:07:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 18 Mar 2004 13:07:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
In-Reply-To: <20040318182407.GA1287@elte.hu>
Message-ID: <Pine.LNX.4.44.0403181302460.8512-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Ingo Molnar wrote:

> But how about the original issue Ulrich raised: how does user-space
> figure out the NR_CPUS value supported by the kernel? (not the current #
> of CPUs, that can be figured out using /proc/cpuinfo)

Why not a /proc/something? I mean, doesn't glibc already have to handle in 
some way kernels not exporting certain information (in the same way it 
does for missing VDSO)?


> Right now the VDSO mostly contains code and exception-handling data, but
> it could contain real, userspace-visible data just as much: info that is
> only known during the kernel build. There's basically no cost in adding
> more fields to the VDSO, and it seems to be superior to any of the other
> approaches. Is there any reason not to do it?

With /proc/something you can have a single piece of code for all archs 
that exports NR_CPUS. The VDSO should be added to all missing archs. IMO 
performance is not an issue in getting NR_CPUS from userspace.


- Davide


