Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWADMbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWADMbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWADMbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:31:12 -0500
Received: from hera.kernel.org ([140.211.167.34]:55183 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030217AbWADMbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:31:11 -0500
Date: Wed, 4 Jan 2006 08:31:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive response
Message-ID: <20060104103115.GA6181@dmt.cnet>
References: <43A8EF87.1080108@bigpond.net.au> <43BB2414.6060400@bigpond.net.au> <20060104094053.GA4577@dmt.cnet> <200601042318.02028.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601042318.02028.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 11:18:01PM +1100, Con Kolivas wrote:
> On Wednesday 04 January 2006 20:40, Marcelo Tosatti wrote:
> > We suspected that the TASK_INTERACTIVE() logic in kernel/sched.c would
> > be moving some processes directly to the active list, thus starving some
> > others. So we set the nice value of all 48 processes to "nice +19" to
> > disable TASK_INTERACTIVE() and the starvation is gone. However with +19
> > it becomes impossible to use the box interactively while the test runs,
> > which is the case with the default "0" nice value.
> >
> > Are there significant changes between v2.6.11 -> v2.6.14 aimed at fixing
> > this problem?
> 
> The SCHED_BATCH policy Ingo has implemented should help just such a problem.

Yeap, he sent me the patch (which I promised to test), but still haven't. 

Will do ASAP.

