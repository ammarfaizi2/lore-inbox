Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422760AbWBNScB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbWBNScB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbWBNScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:32:01 -0500
Received: from fmr21.intel.com ([143.183.121.13]:50660 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422760AbWBNScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:32:00 -0500
Message-Id: <200602141831.k1EIVog26783@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Cc: <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Tue, 14 Feb 2006 10:31:49 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxZTiFr/lqF8LPSFaf+2LOMmjbwAALsM6w
In-Reply-To: <20060214124743.GA5586@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Tuesday, February 14, 2006 4:48 AM
> * Andrew Morton <akpm@osdl.org> wrote:
> > Ingo, what's your plan here?
> 
> I really dont like the sysctl hack. Firstly, which precise kernel 
> version was tested - do we know that it wasnt e.g. the smpnice 
> regression interfering? Secondly, i dont like the sysctl concept itself: 
> i really think we should try to find a way for _applications_ to be 
> woken up according to their workload.


Ingo, you have tried to come up with an algorithm, Nick tried equally,
and I have tried.  None of the "smart algorithms" works right now.  The
workload requirements are on two opposite end of spectrum.  If you do
one thing, it will hurt the other and vice versa.  I don't see a solution
other than a sysctl.  If you have implementation idea, I would be more
than happy to code it up and test. But I think we are really running dry
here.

- Ken

