Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTAXGAZ>; Fri, 24 Jan 2003 01:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTAXGAZ>; Fri, 24 Jan 2003 01:00:25 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:57518
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267547AbTAXGAY>; Fri, 24 Jan 2003 01:00:24 -0500
Subject: Re: Using O(1) scheduler with 600 processes.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: mgross@unix-os.sc.intel.com
Cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200301240204.h0O24Kr04239@unix-os.sc.intel.com>
References: <1043367029.28748.130.camel@UberGeek>
	 <200301240204.h0O24Kr04239@unix-os.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043388479.12855.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 00:08:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-23 at 20:05, mgross wrote:
> You should definitely give it a try.
> 
> However; boosts in Oracle throughput by going to the O(1) scheduler may end 
> up being dependent on your I/O setup.
> 
> I was helping out with a TPCC benchmark effort last fall for Itanium Oracle 
> through put on Red Hat AS.  For the longest time the guys with the big iron 
> hardware would not move to the newer kernels with the O(1) scheduler.  They 
> had a silly rule of only accepting changes that improved TPCC throughput.  
> (oh, this work was on 4-way Itanium 2's with 32Gig of ram, and a large number 
> of clarion fiber channel disk array towers)

We've got LSI, so it's very similar.

> Anyway, for the longest time the old 2.4.18 kernel with the 4/10/04 ia-64 
> patch was 10% better than the a kernel with O(1) scheduler.  I never quite 
> figured out what the problem was.  I think the difference was in the way 
> Oracle likes to be on a Round Robbin scheduler, and the O(1) scheduler tended 
> to get unlucky more often than the old scheduler, for those drive arrays.
> 
> However; when we updated the clarion towers to have more drives and to 18K 
> RPM drives from the 15K drives, all of a sudden the O(1) scheduler beat the 
> the old scheduler.

Well, if I could get a clean patch against 2.4.20, or possibly some help
fixing the one  I do have, thanks to Ingo, then we'd have a straight
O(1) sched for 2.4.20. I tried merging the patch that Ingo gave me, and
everything seems OK, but I don't have any menu selection for O(1) stuff
in the kernel config.(0 and 100 priority bits)

So I can't tell if it's enabled. 


> Your milage will vary.
> 
> Give it a try.
> 
> --mgross
> 

I agree. In the interest of time, I may have to forego O(1), but maybe
I'll get lucky. :) *hint*hint* :)

TIA

--
GrandMasterLee
