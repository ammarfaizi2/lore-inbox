Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTBYJKC>; Tue, 25 Feb 2003 04:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbTBYJKC>; Tue, 25 Feb 2003 04:10:02 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52358 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267859AbTBYJKB>;
	Tue, 25 Feb 2003 04:10:01 -0500
Date: Tue, 25 Feb 2003 15:09:08 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Make diskstats per-cpu using kmalloc_percpu
Message-ID: <20030225093908.GD28052@in.ibm.com>
References: <20030225073654.GB28052@in.ibm.com> <200302250828.h1P8S5s04503@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302250828.h1P8S5s04503@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:28:05AM -0800, Rick Lindsley wrote:
>     This version makes the disk stats on struct gendisk per-cpu.
>     I am working on making the per partition stats per-cpu too (struct
>     hd_struct).
> 
> In general I'm in favor of this.  It seems intuitive to me that counters
> of this type should be per-cpu.  But the question is, do we actually
> see any gains?  At the very least, are we sure we've not introduced any
> degradation?  Has any of your testing so far been measuring performance or
> just checking for correctness?

Tests on this patch have been for correctness.  However, we had done some
measurements sometime back (actually loong time back) to verify if we actually
saw any gains with similar statistics counters.  The results are at
http://lse.sourceforge.net/counters/statctr.html
Since, we already know that per-cpu counters are good from our experiments
earlier, I did not bother doing it for this patch.

 
