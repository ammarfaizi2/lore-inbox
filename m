Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271807AbTG2OH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271816AbTG2OH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:07:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53934 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S271807AbTG2OHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:07:17 -0400
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case 
To: Erich Focht <efocht@hpce.nec.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF607D10C6.EC89E09C-ON87256D72.004CBCAE@us.ibm.com>
From: Mala Anand <manand@us.ibm.com>
Date: Tue, 29 Jul 2003 09:06:14 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0.1 [IBM]|June 10, 2003) at
 07/29/2003 08:06:15
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






>> If you want data supporting my assumptions: Ted Ts'o's talk at OLS
>> shows the necessity to rebalance ASAP (even in try_to_wake_up).

>If this is the patch I am thinking of, it was the (attached) one I sent
them,
>which did a light "push" rebalance at try_to_wake_up.  Calling
load_balance
>at try_to_wake_up seems very heavy-weight.  This patch only looks for an
idle
>cpu (within the same node) to wake up on before task activation, only if
the
>task_rq(p)->nr_running is too long.  So, yes, I do believe this can be
>important, but I think it's only called for when we have an idle cpu.

The patch that you sent to Rajan didn't yield any improvement on
specjappserver so we did not include that  in the ols paper. What
is described in the ols paper is "calling load-balance" from
try-to-wake-up. Both calling load-balance from try-to-wakeup and
the "light push" rebalance at try_to_wake_up are already done in
Andrea's 0(1) scheduler patch.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088


