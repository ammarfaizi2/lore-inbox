Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTDYSbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTDYSbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:31:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40457 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263650AbTDYSa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:30:59 -0400
Date: Fri, 25 Apr 2003 14:14:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Timothy Miller <miller@techsource.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
In-Reply-To: <Pine.LNX.4.53.0304241244430.32333@chaos>
Message-ID: <Pine.LNX.3.96.1030425141133.16623E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Richard B. Johnson wrote:


> > Two alternatives:
> >
> > (a)     !!(x & 0x400)
> >
> > (b)     (x & 0x400) >> 10
> >
> 
> I meant return ((foo & MASK) && 1);
> 
> Try it, you'll like it! No shifts, no jumps.

Sorry, I still find !!(foo & MASK) easier to read, because !! is only used
to convert to boolean. Sort of a "boolean cast" in effect. It jumps out at
you what is intended.

Anyway, a matter of taste, both generate jumpless code.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

