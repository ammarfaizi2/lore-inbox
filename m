Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTEGRer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTEGRer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:34:47 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:38037 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264075AbTEGReq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:34:46 -0400
Date: Wed, 7 May 2003 19:47:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Torsten Landschoff <torsten@debian.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507174716.GE19324@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507164901.GB19324@wohnheim.fh-wedel.de> <20030507173825.GU8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030507173825.GU8931@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 10:38:25 -0700, William Lee Irwin III wrote:
> On Wed, May 07, 2003 at 06:49:01PM +0200, J?rn Engel wrote:
> > It also matters if people writing applications for embedded systems
> > have a fetish for many threads. 1000 threads, each eating 8k memory
> > for pure existance (no actual work done yet), do put some memory
> > pressure on small machines. Yes, it would be possible to educate those
> > people, but changing kernel code is more fun and less work.
> 
> If they're embedded and UP they can probably get by on a userspace
> threading library that only creates one kernel thread.
> 
> It's highly unlikely anyone will get anywhere "fixing" this in the
> kernel. The closest approximations to mitigating the pinned memory
> overhead with UNIX-style kernel semantics are swappable stacks a la the
> u area and M:N threading, neither of which are popular notions. If
> you're trying the other approach I mentioned in this thread, good luck
> ever getting it done and good luck ever surviving even a single merge.
> 
> $ grep -nr schedule . | wc -l
>    3773

Ah, now I see where the misunderstanding comes from. My bad.
I would merely like to save NO_THREADS * 4k, not the full 8k. People
here are migrating from Readtime OS's to Linux, partially and I
wouldn't think about introducing hard priorities into the scheduler
either. "This is plain impossible." is a very good argument for
education. "This only works under certain conditions." is where people
always demand more, sometimes rightfully, sometimes not.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
