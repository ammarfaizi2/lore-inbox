Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVHVWZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVHVWZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVHVWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:25:21 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:19081 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751417AbVHVWZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:12 -0400
Date: Mon, 22 Aug 2005 09:58:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050822075843.GE19386@elte.hu>
References: <20050818060126.GA13152@elte.hu> <1124433586.5186.119.camel@localhost.localdomain> <1124456445.5186.124.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124456445.5186.124.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 2005-08-19 at 02:39 -0400, Steven Rostedt wrote:
> 
> > Ingo, can't you get rt.c to be more confusing. I mean it is too simple.
> > We need to add a few more underscores here and there :-)  Seriously,
> > that rt.c is mind boggling. It was nice before, now it is just screaming
> > for a cleanup (come now, do we really need the four underscores?).  Same
> > with latency.c. 
> 
> Ingo,
> 
> Here's one example of cleaning up rt.c.  I like an extra parameter 
> instead of having two functions that are exactly the same except for 
> one line.  I'll probably submit more.

it was done like that deliberately, so that the fastpath doesnt include 
conditional code. (when all debugging options are disabled)

	Ingo
