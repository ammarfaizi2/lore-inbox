Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCRUtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbUCRUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:49:22 -0500
Received: from [209.195.52.120] ([209.195.52.120]:29874 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261234AbUCRUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:49:19 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Date: Thu, 18 Mar 2004 12:49:12 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: sched_setaffinity usability
In-Reply-To: <20040318182407.GA1287@elte.hu>
Message-ID: <Pine.LNX.4.58.0403181248440.4976@dlang.diginsite.com>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu>
 <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
 <20040318182407.GA1287@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Ingo Molnar wrote:

> * Linus Torvalds <torvalds@osdl.org> wrote:
>
> > sysconf() is a user-level implementation issue, and so is something
> > like "number of CPU's". Damn, the simplest way to do it is as a
> > environment variable, for christ sake! Just make a magic environment
> > variable called __SC_ARRAY, and make it be some kind of binary
> > encoding if you worry about performance.
>
> i am not arguing for any sysconf() support at all - it clearly belongs
> into glibc. Just doing 'man sysconf' shows that it should be in
> user-space. No argument about that.
>
> But how about the original issue Ulrich raised: how does user-space
> figure out the NR_CPUS value supported by the kernel? (not the current #
> of CPUs, that can be figured out using /proc/cpuinfo)

Doesn't /proc/config.gz answer this question?

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
