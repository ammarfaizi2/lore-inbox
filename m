Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWERJih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWERJih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWERJih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:38:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:40645 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751129AbWERJig convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:38:36 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: =?iso-8859-15?q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Thu, 18 May 2006 02:38:32 -0700
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
References: <200605121924.53917.dvhltc@us.ibm.com> <20060518084722.GA3343@elte.hu> <1147942687.4996.28.camel@frecb000686>
In-Reply-To: <1147942687.4996.28.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605180238.33044.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 01:58, Sébastien Dugué wrote:
> On Thu, 2006-05-18 at 10:47 +0200, Ingo Molnar wrote:
> > * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> > >   Darren,
> > >
> > > On Mon, 2006-05-15 at 18:30 -0700, Darren Hart wrote:
> > > > Following Ingo's example I have included the modified test case
> > > > (please see the original mail for librt.h) that starts the trace
> > > > before each sleep and disables it after we wake up.  If we have
> > > > missed a period, we print the trace.
> > >
> > >   Your test program fails (at least on my box) as the overhead of
> > > starting and stopping the trace in the 5 ms period is just too high.
> > >
> > >   By moving the latency_trace_start() at the start of the thread
> > > function and latency_trace_stop() at the end, everything runs fine. I
> > > did not have any period missed even under heavy load.
> >
> > could you send us the fixed testcase?
>
>   No problem, see attachment.

I found several similar problems in my original test case, please see my 
earlier mail from today where I included a completely rewritten test case 
with buffered output and new periodic logic.

The case attached here seems to try to print the trace without first stopping 
it.  I don't think that will result in the desired output.  My new test case 
addresses that issue as well.

I'd appreciate any feedback, thanks.

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
Phone: 503 578 3185
  T/L: 775 3185
