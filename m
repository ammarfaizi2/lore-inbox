Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUGBAqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUGBAqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 20:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUGBAqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 20:46:07 -0400
Received: from holomorphy.com ([207.189.100.168]:42938 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265971AbUGBAqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 20:46:05 -0400
Date: Thu, 1 Jul 2004 17:45:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, paul@linuxaudiosystems.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040702004538.GF21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, mpm@selenic.com,
	paul@linuxaudiosystems.com, linux-kernel@vger.kernel.org
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040701180356.GI5414@waste.org> <20040701181401.GB21066@holomorphy.com> <20040701154554.30063e97.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701154554.30063e97.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 03:45:54PM -0700, Andrew Morton wrote:
> In fairness, the CPU scheduler has been spinning like a top for a
> couple of years, and it still ain't settled.
> That's just the one in Linus's tree, let alone the umpteen rewrites
> which are floating about.

I've not seen much deep material there. Policy tweaks seem to be
what's gone on in mainline, and frankly most of the purported rewrites
are just that. I guess the ones that nuked the duelling queue silliness
are trying qualify but even they're leaving the load balancer untouched
and are carrying over large fractions of their predecessors unaltered.
The stuff that's gone around looks minor. It's not like they're teaching
sched.c to play cpu tetris for gang scheduling or Kalman filtering
profiling feedback to stripe tasks using different cpu resources across
SMT siblings or playing graph games to meet RT deadlines, so it doesn't
look like very much at all is going on to me.

It's pretty obvious why everyone and their brother is grinding out
purported scheduler rewrites: the code is self-contained, however,
nothing interesting is coming of all this. Never been for have so many
patches been written against the same file, accomplishing so little.

-- wli
