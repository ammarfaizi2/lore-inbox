Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWFBUyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWFBUyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFBUyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:54:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:29825 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964905AbWFBUyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:54:00 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45246845:sNHT5684530565"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 13:53:53 -0700
Message-ID: <000001c68686$aadba9a0$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGLR7t0Z44Ab69TuiaGnaUm4TSVQAV5/QA
In-Reply-To: <200606022012.44866.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 3:13 AM
> On Friday 02 June 2006 19:53, Chen, Kenneth W wrote:
> > Yeah, but that is the worst case though.  Average would probably be a lot
> > lower than worst case.  Also, on smt it's not like the current logical cpu
> > is getting blocked because of another task is running on its sibling CPU.
> > The hardware still guarantees equal share of hardware resources for both
> > logical CPUs.
> 
> "Equal share of hardware resources" is exactly the problem; they shouldn't 
> have equal share since they're sharing one physical cpu's resources. It's a 
> relative breakage of the imposed nice support and I disagree with your 
> conclusion.


But you keep on missing the point that this only happens in the initial
stage of tasks competing for CPU resources.

If this is broken, then current smt nice is equally broken with the same
reasoning: once the low priority task gets scheduled, there is nothing
to kick it off the CPU until its entire time slice get used up.  They
compete equally with a high priority task running on the sibling CPU.

- Ken

