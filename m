Return-Path: <linux-kernel-owner+w=401wt.eu-S1751934AbXARHeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbXARHeJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXARHeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:34:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38577 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbXARHeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:34:07 -0500
Date: Thu, 18 Jan 2007 08:31:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
Message-ID: <20070118073159.GA27233@elte.hu>
References: <20070117094454.GB19093@elte.hu> <Pine.LNX.4.44L0.0701171114040.2381-100000@iolanthe.rowland.org> <20070118001229.GA17257@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118001229.GA17257@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0360]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > I'll be happy to move this over to the utrace setting, once it is 
> > merged.  Do you think it would be better to include the current 
> > version of kwatch now or to wait for utrace?
> > 
> > Roland, is there a schedule for when you plan to get utrace into 
> > -mm?
> 
> Even if it goes into mainline soon we'll need a lot of time for all 
> architectures to catch up, so I think kwatch should definitely comes 
> first.

i disagree. Utrace is a once-in-a-lifetime opportunity to clean up the 
/huge/ ptrace mess. Ptrace has been a very large PITA, for many, many 
years, precisely because it was done in the 'oh, lets get this feature 
added first, think about it later' manner. Roland's work is a large 
logistical undertaking and we should not make it more complex than it 
is. Once it's in we can add debugging features ontop of that. To me work 
that cleans up existing mess takes precedence before work that adds to 
the mess.

	Ingo

ps. please fix your mailer to not emit those silly Mail-Followup-To 
headers! It collapses To: and Cc: lines into one huge unnecessary To: 
line.
