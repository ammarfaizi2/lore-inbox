Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbTIFSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 14:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTIFSR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 14:17:59 -0400
Received: from law10-oe23.law10.hotmail.com ([64.4.14.80]:61451 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261370AbTIFSR6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 14:17:58 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sat, 6 Sep 2003 14:17:47 -0400
Message-ID: <000101c374a3$2d2f9450$f40a0a0a@Aria>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1062867675.3754.0.camel@boobies.awol.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 06 Sep 2003 18:17:57.0449 (UTC) FILETIME=[32A23B90:01C374A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scratch that, I just found Ingo's patch.  My patch does essentially the same
thing except it only allows the current active process to be preempted if it
got demoted in priority during the effective priority recalculation.  This
IMHO is better because it doesn't do unnecessary context switches.  If the
process were truly a CPU hog relative other processes on the run queue, then
it'd get preempted eventually when it gets demoted rather than always every
25 ms.  How come Ingo's granular timeslice patch didn't get put into
2.6.0-test4?


John Yau

-----Original Message-----
From: Robert Love [mailto:rml@tech9.net] 
Sent: Saturday, September 06, 2003 1:01 PM
To: John Yau
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms


On Sat, 2003-09-06 at 05:46, John Yau wrote:

> I'm new to patch submission process, so bear with me.  This little 
> patch I
> wrote seems to get rid of the annoying skipping in xmms except in the most

> extreme cases.  See comments inlined in code for details of the fix.

This looks exactly like the granular timeslice patch Ingo did?

	Robert Love


