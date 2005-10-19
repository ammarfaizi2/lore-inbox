Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVJSL47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVJSL47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJSL46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:56:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32472 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750827AbVJSL45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:56:57 -0400
Date: Wed, 19 Oct 2005 13:56:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_error thread exits in TASK_INTERRUPTIBLE state.
Message-ID: <20051019115653.GA2127@elte.hu>
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com> <1129693423.8910.54.camel@mindpipe> <1129695564.8910.64.camel@mindpipe> <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain> <Pine.LNX.4.58.0510190349590.20634@localhost.localdomain> <20051019113131.GA30553@infradead.org> <Pine.LNX.4.58.0510190751070.20634@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510190751070.20634@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 19 Oct 2005, Christoph Hellwig wrote:
> 
> > > +	/*
> > > +	 * There's a good chance that the loop will exit in the
> > > +	 * TASK_INTERRUPTIBLE state.
> > > +	 */
> > > +	__set_current_state(TASK_RUNNING);
> >
> > no need to comment the obvious.
> 
> So, should I resend the patch without the comment?

i guess so. OTOH, if it was so obvious, why did it stay unfixed for so 
long ;-)

	Ingo
