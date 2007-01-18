Return-Path: <linux-kernel-owner+w=401wt.eu-S932664AbXARWds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbXARWds (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXARWds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:33:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40667 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbXARWdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:33:47 -0500
Date: Thu, 18 Jan 2007 22:33:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
Message-ID: <20070118223300.GA5404@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@osdl.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>
References: <20070117094454.GB19093@elte.hu> <Pine.LNX.4.44L0.0701171114040.2381-100000@iolanthe.rowland.org> <20070118001229.GA17257@infradead.org> <20070118073159.GA27233@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118073159.GA27233@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 08:31:59AM +0100, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > I'll be happy to move this over to the utrace setting, once it is 
> > > merged.  Do you think it would be better to include the current 
> > > version of kwatch now or to wait for utrace?
> > > 
> > > Roland, is there a schedule for when you plan to get utrace into 
> > > -mm?
> > 
> > Even if it goes into mainline soon we'll need a lot of time for all 
> > architectures to catch up, so I think kwatch should definitely comes 
> > first.
> 
> i disagree. Utrace is a once-in-a-lifetime opportunity to clean up the 
> /huge/ ptrace mess. Ptrace has been a very large PITA, for many, many 
> years, precisely because it was done in the 'oh, lets get this feature 
> added first, think about it later' manner. Roland's work is a large 
> logistical undertaking and we should not make it more complex than it 
> is. Once it's in we can add debugging features ontop of that. To me work 
> that cleans up existing mess takes precedence before work that adds to 
> the mess.

Utrace doesn't provide any kind of watchpoint infrastructure now, and
utrace will take a lot of time to get ready for inclusion, mostly because
it really needs asll the arch maintainers to help out (and various not
so easy core fixes aswell).

I'm all for merging utrace, and I wish we'd be much further into the
merging process already, but blocking mostly unrelated functionality for
it is more than dumb.


> ps. please fix your mailer to not emit those silly Mail-Followup-To 
> headers! It collapses To: and Cc: lines into one huge unnecessary To: 
> line.

This header is absolutely intentation as far too many folks seem to randomly
drop to or cc lines on mailing lists.  and of course it's alsmost esential
on lists with braindead reply to list policies (e.g. Debian)
