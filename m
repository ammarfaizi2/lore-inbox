Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVCKSqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVCKSqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVCKSoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:44:55 -0500
Received: from fmr21.intel.com ([143.183.121.13]:65410 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261320AbVCKSju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:39:50 -0500
Message-Id: <200503111839.j2BIdeg14585@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: re-inline sched functions
Date: Fri, 11 Mar 2005 10:39:41 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUmHSnA1AaWf6w4SiCCPMSE/Sx0OgAS0ADQ
In-Reply-To: <20050311093132.GA19954@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Friday, March 11, 2005 1:32 AM
> > -static unsigned int task_timeslice(task_t *p)
> > +static inline unsigned int task_timeslice(task_t *p)
>
> the patch looks good except this one - could you try to undo it and
> re-measure? task_timeslice() is not used in any true fastpath, if it
> makes any difference then the performance difference must be some other
> artifact.

OK, I'll re-measure. Yeah, I agree that this function is not in the fastpath.


