Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRKSJO3>; Mon, 19 Nov 2001 04:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRKSJOT>; Mon, 19 Nov 2001 04:14:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59493 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S275743AbRKSJOI>; Mon, 19 Nov 2001 04:14:08 -0500
To: Ivanovich <ivanovich@menta.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can max. cache size be selected?
In-Reply-To: <Pine.LNX.4.30.0111190145510.766-100000@mustard.heime.net>
	<01111903121500.05756@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 01:55:08 -0700
In-Reply-To: <01111903121500.05756@localhost.localdomain>
Message-ID: <m1adxj87ir.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivanovich <ivanovich@menta.net> writes:

> I ask this because lowering the max. cache size could solve the problem that 
> some people have with too much memory going to swap and, in consequence, 
> making some apps unresponsive for a time
> 
> If max. cache size could be selected people who don't use much disk or just 
> need to work with a lot of apps at the same time (desktop?) could reduce it 
> to get better response when switching to inactive tasks who could have went 
> to swap to grow the cache...
> 
> am i wrong with my logic?

Linux is currently optimized for programs actually getting things done.  So
idle processes are penalized.  Getting fast responses from idle when the
system is under other kinds of load is an interesting problem.  A simple
limit on cache size really does not address the problem, and truly penalizes
cases when things are getting done.

The only simple solution I can think of attacking swap clustering to make it
more efficient.  In that case it may be possible to bring all data back from
swap in a single I/O transaction for a process.  Which should be quiet
efficient both when the processes is swapped out and when it is being
swapped in. 

> is this possible?

You have the source.

Eric
