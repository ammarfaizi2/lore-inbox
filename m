Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVDCEWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDCEWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 23:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDCEWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 23:22:47 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:8407 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261356AbVDCEWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 23:22:45 -0500
Subject: Re: sched /HT processor
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY10-F5413AE1988EF69D4405392D93A0@phx.gbl>
References: <BAY10-F5413AE1988EF69D4405392D93A0@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 02 Apr 2005 23:22:25 -0500
Message-Id: <1112502145.27149.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 07:46 +0530, Arun Srinivas wrote:
> I attached the 'dmesg' output because there it shows that my kernel 
> recogonized 2 cpu's.As said earlier , are they treated as 2 physical cpu's 
> or logical cpu's?
> 

As I said, they are logical

[snip]

> > > available
> > > Apr  2 17:43:12 kulick2 kernel: CPU#1: Thermal monitoring enabled
> > > Apr  2 17:43:12 kulick2 kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz
> > > stepping 09
> > > Apr  2 17:43:12 kulick2 kernel: Total of 2 processors activated 
> >(11911.16
> > > BogoMIPS).
> > > Apr  2 17:43:12 kulick2 kernel: cpu_sibling_map[0] = 1
> > > Apr  2 17:43:12 kulick2 kernel: cpu_sibling_map[1] = 0
> >
> >Here you see that you have two CPUs.  0 is the sibling of 1 and 1 to 0.
> >This just shows that you have HT.  If you were to have a dual xeon, then
> >you would see 4 CPUs and two pairs.
> >
> >-- Steve
> >
> 

I'll elaborate more.  This says that you have a single CPU with
hyperthreading. That's what the siblings mean. That they share a single
physical CPU.
 
-- Steve


