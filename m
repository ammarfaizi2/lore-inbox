Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVGSMgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVGSMgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGSMgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 08:36:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49046 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261978AbVGSMf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 08:35:56 -0400
Date: Tue, 19 Jul 2005 14:34:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Dave Chinner <dgc@sgi.com>,
       greg@kroah.com, Nathan Scott <nathans@sgi.com>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
Message-ID: <20050719123457.GC12368@elte.hu>
References: <20050714160835.GA19229@infradead.org> <Pine.OSF.4.05.10507171848440.14250-100000@da410.phys.au.dk> <20050719032624.GA22060@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719032624.GA22060@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> On Mon, Jul 18, 2005 at 02:10:31PM +0200, Esben Nielsen wrote:
> > Unfortunately, one of the goals of the preempt-rt branch is to avoid
> > altering too much code. Therefore the type semaphore can't be removed
> > there. Therefore the name still lingers ... :-(
> 
> This is where you failed. You assumed that that person making the 
> comment, Christopher, in the first place didn't have his head up his 
> ass in the first place and was open to your end of the discussion.

please take me off the Cc: list for such kind of replies. Christoph is 
very much entitled to his opinion, which i happen to mostly share in 
this case: we should not be bothering upstream with requirements unique 
to PREEMPT_RT. PREEMPT_RT restricts struct semaphore to be a mutex, and 
that doesnt make it a classic semaphore anymore. We had no other choice 
but it's still somewhat unclean in that regard.

(I do disagree with Christoph on another point: i do think we eventually 
want to change the standard semaphore type in a similar fashion upstream 
as well - but that probably has to come with a s/struct semaphore/struct 
mutex/ change as well.)

	Ingo
