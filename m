Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272858AbTHKRLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272909AbTHKRIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:08:05 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:48028 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S272898AbTHKRFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:05:30 -0400
Date: Mon, 11 Aug 2003 10:04:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Larry McVoy <lm@bitmover.com>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030811170425.GA4418@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, Larry McVoy <lm@bitmover.com>,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37CB44.5000307@pobox.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:58:44PM -0400, Jeff Garzik wrote:
> Larry McVoy wrote:
> >A few comments on why I don't like this patch:
> >    1) It's a formatting only patch.  That screws over people who are using
> >       BK for debugging, now when I double click on these changes I'll get
> >       to your cleanup patch, not the patch that was the last substantive
> >       change.
> 
> This is true, but at the same time, in Linux CodingStyle patches 
> culturally acceptable.  I think the general logic is just "don't go 
> overboard; reformat a tiny fragment at a time."

That ought to be balanced with "don't screw up the revision history, people
use it".  It's one thing to reformat code that is unreadable, for the most
part this code didn't come close to unreadable.

> at least don't run the damn lines together like
> 	if (test) foo else bar;
> 		or
> 	if (test) foo
> 	else bar;

I wasn't suggesting that.  I was saying

	if (expr) statement;		// OK

I was not endorsing this sort of unreadable crap:

	if (expr) statement; else statement;

The exception I was saying was reasonable is if you are doing something like

	if (!pointer) return (-EINVAL);

Short, sweet, readable, no worries.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
