Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTBULN7>; Fri, 21 Feb 2003 06:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTBULN7>; Fri, 21 Feb 2003 06:13:59 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:47493 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267337AbTBULN6>;
	Fri, 21 Feb 2003 06:13:58 -0500
Date: Fri, 21 Feb 2003 12:23:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
Message-ID: <20030221112347.GR31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com> <20030220212758.5064927f.akpm@digeo.com> <20030221104028.GO31480@x30.school.suse.de> <3E560584.1040406@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E560584.1040406@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 09:55:00PM +1100, Nick Piggin wrote:
> There is actually a point when you have a number of other IO streams
> going on where your decreased throughput means *maximum* latency goes
> up because robin doesn't go round fast enough. I guess desktop loads

this is why it would be nice to set a prctl in the task structure that
defines the latency sensitive tasks, so you could leave enabled the CFQ
always and only xmms and mplayer would take advantage of it (unless you
run then with --skip-frame-is-ok). CFQ in function of pid is the simpler
closer transparent approximation of that.

Andrea
