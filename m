Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWADMSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWADMSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWADMSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:18:53 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:18085 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030211AbWADMSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:18:52 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive response
Date: Wed, 4 Jan 2006 23:18:01 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43A8EF87.1080108@bigpond.net.au> <43BB2414.6060400@bigpond.net.au> <20060104094053.GA4577@dmt.cnet>
In-Reply-To: <20060104094053.GA4577@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042318.02028.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 20:40, Marcelo Tosatti wrote:
> We suspected that the TASK_INTERACTIVE() logic in kernel/sched.c would
> be moving some processes directly to the active list, thus starving some
> others. So we set the nice value of all 48 processes to "nice +19" to
> disable TASK_INTERACTIVE() and the starvation is gone. However with +19
> it becomes impossible to use the box interactively while the test runs,
> which is the case with the default "0" nice value.
>
> Are there significant changes between v2.6.11 -> v2.6.14 aimed at fixing
> this problem?

The SCHED_BATCH policy Ingo has implemented should help just such a problem.

Con
