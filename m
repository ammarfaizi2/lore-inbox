Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288784AbSAJMHn>; Thu, 10 Jan 2002 07:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288782AbSAJMHd>; Thu, 10 Jan 2002 07:07:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:65220 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288784AbSAJMHX>;
	Thu, 10 Jan 2002 07:07:23 -0500
Date: Thu, 10 Jan 2002 15:04:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201091517080.22941-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0201101502530.4885-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Mark Hahn wrote:

> > no wonder, it should be 'nice -n -20 vmstat -n 1'. And you should also do
>
> I keep a suid setrealtime wrapper around (UNSAFE!) for this kind of use:

nice -20 is an equivalent but safe version of the same (if you use my
patches). I made priority levels -20 ... -16 to be 'super-high priority',
ie. such tasks never expire. (they can still drop above prio -16 if they
use up too much CPU time, so they cannot lock up systems accidentally like
RT tasks.) So it's in essence a 'admin priority', for super-important
shells. I'm using it with great success.

	Ingo

