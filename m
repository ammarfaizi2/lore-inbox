Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbTCSCPI>; Tue, 18 Mar 2003 21:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbTCSCPI>; Tue, 18 Mar 2003 21:15:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:64173 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262914AbTCSCPH>;
	Tue, 18 Mar 2003 21:15:07 -0500
Date: Tue, 18 Mar 2003 20:31:25 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
Message-Id: <20030318203125.054b2704.akpm@digeo.com>
In-Reply-To: <3E77D107.30406@mvista.com>
References: <Pine.LNX.4.33.0303182123510.30255-100000@gans.physik3.uni-rostock.de>
	<3E77D107.30406@mvista.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 02:25:53.0421 (UTC) FILETIME=[DD6C0BD0:01C2EDBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> 
> 
> Here is a fix for the problem that eliminates the index from the 
> structure.  The index ALWAYS depends on the current value of 
> base->timer_jiffies in a rather simple way which is I exploit.  Either 
> patch works, but this seems much simpler...

Seems to be a nice change.  I think it would be better to get Tim's fix into
Linus's tree and let your rationalisation bake for a while in -mm.

There is currently a mysterious timer lockup happening on power4 machines. 
I'd like to keep these changes well-separated in time so we can get an
understanding of what code changes correlate with changed behaviour.

There are timer changes in Linus's post-2.5.65 tree and your patch generates
zillions of rejects against everything.  Can you send me a diff against
Linus's latest sometime?


