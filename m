Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965606AbWKGRxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbWKGRxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWKGRxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:53:39 -0500
Received: from mga05.intel.com ([192.55.52.89]:42393 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932784AbWKGRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:53:37 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,397,1157353200"; 
   d="scan'208"; a="12786887:sNHT15673221"
Date: Tue, 7 Nov 2006 09:31:12 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, mm-commits@vger.kernel.org,
       nickpiggin@yahoo.com.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061107093112.A3262@unix-os.sc.intel.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net> <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>; from clameter@sgi.com on Tue, Nov 07, 2006 at 09:44:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 09:44:11AM -0800, Christoph Lameter wrote:
> On Tue, 7 Nov 2006, Ingo Molnar wrote:
> 
> > i'm not sure i get the point of this whole do-rebalance-in-tasklet idea. 
> > A tasklet is global to the system. The rebalance tick was per-CPU. This 
> > is not an equivalent change at all. What am i missing?
> 
> A tasklet runs per cpu. In many ways it is equivalent to an interrupt 
> context just interrupts are enabled.

Christoph, DECLARE_TASKLET that you had atleast needs to be per cpu.. 
Not sure if there are any other concerns.

thanks,
suresh
