Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUKSNlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUKSNlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUKSNkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:40:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261412AbUKSNiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:38:24 -0500
Date: Fri, 19 Nov 2004 06:09:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz>, piggin@cyberone.com.au,
       chris@tebibyte.org, andrea@novell.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, riel@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041119080946.GA30845@logos.cnet>
References: <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org> <419CD8C1.4030506@ribosome.natur.cuni.cz> <20041118131655.6782108e.akpm@osdl.org> <419D25B5.1060504@ribosome.natur.cuni.cz> <419D2987.8010305@cyberone.com.au> <419D383D.4000901@ribosome.natur.cuni.cz> <20041118160824.3bfc961c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118160824.3bfc961c.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 04:08:24PM -0800, Andrew Morton wrote:
> Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
> >
> >   Anyway, plain 2.6.7 kills only the application asking for
> >  so much memory and logs via syslog:
> >  Out of Memory: Killed process 58888 (RNAsubopt)
> > 
> >    It's a lot better compared to what we have in 2.6.10-rc2,
> >  from my user's view.
> 
> We haven't made any changes to the oom-killer algorithm since July 2003. 
> Weird.

As Thomas Gleixner has investigated, the OOM killer selection is problematic.

When testing your ignore-page-referenced patch it first killed the memory hog
then shortly afterwards the shell I was running it on.

You've seen Thomas emails, he has nice description there.

