Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968305AbWLEPjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968305AbWLEPjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968309AbWLEPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:39:15 -0500
Received: from mga03.intel.com ([143.182.124.21]:2389 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968305AbWLEPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:39:14 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,501,1157353200"; 
   d="scan'208"; a="154073490:sNHT41894559"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Christoph Lameter'" <clameter@sgi.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [-mm patch] sched remove lb_stopbalance counter
Date: Tue, 5 Dec 2006 07:38:54 -0800
Message-ID: <000101c71883$78e626c0$a884030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccYgucJtLom3vdaQt6HrIPDbBGF6AAABReA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20061205153224.GA3204@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Tuesday, December 05, 2006 7:32 AM
> * Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> > in -mm tree: I would like to revert the change on adding 
> > lb_stopbalance counter.  This count can be calculated by: lb_balanced 
> > - lb_nobusyg - lb_nobusyq.  There is no need to create gazillion 
> > counters while we can derive the value.  I'm more of against changing 
> > sched-stat format unless it is absolutely necessary as all user land 
> > tool parsing /proc/schedstat needs to be updated and it's a real pain 
> > trying to keep multiple versions of it.
> > 
> > Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> but, please:
> 
> > -#define SCHEDSTAT_VERSION 13
> > +#define SCHEDSTAT_VERSION 12
> 
> change this to 14 instead. Versions should only go upwards, even if we 
> revert to an earlier output format.

Really?  sched-decrease-number-of-load-balances.patch has not yet hit the
mainline and I think it's in -mm for only a couple of weeks.  I'm trying
to back out the change after brief reviewing the patch.

- Ken
