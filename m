Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWBQC7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWBQC7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWBQC7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:59:05 -0500
Received: from fmr22.intel.com ([143.183.121.14]:16090 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751359AbWBQC7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:59:01 -0500
Date: Thu, 16 Feb 2006 18:58:38 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       npiggin@suse.de, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
Message-ID: <20060216185837.C27025@unix-os.sc.intel.com>
References: <43F3C9C6.5080606@bigpond.net.au> <20060216171357.A27025@unix-os.sc.intel.com> <43F53553.50904@bigpond.net.au> <43F53A42.2090909@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43F53A42.2090909@bigpond.net.au>; from pwil3058@bigpond.net.au on Fri, Feb 17, 2006 at 01:51:46PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 01:51:46PM +1100, Peter Williams wrote:
> Peter Williams wrote:
> > There's a rational argument (IMHO) that this patch should be applied 
> > even in the absence of the smpnice patches as it prevents 
> > active_load_balance() doing unnecessary work.  If this isn't good for 
> > hypo threading then hypo threading is a special case and needs to handle 
> > it as such.
> 
> OK.  The good news is that (my testing shows that) the "sched: fix 
> smpnice abnormal nice anomalies" fixes the imbalance problem and the 
> consequent CPU hopping.

Thats because find_busiest_group() is no longer showing the imbalance :)
Anyhow if I get time I will review this patch before I start my vacation.
Otherwise I assume Nick and Ingo will review this closely..

> BUT I still think that this patch (modified if necessary to handle any 
> HT special cases) should be applied.  On a normal system, it will (as 
> I've already said) stop active_load_balance() from doing a lot of 
> unnecessary work INCLUDING holding the run queue locks for TWO run 
> queues for no good reason.

Please see my earlier response to this..

thanks,
suresh
