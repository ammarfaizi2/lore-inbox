Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312476AbSDJF5T>; Wed, 10 Apr 2002 01:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312465AbSDJF5S>; Wed, 10 Apr 2002 01:57:18 -0400
Received: from zero.tech9.net ([209.61.188.187]:46605 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312460AbSDJF5Q>;
	Wed, 10 Apr 2002 01:57:16 -0400
Subject: Re: nanosleep
From: Robert Love <rml@tech9.net>
To: mark manning <mark.manning@fastermail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020410044156.2881.qmail@fastermail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 01:57:16 -0400
Message-Id: <1018418240.908.225.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 00:41, mark manning wrote:

> thanx - how much of a difference should i expect - i know the syscall is
> asking for at least the required ammount but that the task switcher might
> not give me control back for a while after the requested delay but i was
> expecting to be a little closer to what i had asked for - this isnt critical
> of corse but i would like to know what to expect.

The minimum granularity of the timer is 1/HZ, which on a i386 is only
10ms.

If you want high-resolution timers, check out the high-res-timers
project at http://high-res-timers.sf.net/ - they implement POSIX timers
(which include a nanosleep call) with very high resolution (1/cpu
clock).

	Robert Love

