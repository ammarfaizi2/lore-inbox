Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVCXVRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVCXVRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVCXVRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:17:42 -0500
Received: from fmr23.intel.com ([143.183.121.15]:57550 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261516AbVCXVRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:17:12 -0500
Message-Id: <200503242116.j2OLGwg07920@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: re-inline sched functions
Date: Thu, 24 Mar 2005 13:16:58 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUmHSnA1AaWf6w4SiCCPMSE/Sx0OgAS0ADQApN2z8A=
In-Reply-To: 
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

Chen, Kenneth W wrote on Friday, March 11, 2005 10:40 AM
> OK, I'll re-measure. Yeah, I agree that this function is not in the fastpath.

Ingo is right, re-measured on our benchmark setup and did not see any
difference whether task_timeslice is inlined or not.  So if people want
to take inline keyword out for that function, we won't complain :-)


