Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271706AbTHRMQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTHRMOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:14:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:26343 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271420AbTHRMNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:13:34 -0400
Date: Mon, 18 Aug 2003 17:43:20 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O16int for interactivity
Message-ID: <20030818121319.GB1326@home.woodlands>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308160149.29834.kernel@kolivas.org> <20030818100853.GA1326@home.woodlands> <200308182030.52787.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308182030.52787.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [18-08-2003 17:04]:
> Thanks for report.
> 
> On Mon, 18 Aug 2003 20:08, Apurva Mehta wrote:
> > * Con Kolivas <kernel@kolivas.org> [15-08-2003 22:21]:
> > [snip]
> >
> > > Those who experienced starvation could you please test this patch.
> >
> > O16.1int on top of 2.6.0-test3-mm1 is an improvement over O15int but
> > it still has some issues. Sound skips and general unresponsiveness
> > occur under relatively light load. For example, scrolling a PDF in
> > acrobat sometimes results in 2-3 second skips in sound. Also, the PDF
> > continues to scroll long after I have left the scroll button. While
> > scrolling, if I try to switch to Firebird or some other relatively
> > heavy app, there is a noticeable delay before it comes up. Sometimes
> > even an xterm running mutt takes a second to show while a PDF is
> > scrolling.
>
>  Ah well acrobat reader does some very strange things, even stranger
> when it's a plugin in mozilla. A kernel profile while running it
> (like yours) shows mad virtual memory activity, not just
> rescheduling so apart from starving acrobat reader forcibly (or
> mozilla when acroread is the plugin) the scheduler can't help it an
> awful lot.

While acrobat's behaviour is the most pronounced, it is just one
example. Sound skips occur sometimes while switching tabs in firebird
as well. Inactive applications take longer to be redrawn. Your earlier
patches (O10 and O11int) were better in this respect.

I reported acrobat because it was the only app which I could provide
numbers for since its behaviour is consistent.

> Try opening pdfs in another pdf viewer and you'll see what I mean.

Hmm.. your right, things are a whole lot smoother in xpdf. 

> > I was doing a `make htmldocs` while scrolling the pdf. That is all. In
> > O15int, the same behaviour would occur even if there was _nothing_
> > else running (except the browser window and xmms ofcourse). That is
> > the only improvement I have noticed.
> >
> > I am attaching some numbers that were requested (vmstat, top and
> > readprofile outputs). These are generated from a script that was
> > posted here a few days ago. I am attaching the script so it is clear
> > what was done.
> >
> > While this script was running, I was basically scrolling a PDF and one
> > long skip in sound was heard while doing so. I also kept switching
> > between application windows.
> 
> The (priority inversion) starvation issue is being actively attended to in a 
> different way at the moment but acroread is a different beast again, and we 
> shall see.

Yes, I have been following the threads. 
 
> > Hope this helps.
> 
> Of course; any report contributes to the pool of information; thank you.

Your most welcome! And thank you for putting in so much work into the
scheduler.

Keep up the great work,

	- Apurva

--
Engineers motto: cheap, good, fast: choose any two
