Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTJVOHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 10:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTJVOHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 10:07:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:6327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263681AbTJVOHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 10:07:53 -0400
Message-Id: <200310221407.h9ME7mM14401@mail.osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v16 - reaim
In-Reply-To: Your message of "Wed, 22 Oct 2003 11:43:31 +1000."
             <3F95E0C3.6050608@cyberone.com.au> 
Date: Wed, 22 Oct 2003 07:07:48 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> 
> >>I'm starting to do some large SMP / NUMA testing. Fixed and changed quite
> >>a bit. It isn't too bad, although I'm only testing dbench, tbench, and
> >>volanomark at the moment.
> >>
> >>These SMP and NUMA changes are not tied to my interactivity stuff, so its
> >>possible they could get included if they turn out well. If you find any
> >>problems with it (high end or interactivity), please let me know.
> >>

Results from reaim aren't encouraging.
patch was applied against 2.6.0-test8 - the result
is PLM #2232

STP id  kernal name       Max JPM   Max User Pct    elevator
281932	nick_v16          4923.08    60	     0.00   AS
281933	nick_v16          5196.06    68	     5.54   deadline
281722	linux-2.6.0-test8 5432.77    92	     9.38   deadline
281792	2.6.0-test8-mm1   5384.41    92	     8.56   deadline
281790	2.6.0-test8-mm1   5392.65    88      8.7    AS

The kernel doesn't perform well at larger user numbers.
Notice the different in max users.
Compare the graphs for jobs per minute, the usual graph
is quite flat, see:
http://khack.osdl.org/stp/281932/results/jpm.png

With the v16 scheduler, jobs per minute falls off rapidly
as user number increases giving graph with a steep slope, 
not good.
http://khack.osdl.org/stp/281790/results/jpm.png
Further results: http://www.developer.osdl.org/reaim/index.html

cliffw
