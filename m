Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTHRKYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 06:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTHRKYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 06:24:16 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:14977
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271362AbTHRKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 06:24:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O16int for interactivity
Date: Mon, 18 Aug 2003 20:30:52 +1000
User-Agent: KMail/1.5.3
References: <200308160149.29834.kernel@kolivas.org> <20030818100853.GA1326@home.woodlands>
In-Reply-To: <20030818100853.GA1326@home.woodlands>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182030.52787.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for report.

On Mon, 18 Aug 2003 20:08, Apurva Mehta wrote:
> * Con Kolivas <kernel@kolivas.org> [15-08-2003 22:21]:
> [snip]
>
> > Those who experienced starvation could you please test this patch.
>
> O16.1int on top of 2.6.0-test3-mm1 is an improvement over O15int but
> it still has some issues. Sound skips and general unresponsiveness
> occur under relatively light load. For example, scrolling a PDF in
> acrobat sometimes results in 2-3 second skips in sound. Also, the PDF
> continues to scroll long after I have left the scroll button. While
> scrolling, if I try to switch to Firebird or some other relatively
> heavy app, there is a noticeable delay before it comes up. Sometimes
> even an xterm running mutt takes a second to show while a PDF is
> scrolling.

Ah well acrobat reader does some very strange things, even stranger when it's 
a plugin in mozilla. A kernel profile while running it (like yours) shows mad 
virtual memory activity, not just rescheduling so apart from starving acrobat 
reader forcibly (or mozilla when acroread is the plugin) the scheduler can't 
help it an awful lot. Try opening pdfs in another pdf viewer and you'll see 
what I mean. 

> I was doing a `make htmldocs` while scrolling the pdf. That is all. In
> O15int, the same behaviour would occur even if there was _nothing_
> else running (except the browser window and xmms ofcourse). That is
> the only improvement I have noticed.
>
> I am attaching some numbers that were requested (vmstat, top and
> readprofile outputs). These are generated from a script that was
> posted here a few days ago. I am attaching the script so it is clear
> what was done.
>
> While this script was running, I was basically scrolling a PDF and one
> long skip in sound was heard while doing so. I also kept switching
> between application windows.

The (priority inversion) starvation issue is being actively attended to in a 
different way at the moment but acroread is a different beast again, and we 
shall see.

> Hope this helps.

Of course; any report contributes to the pool of information; thank you.

Con

