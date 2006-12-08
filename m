Return-Path: <linux-kernel-owner+w=401wt.eu-S1760054AbWLHU3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760054AbWLHU3k (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761174AbWLHU3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:29:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33615 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760054AbWLHU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:29:39 -0500
Date: Fri, 8 Dec 2006 12:29:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rocky Craig <rocky.craig@hp.com>
Cc: minyard@acm.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 11/12] IPMI: Fix BT long busy
Message-Id: <20061208122921.5c30d543.akpm@osdl.org>
In-Reply-To: <457962BF.5050202@hp.com>
References: <20061202043921.GG30531@localdomain>
	<20061203132636.a7ac969d.akpm@osdl.org>
	<457962BF.5050202@hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 06:03:59 -0700
Rocky Craig <rocky.craig@hp.com> wrote:

> Andrew Morton wrote:
> 
> >In fact, please don't write macros.
> >  
> >
> I see them all over the place (i.e., EXPORT_SYMBOL) so the request
> is a little confusing to me...

It's a general principle.  Sometimes they're unavoidable.  Other times they
are avoidable but people add them anyway.

> > Please don't write macros which require that the caller have a particular
> >
> >local variable of a particular name.
> >  
> >
> I could understand that, even if some people did agree with my desire
> to increase legibility by decreasing visual clutter.  I think it also 
> provides
> some protection against typos in argument lists.
> 
> I'm (naively) curious as to why it's being flagged now as opposed to
> two years ago when I submitted the original additions.

It probably didn't get noticed.  Some of the stuff we have in there is
unbelieveable.

> Have reviewers or review methods changed?
> 
> Have standards changed?

We have become more vigilant over time.

> Did it just slip under someone's radar two years ago?

I'd say so, yes.
