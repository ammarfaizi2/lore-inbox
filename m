Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWCaJzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCaJzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWCaJzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:55:23 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:1669 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932067AbWCaJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:55:21 -0500
Date: Fri, 31 Mar 2006 11:48:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Paulo Marques <pmarques@grupopie.com>, Adrian Bunk <bunk@stusta.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
Message-ID: <20060331094851.GC14713@wohnheim.fh-wedel.de>
References: <4426515B.5040307@tlinx.org> <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr> <20060326100639.GE4053@stusta.de> <4427BCCC.4080506@tlinx.org> <4427CE4D.5010109@grupopie.com> <442C4ECF.3080505@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <442C4ECF.3080505@tlinx.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 March 2006 13:34:07 -0800, Linda Walsh wrote:
> 
> 1) It would be nice if a "stack usage" option could be turned on
> that would do some sort of run-time bounds checking that could
> display the max-stack used "so far" in "/proc".

Would CONFIG_DEBUG_STACK_USAGE=y do what you want?

> 2) How difficult would it be to place kernel stack in a "pageable" pool 
> where the limit of valid data in a 4K page is only 3.5K - then
> when a kernel routine tries to exceed the stack boundary, it takes a
> page fault where a "note" could be logged that more stack was "needed",
> then automatically map another 4K page into the stack and return to
> interrupted routine.

S390 has something a bit like that.  They can specify the stack limit
and get an exception when a function is trying to grow the stack
beyond the limit.  Martin Schwidefsky might know the details a bit
better.

Jörn

-- 
You ain't got no problem, Jules. I'm on the motherfucker. Go back in
there, chill them niggers out and wait for the Wolf, who should be
coming directly.
-- Marsellus Wallace
