Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUBYRlC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbUBYRlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:41:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:4993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbUBYRk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:40:59 -0500
Message-Id: <200402251740.i1PHetn27447@mail.osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: reaim - 2.6.3-mm1 IO performance down. 
In-Reply-To: Your message of "Tue, 24 Feb 2004 17:03:37 PST."
             <20040224170337.798f5766.akpm@osdl.org> 
Date: Wed, 25 Feb 2004 09:40:55 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cliff white <cliffw@osdl.org> wrote:
> >
> > For the same test on the same machine, results from 2.6.2-rc1-mm2 and 2.6.2
> -rc3-mm1
> > were within 1.0% of the linux-2.6.2 runs. So this is new. 
> > 
> > More data and tests if requested - are there some patch sets we should try 
> reverting?
> 
> Thanks.  You could try reverting adaptive-lazy-readahead.patch.  If it is
> not that I'd be suspecting CPU scheduler changes.  Do you have uniprocessor
> test results?

I have them for 2.6.3-mm3, am re-running 2.6.3-mm1 right now.
Gross results are within 1%, but looking at the detail, i do see badness,
example:

Kernel    Users  Run time
2.6.3	  20     32.11
2.6.3-mm3 20     35.47

2.6.3	  40     63.64
2.6.3-mm2 40     66.33

Again, this shows up best on the bottom graph on the page.
Graphn of 2.6.3 vs 2.6.3-mm3 : 
http://developer.osdl.org/cliffw/reaim/compares/r_comp/2.6.3_vs_mm1_1cpu/index.html
cliffw

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
