Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753713AbWKGSNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbWKGSNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbWKGSNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:13:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:39526 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1753713AbWKGSNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:13:13 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,397,1157353200"; 
   d="scan'208"; a="157593362:sNHT20142773"
Date: Tue, 7 Nov 2006 09:50:49 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, mm-commits@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061107095049.B3262@unix-os.sc.intel.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net> <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com> <20061107093112.A3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>; from clameter@sgi.com on Tue, Nov 07, 2006 at 09:55:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 09:55:54AM -0800, Christoph Lameter wrote:
> On Tue, 7 Nov 2006, Siddha, Suresh B wrote:
> 
> > Christoph, DECLARE_TASKLET that you had atleast needs to be per cpu.. 
> > Not sure if there are any other concerns.
> 
> Nope. Tasklets scheduled and executed per cpu. These are the former bottom 
> halves. See tasklet_schedule in kernel/softirq.c

You must be referring to __tasklet_schedule() ?

tasklet_schedule doesn't schedule if there is already one scheduled.

no?

thanks,
suresh
