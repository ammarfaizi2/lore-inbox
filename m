Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262989AbTC1OuW>; Fri, 28 Mar 2003 09:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbTC1OuW>; Fri, 28 Mar 2003 09:50:22 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:14591
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262989AbTC1OuV>; Fri, 28 Mar 2003 09:50:21 -0500
Date: Fri, 28 Mar 2003 09:57:56 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] reproducible smp_call_function/_interrupt cache
 update race.
In-Reply-To: <Pine.LNX.4.50.0303280051250.2884-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303280956530.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303280051250.2884-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Zwane Mwaikambo wrote:

> Hi
> 	I'm not quite sure how to describe this. I have a 3 Processor 
> Pentium 133 system which has been oopsing reliably (i have over 5 of 
> these oopses). What appears to be the problem is that the current memory 
> barrier in smp_call_function is a simple gcc anti optimisation barrier, we 
> really need a memory barrier there so that the other cpu's get the right 
> value when they get IPI'd immediately afterwards. The system was going 
> down reliably under my test load in under 5minutes, i have run with this 
> patch for;
> 
> 02:11:24  up 45 min,  5 users,  load average: 175.21, 174.89, 160.77

 11:00:31  up  8:29,  5 users,  load average: 2.06, 2.28, 2.33

And still going strong, it finally even completed the dbench 128 run 
(first time since 2.5.66 got released).

Linus please apply.

	Zwane
-- 
function.linuxpower.ca
