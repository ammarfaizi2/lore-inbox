Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSANAzi>; Sun, 13 Jan 2002 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288516AbSANAza>; Sun, 13 Jan 2002 19:55:30 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29703 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288512AbSANAzY>; Sun, 13 Jan 2002 19:55:24 -0500
Date: Sun, 13 Jan 2002 19:55:14 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108163925.F1894@inspiron.school.suse.de>
Message-ID: <Pine.LNX.3.96.1020113194915.17441H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Andrea Arcangeli wrote:

> Note that some of them are bugfixes, without them an luser can hang the
> machine for several seconds on any box with some giga of ram by simple
> reading and writing into a large enough buffer. I think we never had
> time to care merging those bits into mainline yet and this is probably
> the main reason they're not integrated but it's something that should be
> in mainline IMHO.

Or just doing a large write while doing lots of reads... my personal
nemesis is "mkisofs" for backups, which reads lots of small files and
builds a CD image, which suddenly gets discovered by the kernel and
written, seemingly in a monolythic chunk. I MAY be able to improve this
with tuning the bdflush parameters, and I tried some tentative patches
which didn't make a huge gain.

I don't know if the solution lies in forcing write to start when a certain
size of buffers are queued regardless of percentages, or in better
scheduling of reads ahead of writes, or whatever.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

