Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbTEGQhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264070AbTEGQhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:37:09 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:51585 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264065AbTEGQhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:37:08 -0400
Date: Wed, 7 May 2003 18:49:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Torsten Landschoff <torsten@debian.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507164901.GB19324@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030507144736.GE8978@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 07:47:36 -0700, William Lee Irwin III wrote:
> On Wed, May 07, 2003 at 04:33:15PM +0200, Torsten Landschoff wrote:
> > Pardon my ignorance, but why is the kernel stack shrinked to just a few
> > kilobytes? With 256MB of RAM in a typical desktop system it shouldn't
> > be a problem to use 256KB from that as the stack, but I am sure there
> > are good reasons to shrink it. 
> > Just curious, thanks for any info
> 
> The kernel stack is (in Linux) unswappable memory that persists
> throughout the lifetime of a thread. It's basically how many threads
> you want to be able to cram into a system, and it matters a lot for
> 32-bit.

It also matters if people writing applications for embedded systems
have a fetish for many threads. 1000 threads, each eating 8k memory
for pure existance (no actual work done yet), do put some memory
pressure on small machines. Yes, it would be possible to educate those
people, but changing kernel code is more fun and less work.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
