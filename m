Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUGIEt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUGIEt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUGIEt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:49:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:9126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264192AbUGIEtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:49:55 -0400
Date: Thu, 8 Jul 2004 21:48:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: nickpiggin@yahoo.com.au, pwil3058@bigpond.net.au,
       Alexander.Povolotsky@marconi.com, linux-kernel@vger.kernel.org,
       efault@gmx.de, rml@tech9.net, mingo@elte.hu, elladan@eskimo.com,
       cks@utcc.utoronto.ca
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum ) que
 stio n
Message-Id: <20040708214832.7d6b447c.akpm@osdl.org>
In-Reply-To: <cone.1089346699.970398.12519.502@pc.kolivas.org>
References: <313680C9A886D511A06000204840E1CF08F42FE6@whq-msgusr-02.pit.comms.marconi.com>
	<40EDD980.4040608@bigpond.net.au>
	<40EDF8F5.2060808@yahoo.com.au>
	<20040708185726.1c375176.akpm@osdl.org>
	<cone.1089346699.970398.12519.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Andrew Morton writes:
> 
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >>
> >> However well tested your scheduler might be, it needs several
> >>  orders of magnitude more testing ;) Maybe the best we can hope
> >>  for is compile time selectable alternatives.
> > 
> > At this stage in the kernel lifecycle, for something as fiddly as the CPU
> > scheduler we really should be 100% driven by problem reporting.
> > 
> > If someone can identify a particular misbehaviour in the CPU scheduler then
> > they should put their editor away and work to produce a solid testcase. 
> > Armed with that, we can then identify the source of the particular problem.
> > 
> > It is at this point, and no earlier, that we can decide what an appropriate
> > solution is.  We then balance the risk of that solution against the severity
> > of the problem which it solves and make a decision as to whether to proceed.
> > 
> > Right now, the ratio of quality bug reporting to scheduler patching is
> > bizarrely small.
> 
> Is "for fun" not reason enough?

Sure.   "For 2.7" is a good reason, too.

> I'm still keeping an eye out for firm "behavioural" bug reports on 2.6 and 
> would discuss or address them.

OK, thanks.

> Seriously the only reason I went down the rewrite path was to address 
> complaints about the complexity of the current design. It was also an 
> opportunity to start implementing some requested features. I certainly have 
> never suggested it should even be considered for 2.6.

Yeah, I tend to think that the CPU scheduler is currently 90% good enough,
and does seem to have become rather opaque.

I wouldn't mind having a new "for fun" scheduler in -mm, except there's
ongoing futzing with the current one to be sorted out.
