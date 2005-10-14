Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVJNSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVJNSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVJNSC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:02:28 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:45019 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1750805AbVJNSC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:02:28 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051014061546.GA30319@elte.hu>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <20051012061455.GA16586@elte.hu> <20051012071037.GA19018@elte.hu>
	 <1129242595.4623.14.camel@cmn3.stanford.edu>
	 <1129256936.11036.4.camel@cmn3.stanford.edu>
	 <20051014045615.GC13595@elte.hu>  <20051014061546.GA30319@elte.hu>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 11:01:46 -0700
Message-Id: <1129312907.19449.13.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 08:15 +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > could you try:
> > 
> > 	strace -o log sleep 10
> > 
> > and wait for a failure, and send us the log? Is it perhaps nanosleep 
> > unexpectedly returning with -EAGAIN or -512? There's a transient 
> > nanosleep failure that happens on really fast boxes, which we havent 
> > gotten to the bottom yet. That problem is very sporadic, but maybe 
> > your box is just too fast and triggers it more likely :-)
> 
> is nanosleep returning -ERESTART_RESTARTBLOCK (-516) perhaps?

Yes, that is probably correct, I saw a few of these:
  sleep: cannot read realtime clock: Unknown error 516

I left the kernel running overnight and this morning I've been using it
with no key repeats or screen blanks so far. Go figure. I imagine they
would come back if I reboot. I'm still seeing the Jack warnings but
that's probably a related but somewhat separate issue. 

I'm building rt5 and will report later. 

-- Fernando


