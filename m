Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272827AbTHKR1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272898AbTHKR1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:27:48 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:9374 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S272827AbTHKRYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:24:22 -0400
Date: Mon, 11 Aug 2003 10:23:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Larry McVoy <lm@bitmover.com>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030811172333.GA4879@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, Larry McVoy <lm@bitmover.com>,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37CF4E.3010605@pobox.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:15:58PM -0400, Jeff Garzik wrote:
> >	if (expr) statement;		// OK
> 
> The test and the statement run together visually, which is it is 
> preferred to put the statement on the following line.

Nah.  

	if (!p) return (whatever);
	if (foo) {
		statement;
	} else {
		statement;
		statement;
	}
	if (!p) return (whatever);

Perfectly readable.  We have a few hundred thousand lines of code written
like this and I review all of it.  I suspect that I do more reviewing than
99% of the people on this list which makes my opinion count more because
anything that makes my tired eyes absorb the info faster is a good thing.
Same for your eyes when you get to my age.  

I also make people do

	if ((a <= B) || (c >= d)) {
		xxx
	}

even though I know, if I think about it, what the precedence is.  It doesn't
matter that I know or you know, what matters is the number of lines of code
a day you can correctly review.  Anything that helps that means that you 
are helping people make the source base better.  Try reading 30K lines of 
diffs at one sitting and tell me again that I'm wrong.  If you do, bump it
up to 60K lines :)

> >	if (!pointer) return (-EINVAL);
> >
> >Short, sweet, readable, no worries.  
> 
> return is not a function ;-)

See, there is that age thing again.  Think V6.  And it is sort of a function,
it unravels the stack frame.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
