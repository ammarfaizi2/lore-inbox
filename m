Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317664AbSFRXHJ>; Tue, 18 Jun 2002 19:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317665AbSFRXHI>; Tue, 18 Jun 2002 19:07:08 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:58259 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317664AbSFRXHG>; Tue, 18 Jun 2002 19:07:06 -0400
Date: Wed, 19 Jun 2002 00:46:52 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace timer_bh with tasklet
Message-ID: <20020619004652.D2079@linux-m68k.org>
References: <Pine.LNX.4.44.0206172104450.1164-100000@home.transmeta.com> <3D0F76E4.AC6EA257@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0F76E4.AC6EA257@mvista.com>; from george@mvista.com on Tue, Jun 18, 2002 at 11:07:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 11:07:32AM -0700, george anzinger wrote:

> 
> I reasoned that the timers, unlike most other I/O, directly drive the system.  
> For example, the time slice is counted down by the timer BH.  By pushing the 
> timer out to ksoftirqd, running at nice 19, you open the door to a compute 
> bound task running over its time slice (admittedly this should be caught on 
> the next interrupt).

I have had some problems with timers delayed up to 0.06s in 2.4 kernels,
could that be this problem?

Richard


