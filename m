Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271820AbTHHTjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271826AbTHHTjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:39:40 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59783
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271820AbTHHTjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:39:35 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Date: Fri, 8 Aug 2003 15:41:52 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030728173045.19757A-100000@gatekeeper.tmr.com> <200307290800.24003.kernel@kolivas.org>
In-Reply-To: <200307290800.24003.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308081541.52569.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 18:00, Con Kolivas wrote:

> Agreed, and no doubt the smaller the timeslice the worse it is. I did a
> little experimenting with my P4 2.53 here and found that basically no
> matter how much longer the timeslice was there was continued benefit.
> However the benefit was diminishing the higher you got. If you graphed it
> out it was a nasty exponential curve up to 7ms and then there was a knee in
> the curve and it was virtually linear from that point on with only tiny
> improvements. A p3 933 behaved surprisingly similarly. That's why on
> 2.4.21-ck3 it was running with timeslice_granularity set to 10ms. However
> the round robin isn't as bad as pure timeslice limiting because if they're
> still on the active array I am led to believe there is less cache trashing.
>
> There was no answer in that but just thought I'd add what I know so far.
>
> Con

Fun.

Have you read the excellent DRAM series on ars technica?

http://www.arstechnica.com/paedia/r/ram_guide/ram_guide.part1-2.html
http://www.arstechnica.com/paedia/r/ram_guide/ram_guide.part2-1.html
http://www.arstechnica.com/paedia/r/ram_guide/ram_guide.part3-1.html

Sounds like you're thwacking into memory latency and bank switching and such.  
(Yes, you can thrash dram.  It's not as noticeable as with disk, but it's can 
be done.)

The memory bus speed will affect this a little bit, but it's not going to do 
to much for request turnaround time except make it proportionally even worse.  
Same for DDR. :)

Rob

