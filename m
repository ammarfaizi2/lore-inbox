Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVFKA7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVFKA7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVFKA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:59:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28645 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261497AbVFKA7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:59:12 -0400
Date: Fri, 10 Jun 2005 17:59:35 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611005934.GM1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com> <20050608192853.GE1295@us.ibm.com> <42AA133D.1050102@lifl.fr> <20050610230433.GI1300@us.ibm.com> <42AA20F6.9030606@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42AA20F6.9030606@lifl.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 01:23:34AM +0200, Eric Piel wrote:
> 06/11/2005 01:04 AM, Paul E. McKenney wrote/a écrit:
> >>Just a small change to "1 - QoS":
> >>
> >>
> >>>b.	For each service:
> >>>
> >>>	i.	Probability of missing a deadline due to software,
> >>>		ranging from 0 to 1, with the value of 1 corresponding
> >>>		to the hardest possible hard realtime.
> >>
> >>I think it should be (by reference to how you define probability at the 
> >>beginning of the section):
> >>Probability of not missing any deadline due to software
> >
> >
> >Good catch!  How about the following?
> >
> >	i.      Probability of meeting a deadline due to software,
> >		ranging from 0 to 1, with the value of 1 corresponding
> >		to the hardest possible hard realtime.
> >
> >Changing "missing" in the original to "meeting".
> 
> It sounds strange to me (but english is not my mother tongue), it's like 
> hardware was not so good but software helped to recover the situation 
> and, eventually, the deadline was met ;-)

Hmmm...  It would appear that English's being my mother tongue is not
helping me as much as one might hope.  ;-)

> What about using the way you wrote it at the beginning of the section:
> "Probability of missing a deadline only because of a hardware failure"

Good point, I may just need to invert the whole thing, so that it
becomes something like:

	i.	Probability of missing a deadline due to software,
		ranging from 0 to 1, with the value of 0 corresponding
		to the hardest possible hard realtime.

But then the "p^n" becomes "1-(1-p)^n".  Bleah.

OK, how about the following?

	i.	Probability of meeting a deadline in absence of hardware
		failure, ranging from 0 to 1, with the value of 1
		corresponding to the hardest possible hard realtime.

							Thanx, Paul
